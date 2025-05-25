import 'package:bip329_wallet_labels/src/domain/entities/label.dart';
import 'package:bip329_wallet_labels/src/domain/entities/label_filter.dart';
import 'package:bip329_wallet_labels/src/domain/entities/labelbase_connection.dart';

abstract class LabelRepository {
  Future<void> addLabel(
    Label label, {
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  });
  Future<Label> getLabel(
    String label, {
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  });
  Future<List<Label>> getLabels({
    LabelFilter? filter,
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  });
  Future<void> updateLabel(
    Label label, {
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  });
  Future<void> removeLabel(
    Label label, {
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  });
  Future<void> removeLabels({
    LabelFilter? filter,
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  });
}
