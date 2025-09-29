import '../domain/label_entity.dart';
import 'sync/sync_types.dart';

abstract class LabelDatasource {
  Future<List<LabelEntity>> getAllLabels();

  Future<LabelEntity?> findExactLabel(LabelEntity searchLabel);

  Future<LabelEntity> addLabel(LabelEntity label);

  Future<void> updateLabel({
    required LabelEntity labelToUpdate,
    required LabelEntity updatedLabel,
  });

  Future<void> deleteLabel(LabelEntity label);

  /// Clean up resources (close connections, dispose clients, etc.)
  Future<void> dispose();
}

/// Extended interface for local datasource with sync capabilities
abstract class LocalSyncDatasource extends LabelDatasource {
  /// Upsert label with shadow metadata and dirty flag
  Future<LabelEntity> upsertLocalEncrypted(
    LabelEntity label, {
    required ShadowMeta shadow,
    required DirtyFlag dirty,
  });

  /// Mark label as deleted with shadow metadata
  Future<void> markLocalDeleted(
    LabelKey key,
    DateTime deletedAt, {
    required ShadowMeta shadow,
    required DirtyFlag dirty,
  });

  /// Get label by canonical key
  Future<LabelEntity?> getLocal(LabelKey key);

  /// List labels by origin
  Future<List<LabelEntity>> listLocalByOrigin(String origin);

  /// Get shadow state for a label
  Future<ShadowState?> getShadow(LabelKey key);

  /// Update shadow state for a label
  Future<void> updateShadow(LabelKey key, ShadowState shadow);

  /// Get all dirty labels
  Future<List<LabelEntity>> getDirtyLabels();

  /// Outbox operations
  Future<void> outboxEnqueue(OutboxEvent event);
  Future<List<OutboxEvent>> outboxListOldest(int limit);
  Future<void> outboxDelete(String eventId);
}

/// Interface for remote datasource (Labelbase)
abstract class RemoteSyncDatasource extends LabelDatasource {
  /// Remote-first writes (idempotent server behavior not guaranteed)
  Future<void> upsertRemote(LabelEntity label);

  /// Hard delete on server
  Future<void> deleteRemote(LabelKey key);

  /// Snapshot pull (all labels for an origin)
  Future<List<LabelEntity>> listRemoteByOrigin(String origin);

  /// Snapshot pull (all labels)
  Future<List<LabelEntity>> listRemoteAll();
}