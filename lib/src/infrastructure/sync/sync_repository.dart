import 'dart:async';
import 'dart:typed_data';

import '../../domain/label_entity.dart';
import '../../domain/label_repository.dart';
import '../datasource.dart';
import 'canonical_utils.dart';
import 'sync_types.dart';
import 'uuid_generator.dart';

/// Repository with sync capabilities implementing remote-first pattern
class SyncRepository implements LabelRepository {
  final LocalSyncDatasource? _localDatasource;
  final RemoteSyncDatasource? _remoteDatasource;
  Completer<void>? _syncMutex = Completer<void>()..complete();

  SyncRepository({
    LocalSyncDatasource? localDatasource,
    RemoteSyncDatasource? remoteDatasource,
  }) : _localDatasource = localDatasource,
       _remoteDatasource = remoteDatasource {
    if (_localDatasource == null && _remoteDatasource == null) {
      throw ArgumentError('At least one datasource must be provided');
    }
  }

  @override
  Future<List<LabelEntity>> getLabels({
    String? type,
    String? ref,
    String? label,
    String? origin,
  }) async {
    // For now, return all labels and let the controller filter
    // TODO: Implement filtering at repository level for efficiency
    if (_localDatasource != null) {
      return await _localDatasource.getAllLabels();
    } else {
      return await _remoteDatasource!.getAllLabels();
    }
  }

  @override
  Future<LabelEntity?> findExistingLabel(LabelEntity label) async {
    // Read from local if available, otherwise remote
    if (_localDatasource != null) {
      return await _localDatasource.findExactLabel(label);
    } else {
      return await _remoteDatasource!.findExactLabel(label);
    }
  }

  @override
  Future<void> addLabel(LabelEntity label) async {
    await _upsertLabel(label, isCreate: true);
  }

  @override
  Future<void> updateLabel({
    required LabelEntity labelToUpdate,
    required LabelEntity updatedLabel,
  }) async {
    await _upsertLabel(updatedLabel, isCreate: false);
  }

  @override
  Future<void> deleteLabel(LabelEntity label) async {
    final key = CanonicalUtils.toLabelKey(label);

    // Try remote first if available
    if (_remoteDatasource != null) {
      try {
        await _remoteDatasource.deleteRemote(key);

        // Success - mirror locally and mark clean
        if (_localDatasource != null) {
          await _localDatasource.markLocalDeleted(
            key,
            DateTime.now(),
            shadow: const ShadowMeta(remotePresent: false),
            dirty: DirtyFlag.clean,
          );
        }
        return;
      } on NetworkException {
        // Network error - fall through to offline handling
      } on ConflictException {
        // Conflict - fetch remote and resolve
        await _handleDeleteConflict(key);
        return;
      }
    }

    // Offline mode or no remote - queue for later
    if (_localDatasource != null) {
      // Get current shadow state
      final currentShadow = await _localDatasource.getShadow(key);

      await _localDatasource.markLocalDeleted(
        key,
        DateTime.now(),
        shadow: ShadowMeta(
          remotePresent: currentShadow?.remotePresent ?? false,
          remoteDigest: currentShadow?.remoteDigest,
        ),
        dirty: DirtyFlag.pendingDelete,
      );

      // Enqueue for later sync
      final event = OutboxEvent.delete(
        eventId: UuidGenerator.generate(),
        labelKey: key,
        createdAt: DateTime.now(),
      );
      await _localDatasource.outboxEnqueue(event);
    } else {
      throw Exception('No datasource available for delete operation');
    }
  }

  /// Sync method to reconcile local and remote state
  Future<void> sync() async {
    if (_localDatasource == null || _remoteDatasource == null) {
      return; // No sync needed if only one datasource
    }

    // Ensure only one sync runs at a time
    await _syncMutex!.future;
    _syncMutex = Completer<void>();

    try {
      // Phase 1: Push outbox (ordered by created_at)
      await _pushOutbox();

      // Phase 2: Pull remote snapshot and reconcile
      await _pullAndReconcile();

      _syncMutex!.complete();
    } catch (e) {
      _syncMutex!.completeError(e);
      rethrow;
    }
  }

  Future<void> dispose() async {
    await _localDatasource?.dispose();
    await _remoteDatasource?.dispose();
  }

  // Private sync methods

