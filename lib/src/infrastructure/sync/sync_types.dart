import 'dart:typed_data';

/// Canonical key for BIP329 labels used for sync operations
class LabelKey {
  final String originNorm;
  final String type;
  final String refNorm;

  const LabelKey({
    required this.originNorm,
    required this.type,
    required this.refNorm,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LabelKey &&
          originNorm == other.originNorm &&
          type == other.type &&
          refNorm == other.refNorm;

  @override
  int get hashCode => Object.hash(originNorm, type, refNorm);

  @override
  String toString() => 'LabelKey(origin: $originNorm, type: $type, ref: $refNorm)';
}

/// Sync state for tracking dirty/clean status of local labels
enum DirtyFlag {
  clean('clean'),
  pendingCreate('pendingCreate'),
  pendingUpdate('pendingUpdate'),
  pendingDelete('pendingDelete');

  const DirtyFlag(this.value);
  final String value;

  static DirtyFlag fromString(String value) {
    return DirtyFlag.values.firstWhere((e) => e.value == value);
  }
}

/// Shadow state tracking remote presence and digest
class ShadowState {
  final bool remotePresent;
  final Uint8List? remoteDigest;
  final DateTime? lastSeenAt;
  final DateTime? tombstoneDeletedAt;

  const ShadowState({
    required this.remotePresent,
    this.remoteDigest,
    this.lastSeenAt,
    this.tombstoneDeletedAt,
  });

  ShadowState copyWith({
    bool? remotePresent,
    Uint8List? Function()? remoteDigest,
    DateTime? Function()? lastSeenAt,
    DateTime? Function()? tombstoneDeletedAt,
  }) {
    return ShadowState(
      remotePresent: remotePresent ?? this.remotePresent,
      remoteDigest: remoteDigest != null ? remoteDigest() : this.remoteDigest,
      lastSeenAt: lastSeenAt != null ? lastSeenAt() : this.lastSeenAt,
      tombstoneDeletedAt: tombstoneDeletedAt != null ? tombstoneDeletedAt() : this.tombstoneDeletedAt,
    );
  }
}

/// Simplified shadow metadata for write operations
class ShadowMeta {
  final bool remotePresent;
  final Uint8List? remoteDigest;

  const ShadowMeta({
    required this.remotePresent,
    this.remoteDigest,
  });
}

/// Outbox event for offline operations
class OutboxEvent {
  final String eventId;
  final String keyOrigin;
  final String keyType;
  final String keyRef;
  final String op; // 'upsert' or 'delete'
  final String? payloadJson; // canonical JSON for upsert operations
  final DateTime createdAt;

  const OutboxEvent({
    required this.eventId,
    required this.keyOrigin,
    required this.keyType,
    required this.keyRef,
    required this.op,
    this.payloadJson,
    required this.createdAt,
  });

  LabelKey get labelKey => LabelKey(
    originNorm: keyOrigin,
    type: keyType,
    refNorm: keyRef,
  );

  /// Create an upsert event
  static OutboxEvent upsert({
    required String eventId,
    required LabelKey labelKey,
    required String payloadJson,
    required DateTime createdAt,
  }) {
    return OutboxEvent(
      eventId: eventId,
      keyOrigin: labelKey.originNorm,
      keyType: labelKey.type,
      keyRef: labelKey.refNorm,
      op: 'upsert',
      payloadJson: payloadJson,
      createdAt: createdAt,
    );
  }

  /// Create a delete event
  static OutboxEvent delete({
    required String eventId,
    required LabelKey labelKey,
    required DateTime createdAt,
  }) {
    return OutboxEvent(
      eventId: eventId,
      keyOrigin: labelKey.originNorm,
      keyType: labelKey.type,
      keyRef: labelKey.refNorm,
      op: 'delete',
      payloadJson: null,
      createdAt: createdAt,
    );
  }
}

/// Exception thrown when network operations fail
class NetworkException implements Exception {
  final String message;
  final Exception? cause;

  const NetworkException(this.message, [this.cause]);

  @override
  String toString() => 'NetworkException: $message${cause != null ? ' (caused by: $cause)' : ''}';
}

/// Exception thrown when there's a conflict with remote state
class ConflictException implements Exception {
  final String message;
  final LabelKey labelKey;

  const ConflictException(this.message, this.labelKey);

  @override
  String toString() => 'ConflictException: $message for $labelKey';
}