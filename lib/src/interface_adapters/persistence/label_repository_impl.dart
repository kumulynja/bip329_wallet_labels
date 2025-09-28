import '../../domain/label_entity.dart';
import '../../domain/label_repository.dart';
import '../../infrastructure/datasource.dart';

class LabelRepositoryImpl implements LabelRepository {
  final List<LabelDatasource> _datasources;

  LabelRepositoryImpl(this._datasources);

  @override
  Future<List<LabelEntity>> getLabels({
    String? type,
    String? ref,
    String? label,
    String? origin,
  }) async {
    final allLabels = <LabelEntity>[];

    for (final datasource in _datasources) {
      try {
        final labels = await datasource.getAllLabels();
        allLabels.addAll(labels);
      } catch (e) {
        print('Error fetching from datasource: $e');
      }
    }

    // Filter based on the provided criteria and remove duplicates
    final filteredLabels =
        allLabels.where((labelEntity) {
          if (type != null && labelEntity.type.bip329Type != type) return false;
          if (ref != null && labelEntity.ref != ref) return false;
          if (label != null && labelEntity.label != label) return false;
          if (origin != null && labelEntity.origin != origin) return false;
          return true;
        }).toList();

    // Remove duplicates based on exact match
    final uniqueLabels = <LabelEntity>[];
    for (final label in filteredLabels) {
      if (!uniqueLabels.any((existing) => existing.isExactMatch(label))) {
        uniqueLabels.add(label);
      }
    }

    return uniqueLabels;
  }

  @override
  Future<LabelEntity?> findExistingLabel(LabelEntity label) async {
    for (final datasource in _datasources) {
      try {
        final foundLabel = await datasource.findExactLabel(label);
        if (foundLabel != null) {
          return foundLabel;
        }
      } catch (e) {
        print('Error finding label in datasource: $e');
      }
    }
    return null;
  }

  @override
  Future<void> addLabel(LabelEntity label) async {
    // Add to all datasources
    final futures = <Future>[];
    for (final datasource in _datasources) {
      futures.add(
        datasource.addLabel(label).catchError((e) {
          print('Error adding label to datasource: $e');
          return label; // Return the original label on error
        }),
      );
    }
    await Future.wait(futures);
  }

  @override
  Future<void> updateLabel({
    required LabelEntity labelToUpdate,
    required LabelEntity updatedLabel,
  }) async {
    bool updated = false;
    final futures = <Future>[];

    for (final datasource in _datasources) {
      futures.add(
        datasource
            .updateLabel(
              labelToUpdate: labelToUpdate,
              updatedLabel: updatedLabel,
            )
            .then((_) {
              updated = true;
            })
            .catchError((e) {
              print('Error updating label in datasource: $e');
            }),
      );
    }

    await Future.wait(futures);

    if (!updated) {
      throw LabelNotFoundException(
        'Label not found: ${labelToUpdate.type.bip329Type}:${labelToUpdate.ref}',
      );
    }
  }

  @override
  Future<void> deleteLabel(LabelEntity label) async {
    bool deleted = false;
    final futures = <Future>[];

    for (final datasource in _datasources) {
      futures.add(
        datasource
            .deleteLabel(label)
            .then((_) {
              deleted = true;
            })
            .catchError((e) {
              print('Error deleting label from datasource: $e');
            }),
      );
    }

    await Future.wait(futures);

    if (!deleted) {
      throw LabelNotFoundException(
        'Label not found: ${label.type.bip329Type}:${label.ref}',
      );
    }
  }

  /// Dispose of all datasources and clean up resources
  Future<void> dispose() async {
    final futures = <Future>[];
    for (final datasource in _datasources) {
      futures.add(datasource.dispose().catchError((e) {
        print('Error disposing datasource: $e');
      }));
    }
    await Future.wait(futures);
  }
}

class LabelNotFoundException implements Exception {
  final String message;
  LabelNotFoundException(this.message);

  @override
  String toString() => 'LabelNotFoundException: $message';
}
