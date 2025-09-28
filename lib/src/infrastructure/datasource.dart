import '../domain/label_entity.dart';

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