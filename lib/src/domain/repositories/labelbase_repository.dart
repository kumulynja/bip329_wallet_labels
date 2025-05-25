import 'package:bip329_wallet_labels/src/domain/entities/labelbase.dart';
import 'package:bip329_wallet_labels/src/domain/entities/labelbase_connection.dart';

abstract class LabelbaseRepository {
  Future<Labelbase> createNewLabelBase({
    required String name,
    required String fingerprint,
    required String about,
    required LabelbaseConnection connection,
  });
  Future<Labelbase> getLabelBase(
    String labelbaseId, {
    required LabelbaseConnection connection,
  });
  Future<List<Labelbase>> getLabelBases({
    required LabelbaseConnection connection,
  });
  Future<void> updateLabelBase(
    Labelbase labelbase, {
    required LabelbaseConnection connection,
  });
  Future<void> removeLabelBase(
    String labelbaseId, {
    required LabelbaseConnection connection,
  });
}
