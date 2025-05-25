import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';

class LabelbaseRepositoryImpl implements LabelbaseRepository {
  final RemoteLabelbaseDatasource _remoteLabelbaseDatasource;

  LabelbaseRepositoryImpl({
    required RemoteLabelbaseDatasource remoteLabelbaseDatasource,
  }) : _remoteLabelbaseDatasource = remoteLabelbaseDatasource;

  @override
  Future<Labelbase> createNewLabelBase({
    required String name,
    required String fingerprint,
    required String about,
    required LabelbaseConnection connection,
  }) {
    // TODO: implement createNewLabelBase
    throw UnimplementedError();
  }

  @override
  Future<Labelbase> getLabelBase(
    String labelbaseId, {
    required LabelbaseConnection connection,
  }) {
    // TODO: implement getLabelBase
    throw UnimplementedError();
  }

  @override
  Future<List<Labelbase>> getLabelBases({
    required LabelbaseConnection connection,
  }) {
    // TODO: implement getLabelBases
    throw UnimplementedError();
  }

  @override
  Future<void> removeLabelBase(
    String labelbaseId, {
    required LabelbaseConnection connection,
  }) {
    // TODO: implement removeLabelBase
    throw UnimplementedError();
  }

  @override
  Future<void> updateLabelBase(
    Labelbase labelbase, {
    required LabelbaseConnection connection,
  }) {
    // TODO: implement updateLabelBase
    throw UnimplementedError();
  }
}
