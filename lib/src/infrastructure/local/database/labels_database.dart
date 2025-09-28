import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'labels_database.g.dart';

class EncryptedLabels extends Table {
  TextColumn get id => text()();
  BlobColumn get nonce => blob()();
  BlobColumn get ciphertext => blob()();
  BlobColumn get mac => blob()();
  BlobColumn get idxOrigin => blob().nullable()();
  BlobColumn get idxType => blob().nullable()();
  BlobColumn get idxRef => blob().nullable()();
  BlobColumn get idxLabelFull => blob().nullable()();
  IntColumn get version => integer().withDefault(const Constant(1))();
  IntColumn get keyVersion => integer().withDefault(const Constant(1))();
  TextColumn get algo =>
      text().withDefault(const Constant('xchacha20poly1305'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class LabelTokens extends Table {
  TextColumn get labelId => text()();
  BlobColumn get tokenHash => blob()();

  @override
  Set<Column> get primaryKey => {labelId, tokenHash};
}

class Keyring extends Table {
  TextColumn get id => text()();
  TextColumn get kdf =>
      text().withDefault(const Constant('pbkdf2-hmac-sha256'))();
  BlobColumn get kdfSalt => blob()();
  IntColumn get kdfIterations => integer()();
  BlobColumn get mekNonce => blob()();
  BlobColumn get mekCiphertext => blob()();
  BlobColumn get mekMac => blob()();
  IntColumn get version => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [EncryptedLabels, LabelTokens, Keyring])
class LabelsDatabase extends _$LabelsDatabase {
  LabelsDatabase({String? filePath, QueryExecutor? executor})
    : super(executor ?? _openConnection(filePath ?? 'bip329_labels.db'));

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection(String filePath) {
    return NativeDatabase.createInBackground(File(filePath));
  }

  Future<KeyringData?> getKeyring() async {
    return await (select(keyring)
      ..where((tbl) => tbl.id.equals('default'))).getSingleOrNull();
  }

  Future<void> insertOrUpdateKeyring(KeyringCompanion data) async {
    await into(keyring).insertOnConflictUpdate(data);
  }

  Future<List<EncryptedLabel>> getAllEncryptedLabels() async {
    return await select(encryptedLabels).get();
  }

  Future<EncryptedLabel?> getEncryptedLabelById(String id) async {
    return await (select(encryptedLabels)
      ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<List<EncryptedLabel>> queryEncryptedLabels({
    Uint8List? originHash,
    Uint8List? typeHash,
    Uint8List? refHash,
    Uint8List? labelHash,
    List<Uint8List>? tokenHashes,
  }) async {
    final query = select(encryptedLabels);

    if (originHash != null) {
      query.where((tbl) => tbl.idxOrigin.equals(originHash));
    }
    if (typeHash != null) {
      query.where((tbl) => tbl.idxType.equals(typeHash));
    }
    if (refHash != null) {
      query.where((tbl) => tbl.idxRef.equals(refHash));
    }
    if (labelHash != null) {
      query.where((tbl) => tbl.idxLabelFull.equals(labelHash));
    }

    var results = await query.get();

    if (tokenHashes != null && tokenHashes.isNotEmpty) {
      final labelIds = <String>{};
      for (final hash in tokenHashes) {
        final tokens =
            await (select(labelTokens)
              ..where((tbl) => tbl.tokenHash.equals(hash))).get();
        if (labelIds.isEmpty) {
          labelIds.addAll(tokens.map((t) => t.labelId));
        } else {
          labelIds.retainAll(tokens.map((t) => t.labelId));
        }
      }
      results = results.where((label) => labelIds.contains(label.id)).toList();
    }

    return results;
  }

  Future<void> insertEncryptedLabel(
    EncryptedLabelsCompanion label,
    List<Uint8List> tokenHashes,
  ) async {
    await transaction(() async {
      await into(encryptedLabels).insert(label);

      for (final hash in tokenHashes) {
        await into(labelTokens).insert(
          LabelTokensCompanion(
            labelId: Value(label.id.value),
            tokenHash: Value(hash),
          ),
        );
      }
    });
  }

  Future<void> updateEncryptedLabel(
    String id,
    EncryptedLabelsCompanion label,
    List<Uint8List> tokenHashes,
  ) async {
    await transaction(() async {
      await (update(encryptedLabels)
        ..where((tbl) => tbl.id.equals(id))).write(label);

      await (delete(labelTokens)..where((tbl) => tbl.labelId.equals(id))).go();

      for (final hash in tokenHashes) {
        await into(labelTokens).insert(
          LabelTokensCompanion(labelId: Value(id), tokenHash: Value(hash)),
        );
      }
    });
  }

  Future<void> deleteEncryptedLabel(String id) async {
    await transaction(() async {
      await (delete(labelTokens)..where((tbl) => tbl.labelId.equals(id))).go();
      await (delete(encryptedLabels)..where((tbl) => tbl.id.equals(id))).go();
    });
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();

      await customStatement(
        'CREATE INDEX idx_labels_origin ON encrypted_labels(idx_origin);',
      );
      await customStatement(
        'CREATE INDEX idx_labels_type ON encrypted_labels(idx_type);',
      );
      await customStatement(
        'CREATE INDEX idx_labels_ref ON encrypted_labels(idx_ref);',
      );
      await customStatement(
        'CREATE INDEX idx_labels_label ON encrypted_labels(idx_label_full);',
      );
      await customStatement(
        'CREATE INDEX idx_tokens_hash ON label_tokens(token_hash);',
      );
      await customStatement(
        'CREATE INDEX idx_tokens_label ON label_tokens(label_id);',
      );
    },
  );
}
