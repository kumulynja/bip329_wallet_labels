import 'package:bip329_wallet_labels/bip329_wallet_labels.dart';

class LabelRepositoryImpl implements LabelRepository {
  final LocalBip329FileDatasource _localBip329FileDatasource;
  final RemoteLabelbaseDatasource _remoteLabelbaseDatasource;

  LabelRepositoryImpl({
    required LocalBip329FileDatasource localDatasource,
    required RemoteLabelbaseDatasource remoteDatasource,
  }) : _localBip329FileDatasource = localDatasource,
       _remoteLabelbaseDatasource = remoteDatasource;

  @override
  Future<void> addLabel(
    Label label, {
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  }) {
    // TODO: implement addLabel
    throw UnimplementedError();
  }

  @override
  Future<Label> getLabel(
    String label, {
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  }) {
    // TODO: implement getLabel
    throw UnimplementedError();
  }

  @override
  Future<List<Label>> getLabels({
    LabelFilter? filter,
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  }) {
    // TODO: implement getLabels
    throw UnimplementedError();
  }

  @override
  Future<void> removeLabel(
    Label label, {
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  }) {
    // TODO: implement removeLabel
    throw UnimplementedError();
  }

  @override
  Future<void> removeLabels({
    LabelFilter? filter,
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  }) {
    // TODO: implement removeLabels
    throw UnimplementedError();
  }

  @override
  Future<void> updateLabel(
    Label label, {
    required String filePath,
    LabelbaseConnectionWithId? labelbaseConnection,
  }) {
    // TODO: implement updateLabel
    throw UnimplementedError();
  }
}
