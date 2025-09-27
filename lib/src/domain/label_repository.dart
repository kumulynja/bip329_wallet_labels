import 'label_entity.dart';

abstract class LabelRepository {
  /// Get all labels, optionally filtered by type, ref, label, and/or origin
  Future<List<LabelEntity>> getLabels({
    String? type,
    String? ref,
    String? label,
    String? origin,
  });

  /// Find a label that exactly matches the provided label
  Future<LabelEntity?> findExistingLabel(LabelEntity label);

  /// Add a new label
  Future<void> addLabel(LabelEntity label);

  /// Update an existing label using exact matching to find the current version
  /// The labelToUpdate must exist and match exactly to be updated with updatedLabel data
  Future<void> updateLabel({
    required LabelEntity labelToUpdate,
    required LabelEntity updatedLabel,
  });

  /// Delete a label using exact matching
  Future<void> deleteLabel(LabelEntity label);
}
