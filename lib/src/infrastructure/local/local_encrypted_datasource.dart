import 'dart:convert';
import 'dart:math';
import 'package:drift/drift.dart';
import 'simple_label_entity.dart';
import 'crypto/encryption_service.dart';
import 'database/labels_database.dart';

class LocalEncryptedDatasource {
  final LabelsDatabase _database;
  final EncryptionService _encryptionService;
  final String passphrase;
  Uint8List? _mek;

  LocalEncryptedDatasource({
    required this.passphrase,
    String? dbPath,
    LabelsDatabase? database,
    EncryptionService? encryptionService,
  })  : _database = database ?? LabelsDatabase(filePath: dbPath),
        _encryptionService = encryptionService ?? EncryptionService();

  Future<void> initialize() async {
    final keyring = await _database.getKeyring();

    if (keyring == null) {
      final masterKey = await _encryptionService.deriveMasterKey(
        passphrase: passphrase,
      );

      final kek = masterKey.key;
      _mek = _generateRandomMek();

      final wrapped = await _encryptionService.wrapMasterKey(
        mek: _mek!,
        kek: kek,
      );

      await _database.insertOrUpdateKeyring(
        KeyringCompanion(
          id: const Value('default'),
          kdfSalt: Value(masterKey.salt),
          kdfIterations: Value(masterKey.iterations),
          mekNonce: Value(wrapped.nonce),
          mekCiphertext: Value(wrapped.ciphertext),
          mekMac: Value(wrapped.mac),
        ),
      );
    } else {
      final masterKey = await _encryptionService.deriveMasterKey(
        passphrase: passphrase,
        salt: keyring.kdfSalt,
        iterations: keyring.kdfIterations,
      );

      final wrapped = WrappedMasterKey(
        nonce: keyring.mekNonce,
        ciphertext: keyring.mekCiphertext,
        mac: keyring.mekMac,
      );

      try {
        _mek = await _encryptionService.unwrapMasterKey(
          wrapped: wrapped,
          kek: masterKey.key,
        );
      } catch (e) {
        throw Exception(
          'Failed to decrypt database with provided passphrase. '
          'Either the passphrase is incorrect, or the database was created '
          'with a different passphrase. Original error: $e'
        );
      }
    }
  }

  Future<void> _ensureInitialized() async {
    if (_mek == null) {
      await initialize();
    }
  }

  Future<List<SimpleLabelEntity>> getAllLabels() async {
    await _ensureInitialized();

    final encryptedLabels = await _database.getAllEncryptedLabels();
    final labels = <SimpleLabelEntity>[];

    for (final encrypted in encryptedLabels) {
      try {
        final decrypted = await _decryptLabel(encrypted);
        labels.add(decrypted);
      } catch (e) {
        print('Failed to decrypt label ${encrypted.id}: $e');
      }
    }

    return labels;
  }

  Future<SimpleLabelEntity?> findExactLabel(SimpleLabelEntity searchLabel) async {
    await _ensureInitialized();

    final encryptedLabels = await _queryLabels(
      type: searchLabel.type.bip329Type,
      ref: searchLabel.ref,
      label: searchLabel.label,
      origin: searchLabel.origin,
    );

    for (final encrypted in encryptedLabels) {
      try {
        final decrypted = await _decryptLabel(encrypted);
        if (_isExactMatch(decrypted, searchLabel)) {
          return decrypted;
        }
      } catch (e) {
        print('Failed to decrypt label ${encrypted.id}: $e');
      }
    }

    return null;
  }

  Future<SimpleLabelEntity> addLabel(SimpleLabelEntity label) async {
    await _ensureInitialized();

    final id = _generateLabelId();
    final encrypted = await _encryptLabel(label, id);

    final tokenHashes = label.label != null
        ? _encryptionService.computeTokenHashes(
            label: label.label!,
            mek: _mek!,
            origin: label.origin,
          )
        : <Uint8List>[];

    await _database.insertEncryptedLabel(encrypted, tokenHashes);

    return label;
  }

  Future<void> updateLabel({
    required SimpleLabelEntity labelToUpdate,
    required SimpleLabelEntity updatedLabel,
  }) async {
    await _ensureInitialized();

    final existing = await findExactLabel(labelToUpdate);
    if (existing == null) {
      throw Exception('Label not found');
    }

    final encryptedLabels = await _queryLabels(
      type: labelToUpdate.type.bip329Type,
      ref: labelToUpdate.ref,
      label: labelToUpdate.label,
      origin: labelToUpdate.origin,
    );

    String? labelId;
    for (final encrypted in encryptedLabels) {
      try {
        final decrypted = await _decryptLabel(encrypted);
        if (_isExactMatch(decrypted, labelToUpdate)) {
          labelId = encrypted.id;
          break;
        }
      } catch (e) {
        print('Failed to decrypt label ${encrypted.id}: $e');
      }
    }

    if (labelId == null) {
      throw Exception('Label not found');
    }

    final encrypted = await _encryptLabel(updatedLabel, labelId);

    final tokenHashes = updatedLabel.label != null
        ? _encryptionService.computeTokenHashes(
            label: updatedLabel.label!,
            mek: _mek!,
            origin: updatedLabel.origin,
          )
        : <Uint8List>[];

    await _database.updateEncryptedLabel(labelId, encrypted, tokenHashes);
  }

