import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:crypto/crypto.dart' as crypto;

class EncryptionService {
  static const int _mekLength = 32;
  static const int _nonceLength = 24;
  static const int _saltLength = 32;
  static const int _blindIndexLength = 16;

  final Xchacha20 _cipher = Xchacha20.poly1305Aead();

  Future<MasterEncryptionKey> deriveMasterKey({
    required String passphrase,
    Uint8List? salt,
    int? iterations,
  }) async {
    salt ??= _generateRandomBytes(_saltLength);
    iterations ??= _calibrateIterations();

    final kdf = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: iterations,
      bits: _mekLength * 8,
    );

    final secretKey = await kdf.deriveKey(
      secretKey: SecretKey(utf8.encode(passphrase)),
      nonce: salt,
    );

    final keyBytes = await secretKey.extractBytes();

    return MasterEncryptionKey(
      key: Uint8List.fromList(keyBytes),
      salt: salt,
      iterations: iterations,
    );
  }

  Future<WrappedMasterKey> wrapMasterKey({
    required Uint8List mek,
    required Uint8List kek,
  }) async {
    final nonce = _generateRandomBytes(_nonceLength);
    final secretKey = SecretKey(kek.toList());

    final secretBox = await _cipher.encrypt(
      mek.toList(),
      secretKey: secretKey,
      nonce: nonce.toList(),
    );

    return WrappedMasterKey(
      nonce: nonce,
      ciphertext: Uint8List.fromList(secretBox.cipherText),
      mac: Uint8List.fromList(secretBox.mac.bytes),
    );
  }

  Future<Uint8List> unwrapMasterKey({
    required WrappedMasterKey wrapped,
    required Uint8List kek,
  }) async {
    final secretKey = SecretKey(kek.toList());
    final secretBox = SecretBox(
      wrapped.ciphertext.toList(),
      nonce: wrapped.nonce.toList(),
      mac: Mac(wrapped.mac.toList()),
    );

    final plaintext = await _cipher.decrypt(secretBox, secretKey: secretKey);
    return Uint8List.fromList(plaintext);
  }

  Future<EncryptedData> encryptLabel({
    required String plaintext,
    required Uint8List mek,
    required String labelId,
    required String algo,
    required int version,
    required int keyVersion,
  }) async {
    final aeadKey = await _deriveAeadKey(mek);
    final nonce = _generateRandomBytes(_nonceLength);

    final aad = _computeAad(
      id: labelId,
      algo: algo,
      version: version,
      keyVersion: keyVersion,
    );

    final secretKey = SecretKey(aeadKey.toList());
    final secretBox = await _cipher.encrypt(
      utf8.encode(plaintext),
      secretKey: secretKey,
      nonce: nonce.toList(),
      aad: aad,
    );

    return EncryptedData(
      nonce: nonce,
      ciphertext: Uint8List.fromList(secretBox.cipherText),
      mac: Uint8List.fromList(secretBox.mac.bytes),
    );
  }

  Future<String> decryptLabel({
    required EncryptedData encrypted,
    required Uint8List mek,
    required String labelId,
    required String algo,
    required int version,
    required int keyVersion,
  }) async {
    final aeadKey = await _deriveAeadKey(mek);

    final aad = _computeAad(
      id: labelId,
      algo: algo,
      version: version,
      keyVersion: keyVersion,
    );

    final secretKey = SecretKey(aeadKey.toList());
    final secretBox = SecretBox(
      encrypted.ciphertext.toList(),
      nonce: encrypted.nonce.toList(),
      mac: Mac(encrypted.mac.toList()),
    );

    final plaintext = await _cipher.decrypt(
      secretBox,
      secretKey: secretKey,
      aad: aad,
    );

    return utf8.decode(plaintext);
  }

  Uint8List computeBlindIndex({
    required String value,
    required Uint8List mek,
    required String field,
    required String? origin,
  }) {
    final normalized = _normalizeForIndex(value, field);
    final key = _deriveIndexKey(mek, field, origin);
    final hmac = crypto.Hmac(crypto.sha256, key);
    final digest = hmac.convert(utf8.encode(normalized));
    return Uint8List.fromList(digest.bytes.take(_blindIndexLength).toList());
  }

  Uint8List computeOriginIndex({
    required String origin,
    required Uint8List mek,
  }) {
    final normalized = _normalizeOrigin(origin);
    final key = _deriveOriginKey(mek);
    final hmac = crypto.Hmac(crypto.sha256, key);
    final digest = hmac.convert(utf8.encode(normalized));
    return Uint8List.fromList(digest.bytes.take(_blindIndexLength).toList());
  }

  List<Uint8List> computeTokenHashes({
    required String label,
    required Uint8List mek,
    required String? origin,
  }) {
    final normalized = _normalizeLabel(label);
    final tokens = _tokenizeLabel(normalized);
    final key = _deriveIndexKey(mek, 'label', origin);

    return tokens.map((token) {
      final hmac = crypto.Hmac(crypto.sha256, key);
      final digest = hmac.convert(utf8.encode(token));
      return Uint8List.fromList(digest.bytes.take(_blindIndexLength).toList());
    }).toList();
  }

  Uint8List _generateRandomBytes(int length) {
    // Use Dart's built-in secure random
    final random = Random.secure();
    final bytes = Uint8List(length);
    for (int i = 0; i < length; i++) {
      bytes[i] = random.nextInt(256);
    }
    return bytes;
  }

  Future<Uint8List> _deriveAeadKey(Uint8List mek) async {
    // Use simpler key derivation for now
    final hmac = crypto.Hmac(crypto.sha256, mek);
    final digest = hmac.convert(utf8.encode('bip329/aead-v1'));
    return Uint8List.fromList(digest.bytes);
  }

  Uint8List _deriveOriginKey(Uint8List mek) {
    final hkdf = HkdfBigInt(
      hashAlgorithm: crypto.sha256,
      salt: Uint8List(0),
    );

    return hkdf.derive(
      ikm: mek,
      info: utf8.encode('bip329/index:origin'),
      length: 32,
    );
  }

  Uint8List _deriveIndexKey(Uint8List mek, String field, String? origin) {
    final normalizedOrigin = origin != null ? _normalizeOrigin(origin) : '';
    final info = 'bip329/index:$field:$normalizedOrigin';

    final hkdf = HkdfBigInt(
      hashAlgorithm: crypto.sha256,
      salt: Uint8List(0),
    );

    return hkdf.derive(
      ikm: mek,
      info: utf8.encode(info),
      length: 32,
    );
  }

  List<int> _computeAad({
    required String id,
    required String algo,
    required int version,
    required int keyVersion,
  }) {
    final aadMap = {
      'id': id,
      'algo': algo,
      'version': version,
      'keyVersion': keyVersion,
    };
    return utf8.encode(json.encode(aadMap));
  }

  String _normalizeForIndex(String value, String field) {
    switch (field) {
      case 'type':
      case 'ref':
        return value.toLowerCase().trim();
      case 'label':
        return _normalizeLabel(value);
      default:
        return value.toLowerCase().trim();
    }
  }

  String _normalizeOrigin(String origin) {
    return origin.toLowerCase().trim();
  }

  String _normalizeLabel(String label) {
    return label
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  List<String> _tokenizeLabel(String normalizedLabel) {
    return normalizedLabel
        .split(' ')
        .where((token) => token.isNotEmpty)
        .toList();
  }

  int _calibrateIterations() {
    // Return a reasonable default for testing
    // In production, this could be calibrated or made configurable
    return 100000;
  }
}

