import '../../domain/label_entity.dart';
import '../datasource.dart';
import 'labelbase_datasource.dart';
import 'labelbase_label_model.dart';

class LabelbaseDatasourceAdapter implements LabelDatasource {
  final LabelbaseDatasource _labelbaseDatasource;

  LabelbaseDatasourceAdapter(this._labelbaseDatasource);

  @override
  Future<List<LabelEntity>> getAllLabels() async {
    final labelbaseLabels = await _labelbaseDatasource.getAllLabels();
    return labelbaseLabels.map(_toLabelEntity).toList();
  }

  @override
  Future<LabelEntity?> findExactLabel(LabelEntity searchLabel) async {
    final labelbaseData = _toLabelbaseData(searchLabel);
    final found = await _labelbaseDatasource.findExactLabel(labelbaseData);
    return found != null ? _toLabelEntity(found) : null;
  }

  @override
  Future<LabelEntity> addLabel(LabelEntity label) async {
    final labelbaseData = _toLabelbaseData(label);
    await _labelbaseDatasource.addLabel(labelbaseData);
    return label;
  }

  @override
  Future<void> updateLabel({
    required LabelEntity labelToUpdate,
    required LabelEntity updatedLabel,
  }) async {
    final searchData = _toLabelbaseData(labelToUpdate);
    final existingLabel = await _labelbaseDatasource.findExactLabel(searchData);

    if (existingLabel == null) {
      throw Exception('Label not found');
    }

    final updatedData = _toLabelbaseData(updatedLabel);
    final updatedLabelbaseLabel = LabelbaseLabelModel(
      id: existingLabel.id,
      data: updatedData,
    );

    await _labelbaseDatasource.updateLabel(updatedLabelbaseLabel);
  }

  @override
  Future<void> deleteLabel(LabelEntity label) async {
    final searchData = _toLabelbaseData(label);
    final existingLabel = await _labelbaseDatasource.findExactLabel(searchData);

    if (existingLabel == null) {
      throw Exception('Label not found');
    }

    await _labelbaseDatasource.deleteLabel(existingLabel.id);
  }

  LabelEntity _toLabelEntity(LabelbaseLabelModel labelbaseLabel) {
    final data = labelbaseLabel.data;
    final type = data.type;
    final ref = data.ref;
    final label = data.label;
    final origin = data.origin;

    switch (type) {
      case 'tx':
        return TransactionLabelEntity(txId: ref, label: label, origin: origin);
      case 'addr':
        return AddressLabelEntity(address: ref, label: label, origin: origin);
      case 'pubkey':
        return PubkeyLabelEntity(publicKey: ref, label: label, origin: origin);
      case 'input':
        final parts = ref.split(':');
        return InputLabelEntity(
          txId: parts[0],
          index: int.parse(parts[1]),
          label: label,
          origin: origin,
        );
      case 'output':
        final parts = ref.split(':');
        return OutputLabelEntity(
          txId: parts[0],
          index: int.parse(parts[1]),
          label: label,
          origin: origin,
          spendable: data.spendable,
        );
      case 'xpub':
        return XpubLabelEntity(xpub: ref, label: label, origin: origin);
      default:
        throw Exception('Unknown label type: $type');
    }
  }

  @override
  Future<void> dispose() async {
    _labelbaseDatasource.dispose();
  }

  LabelbaseLabelDataModel _toLabelbaseData(LabelEntity label) {
    bool? spendable;
    if (label is OutputLabelEntity) {
      spendable = label.spendable;
    }

    return LabelbaseLabelDataModel(
      type: label.type.bip329Type,
      ref: label.ref,
      label: label.label,
      origin: label.origin,
      spendable: spendable,
    );
  }
}