  Future<LabelEntity> _upsertLabel(LabelEntity label, {required bool isCreate}) async {
    final key = CanonicalUtils.toLabelKey(label);
    final canonicalJson = CanonicalUtils.toCanonicalJson(label);

    // Try remote first if available
    if (_remoteDatasource != null) {
      try {
        await _remoteDatasource.upsertRemote(label);

        // Success - compute digest and mirror locally
        if (_localDatasource != null) {
          final mek = await _getMasterEncryptionKey();
          final digest = CanonicalUtils.computeDigest(canonicalJson, Uint8List.fromList(mek));

          await _localDatasource.upsertLocalEncrypted(
            label,
            shadow: ShadowMeta(remotePresent: true, remoteDigest: digest),
            dirty: DirtyFlag.clean,
          );
        }

        return label;
      } on NetworkException {
        // Network error - fall through to offline handling
      } on ConflictException {
        // Conflict - fetch remote and resolve
        final resolved = await _handleUpsertConflict(label);
        return resolved;
      }
    }

    // Offline mode or no remote - store locally and queue
    if (_localDatasource != null) {
      final dirty = isCreate ? DirtyFlag.pendingCreate : DirtyFlag.pendingUpdate;

      await _localDatasource.upsertLocalEncrypted(
        label,
        shadow: const ShadowMeta(remotePresent: false),
        dirty: dirty,
      );

      // Enqueue for later sync
      final event = OutboxEvent.upsert(
        eventId: UuidGenerator.generate(),
        labelKey: key,
        payloadJson: canonicalJson,
        createdAt: DateTime.now(),
      );
      await _localDatasource.outboxEnqueue(event);

      return label;
    } else {
      throw Exception('No datasource available for upsert operation');
    }
  }

  Future<void> _pushOutbox() async {
    if (_localDatasource == null || _remoteDatasource == null) return;

    final events = await _localDatasource.outboxListOldest(100); // Process in batches

    for (final event in events) {
      try {
        if (event.op == 'upsert') {
          // Reconstruct label from canonical JSON
          final label = _labelFromCanonicalJson(event.payloadJson!);
          await _remoteDatasource.upsertRemote(label);

          // Success - compute digest and update local shadow
          final mek = await _getMasterEncryptionKey();
          final digest = CanonicalUtils.computeDigest(event.payloadJson!, Uint8List.fromList(mek));

          await _localDatasource.upsertLocalEncrypted(
            label,
            shadow: ShadowMeta(remotePresent: true, remoteDigest: digest),
            dirty: DirtyFlag.clean,
          );
        } else if (event.op == 'delete') {
          await _remoteDatasource.deleteRemote(event.labelKey);

          // Success - update local shadow
          await _localDatasource.markLocalDeleted(
            event.labelKey,
            DateTime.now(),
            shadow: const ShadowMeta(remotePresent: false),
            dirty: DirtyFlag.clean,
          );
        }

        // Remove processed event
        await _localDatasource.outboxDelete(event.eventId);
      } on NetworkException {
        // Network error - stop pushing and proceed to pull
        break;
      } on ConflictException {
        // Conflict - remove from outbox and let pull handle it
        await _localDatasource.outboxDelete(event.eventId);
      }
    }
  }

  Future<void> _pullAndReconcile() async {
    if (_localDatasource == null || _remoteDatasource == null) return;

    try {
      // Get all remote labels
      final remoteLabels = await _remoteDatasource.listRemoteAll();
      final mek = await _getMasterEncryptionKey();

      // Track which remote labels we've seen
      final seenRemoteKeys = <LabelKey>{};

      for (final remoteLabel in remoteLabels) {
        final remoteKey = CanonicalUtils.toLabelKey(remoteLabel);
        seenRemoteKeys.add(remoteKey);

        final canonicalJson = CanonicalUtils.toCanonicalJson(remoteLabel);
        final remoteDigest = CanonicalUtils.computeDigest(canonicalJson, Uint8List.fromList(mek));

        // Get local state
        final localLabel = await _localDatasource.getLocal(remoteKey);
        final shadow = await _localDatasource.getShadow(remoteKey);

        if (localLabel == null) {
          // Case A: Remote exists, local missing -> import
          await _localDatasource.upsertLocalEncrypted(
            remoteLabel,
            shadow: ShadowMeta(remotePresent: true, remoteDigest: remoteDigest),
            dirty: DirtyFlag.clean,
          );
        } else if (shadow?.remoteDigest == null ||
                   (shadow!.remoteDigest != null && !_digestEquals(shadow.remoteDigest!, remoteDigest))) {
          // Case B: Remote changed
          final isDirty = await _isLabelDirty(remoteKey);

          if (isDirty) {
            // Conflict: local dirty & remote different -> resolve
            await _resolveConflict(localLabel, remoteLabel, remoteKey);
          } else {
            // No conflict: remote wins -> overwrite local
            await _localDatasource.upsertLocalEncrypted(
              remoteLabel,
              shadow: ShadowMeta(remotePresent: true, remoteDigest: remoteDigest),
              dirty: DirtyFlag.clean,
            );
          }
        }
        // Case C: No change - do nothing
      }

      // Handle local-only labels (potential remote deletes)
      await _handleRemoteDeletes(seenRemoteKeys);
    } catch (e) {
      // Pull failed - continue operation but don't update sync timestamp
      print('Pull failed: $e');
    }
  }

