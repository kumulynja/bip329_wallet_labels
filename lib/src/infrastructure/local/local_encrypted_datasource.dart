import 'dart:convert';
import 'dart:math';
import 'package:drift/drift.dart';
import 'local_decrypted_label_model.dart';
import 'crypto/encryption_service.dart';
import 'database/labels_database.dart';
import '../sync/sync_types.dart';
import '../sync/canonical_utils.dart';
import '../../domain/label_entity.dart';

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

  Future<List<LocalDecryptedLabelModel>> getAllLabels() async {
    await _ensureInitialized();

    final encryptedLabels = await _database.getAllEncryptedLabels();
    final labels = <LocalDecryptedLabelModel>[];

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

  Future<LocalDecryptedLabelModel?> findExactLabel(LocalDecryptedLabelModel searchLabel) async {
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

  Future<LocalDecryptedLabelModel> addLabel(LocalDecryptedLabelModel label) async {
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
    required LocalDecryptedLabelModel labelToUpdate,
    required LocalDecryptedLabelModel updatedLabel,
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

  Future<void> deleteLabel(LocalDecryptedLabelModel label) async {
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
    LocalDecryptedLabelModel label,
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

  Future<LocalDecryptedLabelModel> _decryptLabel(EncryptedLabel encrypted) async {
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

    return LocalDecryptedLabelModel.fromMap(data);
  }


  bool _isExactMatch(LocalDecryptedLabelModel label1, LocalDecryptedLabelModel label2) {
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

  // Sync-related methods

  Future<LocalDecryptedLabelModel> upsertLabelWithSync(
    LocalDecryptedLabelModel label, {
    required ShadowMeta shadow,
    required DirtyFlag dirty,
  }) async {
    await _ensureInitialized();

    final key = CanonicalUtils.toLabelKey(_toLabelEntity(label));
    final id = _generateLabelIdFromKey(key);
    final encrypted = await _encryptLabelWithSync(label, id, shadow, dirty);

    final tokenHashes = label.label != null
        ? _encryptionService.computeTokenHashes(
            label: label.label!,
            mek: _mek!,
            origin: label.origin,
          )
        : <Uint8List>[];

    // Check if label exists
    final existing = await _database.getEncryptedLabelById(id);
    if (existing != null) {
      await _database.updateEncryptedLabel(id, encrypted, tokenHashes);
    } else {
      await _database.insertEncryptedLabel(encrypted, tokenHashes);
    }

    return label;
  }

  Future<void> markDeleted(
    LabelKey key,
    DateTime deletedAt, {
    required ShadowMeta shadow,
    required DirtyFlag dirty,
  }) async {
    await _ensureInitialized();

    final id = _generateLabelIdFromKey(key);
    await _database.updateShadowMeta(
      id,
      dirty: dirty.value,
      shadowRemotePresent: shadow.remotePresent,
      shadowRemoteDigest: shadow.remoteDigest,
      tombstoneDeletedAt: deletedAt,
    );
  }

  Future<LocalDecryptedLabelModel?> getLabelByKey(LabelKey key) async {
    await _ensureInitialized();

    final id = _generateLabelIdFromKey(key);
    final encrypted = await _database.getEncryptedLabelById(id);

    if (encrypted == null || encrypted.tombstoneDeletedAt != null) {
      return null;
    }

    try {
      return await _decryptLabel(encrypted);
    } catch (e) {
      print('Failed to decrypt label $id: $e');
      return null;
    }
  }

  Future<List<LocalDecryptedLabelModel>> getLabelsByOrigin(String origin) async {
    await _ensureInitialized();

    final originHash = _encryptionService.computeOriginIndex(
      origin: origin,
      mek: _mek!,
    );

    final encryptedLabels = await _database.queryEncryptedLabels(
      originHash: originHash,
    );

    final labels = <LocalDecryptedLabelModel>[];
    for (final encrypted in encryptedLabels) {
      if (encrypted.tombstoneDeletedAt != null) continue; // Skip deleted

      try {
        final decrypted = await _decryptLabel(encrypted);
        labels.add(decrypted);
      } catch (e) {
        print('Failed to decrypt label ${encrypted.id}: $e');
      }
    }

    return labels;
  }

  Future<ShadowState?> getShadowState(LabelKey key) async {
    await _ensureInitialized();

    final id = _generateLabelIdFromKey(key);
    final encrypted = await _database.getEncryptedLabelById(id);

    if (encrypted == null) return null;

    return ShadowState(
      remotePresent: encrypted.shadowRemotePresent,
      remoteDigest: encrypted.shadowRemoteDigest,
      lastSeenAt: encrypted.shadowLastSeenAt,
      tombstoneDeletedAt: encrypted.tombstoneDeletedAt,
    );
  }

  Future<void> updateShadowState(LabelKey key, ShadowState shadow) async {
    await _ensureInitialized();

    final id = _generateLabelIdFromKey(key);
    await _database.updateShadowMeta(
      id,
      shadowRemotePresent: shadow.remotePresent,
      shadowRemoteDigest: shadow.remoteDigest,
      shadowLastSeenAt: shadow.lastSeenAt,
      tombstoneDeletedAt: shadow.tombstoneDeletedAt,
    );
  }

  Future<List<LocalDecryptedLabelModel>> getDirtyLabels() async {
    await _ensureInitialized();

    final encryptedLabels = await _database.getDirtyLabels();
    final labels = <LocalDecryptedLabelModel>[];

    for (final encrypted in encryptedLabels) {
      if (encrypted.tombstoneDeletedAt != null) continue; // Skip deleted

      try {
        final decrypted = await _decryptLabel(encrypted);
        labels.add(decrypted);
      } catch (e) {
        print('Failed to decrypt label ${encrypted.id}: $e');
      }
    }

    return labels;
  }

  Future<void> enqueueOutboxEvent(OutboxEvent event) async {
    await _ensureInitialized();

    final companion = OutboxCompanion(
      eventId: Value(event.eventId),
      keyOrigin: Value(event.keyOrigin),
      keyType: Value(event.keyType),
      keyRef: Value(event.keyRef),
      op: Value(event.op),
      payloadJson: Value(event.payloadJson),
      createdAt: Value(event.createdAt),
    );

    await _database.insertOutboxEvent(companion);
  }

  Future<List<OutboxEvent>> getOutboxEvents({int? limit}) async {
    await _ensureInitialized();

    final events = await _database.getOutboxEvents(limit: limit);
    return events.map((e) => OutboxEvent(
      eventId: e.eventId,
      keyOrigin: e.keyOrigin,
      keyType: e.keyType,
      keyRef: e.keyRef,
      op: e.op,
      payloadJson: e.payloadJson,
      createdAt: e.createdAt,
    )).toList();
  }

  Future<void> deleteOutboxEvent(String eventId) async {
    await _ensureInitialized();
    await _database.deleteOutboxEvent(eventId);
  }

  Future<EncryptedLabelsCompanion> _encryptLabelWithSync(
    LocalDecryptedLabelModel label,
    String id,
    ShadowMeta shadow,
    DirtyFlag dirty,
  ) async {
    final companion = await _encryptLabel(label, id);

    return companion.copyWith(
      dirty: Value(dirty.value),
      shadowRemotePresent: Value(shadow.remotePresent),
      shadowRemoteDigest: Value(shadow.remoteDigest),
      shadowLastSeenAt: Value(DateTime.now()),
    );
  }

  String _generateLabelIdFromKey(LabelKey key) {
    // Generate deterministic ID from canonical key
    // This ensures same label always gets same ID
    final canonical = '${key.originNorm}:${key.type}:${key.refNorm}';
    return canonical.hashCode.abs().toString();
  }

  LabelEntity _toLabelEntity(LocalDecryptedLabelModel simpleLabel) {
    final type = simpleLabel.type;
    final ref = simpleLabel.ref;
    final label = simpleLabel.label;
    final origin = simpleLabel.origin;

    switch (type) {
      case LabelType.tx:
        return TransactionLabelEntity(
          txId: ref,
          label: label,
          origin: origin,
        );
      case LabelType.address:
        return AddressLabelEntity(
          address: ref,
          label: label,
          origin: origin,
        );
      case LabelType.pubkey:
        return PubkeyLabelEntity(
          publicKey: ref,
          label: label,
          origin: origin,
        );
      case LabelType.input:
        final parts = ref.split(':');
        return InputLabelEntity(
          txId: parts[0],
          index: int.parse(parts[1]),
          label: label,
          origin: origin,
        );
      case LabelType.output:
        final parts = ref.split(':');
        return OutputLabelEntity(
          txId: parts[0],
          index: int.parse(parts[1]),
          label: label,
          origin: origin,
          spendable: simpleLabel.spendable,
        );
      case LabelType.xpub:
        return XpubLabelEntity(
          xpub: ref,
          label: label,
          origin: origin,
        );
    }
  }
}