class MasterEncryptionKey {
  final Uint8List key;
  final Uint8List salt;
  final int iterations;

  const MasterEncryptionKey({
    required this.key,
    required this.salt,
    required this.iterations,
  });
}

class WrappedMasterKey {
  final Uint8List nonce;
  final Uint8List ciphertext;
  final Uint8List mac;

  const WrappedMasterKey({
    required this.nonce,
    required this.ciphertext,
    required this.mac,
  });
}

class EncryptedData {
  final Uint8List nonce;
  final Uint8List ciphertext;
  final Uint8List mac;

  const EncryptedData({
    required this.nonce,
    required this.ciphertext,
    required this.mac,
  });
}

class HkdfBigInt {
  final crypto.Hash hashAlgorithm;
  final Uint8List salt;

  HkdfBigInt({
    required this.hashAlgorithm,
    Uint8List? salt,
  }) : salt = salt ?? Uint8List(hashAlgorithm.blockSize);

  Uint8List derive({
    required Uint8List ikm,
    required List<int> info,
    required int length,
  }) {
    final hmac = crypto.Hmac(hashAlgorithm, salt);
    final prk = hmac.convert(ikm).bytes;

    final hashLength = hashAlgorithm.blockSize ~/ 2;
    final n = (length + hashLength - 1) ~/ hashLength;

    final okm = BytesBuilder();
    var previousBlock = <int>[];

    for (var i = 1; i <= n; i++) {
      final hmac2 = crypto.Hmac(hashAlgorithm, prk);
      final block = BytesBuilder()
        ..add(previousBlock)
        ..add(info)
        ..addByte(i);

      final hash = hmac2.convert(block.toBytes());
      previousBlock = hash.bytes;
      okm.add(hash.bytes);
    }

    return Uint8List.fromList(okm.toBytes().take(length).toList());
  }
}