  Future<void> _handleRemoteDeletes(Set<LabelKey> seenRemoteKeys) async {
    if (_localDatasource == null) return;

    // Get all local labels with remote presence
    final allLocalLabels = await _localDatasource.getAllLabels();

    for (final localLabel in allLocalLabels) {
      final localKey = CanonicalUtils.toLabelKey(localLabel);
      final shadow = await _localDatasource.getShadow(localKey);

      if (shadow?.remotePresent == true && !seenRemoteKeys.contains(localKey)) {
        // Label was on remote but not in current snapshot
        final isDirty = await _isLabelDirty(localKey);

        if (!isDirty) {
          // Not dirty locally -> remote hard delete -> tombstone
          await _localDatasource.markLocalDeleted(
            localKey,
            DateTime.now(),
            shadow: const ShadowMeta(remotePresent: false),
            dirty: DirtyFlag.clean,
          );
        }
        // If dirty locally, leave in outbox to be pushed later
      }
    }
  }

  Future<LabelEntity> _handleUpsertConflict(LabelEntity localLabel) async {
    // For now, implement local-wins policy
    // In a more sophisticated implementation, you could check timestamps
    await _remoteDatasource!.upsertRemote(localLabel);

    if (_localDatasource != null) {
      final canonicalJson = CanonicalUtils.toCanonicalJson(localLabel);
      final mek = await _getMasterEncryptionKey();
      final digest = CanonicalUtils.computeDigest(canonicalJson, Uint8List.fromList(mek));

      await _localDatasource.upsertLocalEncrypted(
        localLabel,
        shadow: ShadowMeta(remotePresent: true, remoteDigest: digest),
        dirty: DirtyFlag.clean,
      );
    }

    return localLabel;
  }

  Future<void> _handleDeleteConflict(LabelKey key) async {
    // For deletes, always proceed - if it's already deleted remotely, that's fine
    await _remoteDatasource!.deleteRemote(key);

    if (_localDatasource != null) {
      await _localDatasource.markLocalDeleted(
        key,
        DateTime.now(),
        shadow: const ShadowMeta(remotePresent: false),
        dirty: DirtyFlag.clean,
      );
    }
  }

  Future<void> _resolveConflict(
    LabelEntity localLabel,
    LabelEntity remoteLabel,
    LabelKey key,
  ) async {
    // Implement local-wins policy as specified
    await _remoteDatasource!.upsertRemote(localLabel);

    if (_localDatasource != null) {
      final canonicalJson = CanonicalUtils.toCanonicalJson(localLabel);
      final mek = await _getMasterEncryptionKey();
      final digest = CanonicalUtils.computeDigest(canonicalJson, Uint8List.fromList(mek));

      await _localDatasource.upsertLocalEncrypted(
        localLabel,
        shadow: ShadowMeta(remotePresent: true, remoteDigest: digest),
        dirty: DirtyFlag.clean,
      );
    }
  }

  Future<bool> _isLabelDirty(LabelKey key) async {
    if (_localDatasource == null) return false;

    final shadow = await _localDatasource.getShadow(key);
    return shadow?.remotePresent != true; // If no shadow or not marked as remote present, consider dirty
  }

  bool _digestEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  Future<List<int>> _getMasterEncryptionKey() async {
    // TODO: Get MEK from local datasource encryption service
    // For now, return a dummy key - this will need proper implementation
    // when the encryption service provides access to the MEK
    return List.filled(32, 0); // Placeholder 32-byte key
  }

  LabelEntity _labelFromCanonicalJson(String canonicalJson) {
    // TODO: Parse canonical JSON back to label entity
    // For now, throw error until proper implementation
    throw UnimplementedError('JSON to label conversion needs proper implementation with JSON parsing');
  }
}