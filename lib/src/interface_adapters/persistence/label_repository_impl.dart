import '../../domain/label_entity.dart';
import '../../domain/label_repository.dart';
import '../../infrastructure/labelbase/labelbase_datasource.dart';
import '../../infrastructure/labelbase/labelbase_label_model.dart';
import 'label_entity_mapper.dart';

class LabelRepositoryImpl implements LabelRepository {
  final LabelbaseDatasource _datasource;

  LabelRepositoryImpl(this._datasource);

  @override
  Future<List<LabelEntity>> getLabels({
    String? type,
    String? ref,
    String? label,
    String? origin,
  }) async {
    final allLabels = await _datasource.getAllLabels();

    // Filter based on the provided criteria
    final filteredLabels =
        allLabels.where((labelbaseLabel) {
          final data = labelbaseLabel.data;

          if (type != null && data.type != type) return false;
          if (ref != null && data.ref != ref) return false;
          if (label != null && data.label != label) return false;
          if (origin != null && data.origin != origin) return false;

          return true;
        }).toList();

    return filteredLabels
        .map(
          (labelbaseLabel) =>
              LabelEntityMapper.fromLabelbaseLabel(labelbaseLabel),
        )
        .toList();
  }

  @override
  Future<LabelEntity?> findExistingLabel(LabelEntity label) async {
    // Convert the entity to labelbase data for searching
    final searchData = LabelEntityMapper.toLabelbaseLabelDataModel(label);

    // Use the datasource to find the exact label
    final foundLabel = await _datasource.findExactLabel(searchData);

    if (foundLabel != null) {
      return LabelEntityMapper.fromLabelbaseLabel(foundLabel);
    }

    return null;
  }

  @override
  Future<void> addLabel(LabelEntity label) async {
    // Convert to labelbase data
    final labelData = LabelEntityMapper.toLabelbaseLabelDataModel(label);

    // Add via datasource
    await _datasource.addLabel(labelData);
  }

  @override
  Future<void> updateLabel({
    required LabelEntity labelToUpdate,
    required LabelEntity updatedLabel,
  }) async {
    // Find the current label with its ID by searching
    final searchData = LabelEntityMapper.toLabelbaseLabelDataModel(
      labelToUpdate,
    );
    final existingLabelbaseLabel = await _datasource.findExactLabel(searchData);

    if (existingLabelbaseLabel == null) {
      throw LabelNotFoundException(
        'Label not found: ${labelToUpdate.type.bip329Type}:${labelToUpdate.ref}',
      );
    }

    // Convert the updated entity to labelbase data
    final updatedData = LabelEntityMapper.toLabelbaseLabelDataModel(
      updatedLabel,
    );

    // Create a labelbase label with the existing ID and updated data
    final labelbaseLabel = LabelbaseLabelModel(
      id: existingLabelbaseLabel.id,
      data: updatedData,
    );

    // Update via datasource
    await _datasource.updateLabel(labelbaseLabel);
  }

  @override
  Future<void> deleteLabel(LabelEntity label) async {
    // Find the label to get its ID
    final searchData = LabelEntityMapper.toLabelbaseLabelDataModel(label);
    final existingLabelbaseLabel = await _datasource.findExactLabel(searchData);

    if (existingLabelbaseLabel == null) {
      throw LabelNotFoundException(
        'Label not found: ${label.type.bip329Type}:${label.ref}',
      );
    }

    // Delete via datasource using the ID
    await _datasource.deleteLabel(existingLabelbaseLabel.id);
  }
}

class LabelNotFoundException implements Exception {
  final String message;
  LabelNotFoundException(this.message);

  @override
  String toString() => 'LabelNotFoundException: $message';
}