  Future<void> deleteLabel(SimpleLabelEntity label) async {
    await _ensureInitialized();

    final encryptedLabels = await _queryLabels(
      type: label.type.bip329Type,
      ref: label.ref,
      label: label.label,
      origin: label.origin,
    );

    for (final encrypted in encryptedLabels) {
      try {
        final decrypted = await _decryptLabel(encrypted);
        if (_isExactMatch(decrypted, label)) {
          await _database.deleteEncryptedLabel(encrypted.id);
          return;
        }
      } catch (e) {
        print('Failed to decrypt label ${encrypted.id}: $e');
      }
    }

    throw Exception('Label not found');
  }

  Future<List<EncryptedLabel>> _queryLabels({
    String? type,
    String? ref,
    String? label,
    String? origin,
  }) async {
    Uint8List? originHash;
    Uint8List? typeHash;
    Uint8List? refHash;
    Uint8List? labelHash;
    List<Uint8List>? tokenHashes;

    if (origin != null) {
      originHash = _encryptionService.computeOriginIndex(
        origin: origin,
        mek: _mek!,
      );
    }

    if (type != null && origin != null) {
      typeHash = _encryptionService.computeBlindIndex(
        value: type,
        mek: _mek!,
        field: 'type',
        origin: origin,
      );
    }

    if (ref != null && origin != null) {
      refHash = _encryptionService.computeBlindIndex(
        value: ref,
        mek: _mek!,
        field: 'ref',
        origin: origin,
      );
    }

    if (label != null && origin != null) {
      labelHash = _encryptionService.computeBlindIndex(
        value: label,
        mek: _mek!,
        field: 'label',
        origin: origin,
      );
      tokenHashes = _encryptionService.computeTokenHashes(
        label: label,
        mek: _mek!,
        origin: origin,
      );
    }

    return await _database.queryEncryptedLabels(
      originHash: originHash,
      typeHash: typeHash,
      refHash: refHash,
      labelHash: labelHash,
      tokenHashes: tokenHashes,
    );
  }

  Future<EncryptedLabelsCompanion> _encryptLabel(
    SimpleLabelEntity label,
    String id,
  ) async {
    final plaintext = json.encode({
      'type': label.type.bip329Type,
      'ref': label.ref,
      if (label.label != null) 'label': label.label,
      if (label.origin != null) 'origin': label.origin,
      if (label.spendable != null) 'spendable': label.spendable,
    });

    final encrypted = await _encryptionService.encryptLabel(
      plaintext: plaintext,
      mek: _mek!,
      labelId: id,
      algo: 'xchacha20poly1305',
      version: 1,
      keyVersion: 1,
    );

    Uint8List? idxOrigin;
    Uint8List? idxType;
    Uint8List? idxRef;
    Uint8List? idxLabelFull;

    if (label.origin != null) {
      idxOrigin = _encryptionService.computeOriginIndex(
        origin: label.origin!,
        mek: _mek!,
      );

      idxType = _encryptionService.computeBlindIndex(
        value: label.type.bip329Type,
        mek: _mek!,
        field: 'type',
        origin: label.origin,
      );

      idxRef = _encryptionService.computeBlindIndex(
        value: label.ref,
        mek: _mek!,
        field: 'ref',
        origin: label.origin,
      );

      if (label.label != null) {
        idxLabelFull = _encryptionService.computeBlindIndex(
          value: label.label!,
          mek: _mek!,
          field: 'label',
          origin: label.origin,
        );
      }
    }

    return EncryptedLabelsCompanion(
      id: Value(id),
      nonce: Value(encrypted.nonce),
      ciphertext: Value(encrypted.ciphertext),
      mac: Value(encrypted.mac),
      idxOrigin: Value(idxOrigin),
      idxType: Value(idxType),
      idxRef: Value(idxRef),
      idxLabelFull: Value(idxLabelFull),
      updatedAt: Value(DateTime.now()),
    );
  }

  Future<SimpleLabelEntity> _decryptLabel(EncryptedLabel encrypted) async {
    final encryptedData = EncryptedData(
      nonce: encrypted.nonce,
      ciphertext: encrypted.ciphertext,
      mac: encrypted.mac,
    );

    final plaintext = await _encryptionService.decryptLabel(
      encrypted: encryptedData,
      mek: _mek!,
      labelId: encrypted.id,
      algo: encrypted.algo,
      version: encrypted.version,
      keyVersion: encrypted.keyVersion,
    );

    final data = json.decode(plaintext) as Map<String, dynamic>;

    return SimpleLabelEntity.fromMap(data);
  }


  bool _isExactMatch(SimpleLabelEntity label1, SimpleLabelEntity label2) {
    return label1.isExactMatch(label2);
  }

  String _generateLabelId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = DateTime.now().microsecondsSinceEpoch;
    return '$timestamp-$random';
  }

  Uint8List _generateRandomMek() {
    // Generate a proper random 32-byte key
    final random = Random.secure();
    final bytes = Uint8List(32);
    for (int i = 0; i < 32; i++) {
      bytes[i] = random.nextInt(256);
    }
    return bytes;
  }

  Future<void> changePassphrase(String newPassphrase) async {
    await _ensureInitialized();

    final newMasterKey = await _encryptionService.deriveMasterKey(
      passphrase: newPassphrase,
    );

    final wrapped = await _encryptionService.wrapMasterKey(
      mek: _mek!,
      kek: newMasterKey.key,
    );

    await _database.insertOrUpdateKeyring(
      KeyringCompanion(
        id: const Value('default'),
        kdfSalt: Value(newMasterKey.salt),
        kdfIterations: Value(newMasterKey.iterations),
        mekNonce: Value(wrapped.nonce),
        mekCiphertext: Value(wrapped.ciphertext),
        mekMac: Value(wrapped.mac),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> close() async {
    await _database.close();
  }
}