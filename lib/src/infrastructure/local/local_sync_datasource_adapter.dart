import '../../domain/label_entity.dart';
import '../datasource.dart';
import '../sync/canonical_utils.dart';
import '../sync/sync_types.dart';
import 'local_encrypted_datasource.dart';
import 'local_decrypted_label_model.dart';

class LocalSyncDatasourceAdapter implements LocalSyncDatasource {
  final LocalEncryptedDatasource _localDatasource;

  LocalSyncDatasourceAdapter(this._localDatasource);

  Future<void> initialize() async {
    await _localDatasource.initialize();
  }

  @override
  Future<List<LabelEntity>> getAllLabels() async {
    final simpleLabels = await _localDatasource.getAllLabels();
    return simpleLabels.map(_toLabelEntity).toList();
  }

  @override
  Future<LabelEntity?> findExactLabel(LabelEntity searchLabel) async {
    final simpleLabel = _toSimpleLabel(searchLabel);
    final found = await _localDatasource.findExactLabel(simpleLabel);
    return found != null ? _toLabelEntity(found) : null;
  }

  @override
  Future<LabelEntity> addLabel(LabelEntity label) async {
    // Default to dirty create with no remote presence
    return await upsertLocalEncrypted(
      label,
      shadow: const ShadowMeta(remotePresent: false),
      dirty: DirtyFlag.pendingCreate,
    );
  }

  @override
  Future<void> updateLabel({
    required LabelEntity labelToUpdate,
    required LabelEntity updatedLabel,
  }) async {
    final key = CanonicalUtils.toLabelKey(labelToUpdate);

    // Get current shadow state to preserve it
    final currentShadow = await getShadow(key);

    await upsertLocalEncrypted(
      updatedLabel,
      shadow: ShadowMeta(
        remotePresent: currentShadow?.remotePresent ?? false,
        remoteDigest: currentShadow?.remoteDigest,
      ),
      dirty: DirtyFlag.pendingUpdate,
    );
  }

  @override
  Future<void> deleteLabel(LabelEntity label) async {
    final key = CanonicalUtils.toLabelKey(label);

    // Get current shadow state
    final currentShadow = await getShadow(key);

    await markLocalDeleted(
      key,
      DateTime.now(),
      shadow: ShadowMeta(
        remotePresent: currentShadow?.remotePresent ?? false,
        remoteDigest: currentShadow?.remoteDigest,
      ),
      dirty: DirtyFlag.pendingDelete,
    );
  }

  @override
  Future<LabelEntity> upsertLocalEncrypted(
    LabelEntity label, {
    required ShadowMeta shadow,
    required DirtyFlag dirty,
  }) async {
    final simpleLabel = _toSimpleLabel(label);

    // Store the label with shadow metadata
    await _localDatasource.upsertLabelWithSync(
      simpleLabel,
      shadow: shadow,
      dirty: dirty,
    );

    return label;
  }

  @override
  Future<void> markLocalDeleted(
    LabelKey key,
    DateTime deletedAt, {
    required ShadowMeta shadow,
    required DirtyFlag dirty,
  }) async {
    await _localDatasource.markDeleted(
      key,
      deletedAt,
      shadow: shadow,
      dirty: dirty,
    );
  }

  @override
  Future<LabelEntity?> getLocal(LabelKey key) async {
    final simpleLabel = await _localDatasource.getLabelByKey(key);
    return simpleLabel != null ? _toLabelEntity(simpleLabel) : null;
  }

  @override
  Future<List<LabelEntity>> listLocalByOrigin(String origin) async {
    final simpleLabels = await _localDatasource.getLabelsByOrigin(origin);
    return simpleLabels.map(_toLabelEntity).toList();
  }

  @override
  Future<ShadowState?> getShadow(LabelKey key) async {
    return await _localDatasource.getShadowState(key);
  }

  @override
  Future<void> updateShadow(LabelKey key, ShadowState shadow) async {
    await _localDatasource.updateShadowState(key, shadow);
  }

  @override
  Future<List<LabelEntity>> getDirtyLabels() async {
    final simpleLabels = await _localDatasource.getDirtyLabels();
    return simpleLabels.map(_toLabelEntity).toList();
  }

  @override
  Future<void> outboxEnqueue(OutboxEvent event) async {
    await _localDatasource.enqueueOutboxEvent(event);
  }

  @override
  Future<List<OutboxEvent>> outboxListOldest(int limit) async {
    return await _localDatasource.getOutboxEvents(limit: limit);
  }

  @override
  Future<void> outboxDelete(String eventId) async {
    await _localDatasource.deleteOutboxEvent(eventId);
  }

  Future<void> changePassphrase(String newPassphrase) async {
    await _localDatasource.changePassphrase(newPassphrase);
  }

  @override
  Future<void> dispose() async {
    await _localDatasource.close();
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

  LocalDecryptedLabelModel _toSimpleLabel(LabelEntity label) {
    bool? spendable;
    if (label is OutputLabelEntity) {
      spendable = label.spendable;
    }

    LabelType type;
    switch (label.type.bip329Type) {
      case 'tx':
        type = LabelType.tx;
        break;
      case 'addr':
        type = LabelType.address;
        break;
      case 'pubkey':
        type = LabelType.pubkey;
        break;
      case 'input':
        type = LabelType.input;
        break;
      case 'output':
        type = LabelType.output;
        break;
      case 'xpub':
        type = LabelType.xpub;
        break;
      default:
        throw Exception('Unknown label type: ${label.type.bip329Type}');
    }

    return LocalDecryptedLabelModel(
      type: type,
      ref: label.ref,
      label: label.label,
      origin: label.origin,
      spendable: spendable,
    );
  }
}