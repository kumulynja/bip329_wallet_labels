import '../../domain/label_entity.dart';
import '../datasource.dart';
import 'local_encrypted_datasource.dart';
import 'simple_label_entity.dart';

class LocalEncryptedDatasourceAdapter implements LabelDatasource {
  final LocalEncryptedDatasource _localDatasource;

  LocalEncryptedDatasourceAdapter(this._localDatasource);

  Future<void> initialize() async {
    await _localDatasource.initialize();
  }

  @override
  Future<List<LabelEntity>> getAllLabels() async {
    final simpleLabels = await _localDatasource.getAllLabels();
    return simpleLabels.map(_toLabelEntity).toList();
  }

  @override
  Future<LabelEntity?> findExactLabel(LabelEntity searchLabel) async {
    final simpleLabel = _toSimpleLabel(searchLabel);
    final found = await _localDatasource.findExactLabel(simpleLabel);
    return found != null ? _toLabelEntity(found) : null;
  }

  @override
  Future<LabelEntity> addLabel(LabelEntity label) async {
    final simpleLabel = _toSimpleLabel(label);
    await _localDatasource.addLabel(simpleLabel);
    return label;
  }

  @override
  Future<void> updateLabel({
    required LabelEntity labelToUpdate,
    required LabelEntity updatedLabel,
  }) async {
    final simpleLabelToUpdate = _toSimpleLabel(labelToUpdate);
    final simpleUpdatedLabel = _toSimpleLabel(updatedLabel);

    await _localDatasource.updateLabel(
      labelToUpdate: simpleLabelToUpdate,
      updatedLabel: simpleUpdatedLabel,
    );
  }

  @override
  Future<void> deleteLabel(LabelEntity label) async {
    final simpleLabel = _toSimpleLabel(label);
    await _localDatasource.deleteLabel(simpleLabel);
  }

  Future<void> changePassphrase(String newPassphrase) async {
    await _localDatasource.changePassphrase(newPassphrase);
  }

  Future<void> close() async {
    await _localDatasource.close();
  }

  @override
  Future<void> dispose() async {
    await _localDatasource.close();
  }

  LabelEntity _toLabelEntity(SimpleLabelEntity simpleLabel) {
    final type = simpleLabel.type;
    final ref = simpleLabel.ref;
    final label = simpleLabel.label;
    final origin = simpleLabel.origin;

    switch (type) {
      case LabelType.tx:
        return TransactionLabelEntity(
          txId: ref,
          label: label,
          origin: origin,
        );
      case LabelType.address:
        return AddressLabelEntity(
          address: ref,
          label: label,
          origin: origin,
        );
      case LabelType.pubkey:
        return PubkeyLabelEntity(
          publicKey: ref,
          label: label,
          origin: origin,
        );
      case LabelType.input:
        final parts = ref.split(':');
        return InputLabelEntity(
          txId: parts[0],
          index: int.parse(parts[1]),
          label: label,
          origin: origin,
        );
      case LabelType.output:
        final parts = ref.split(':');
        return OutputLabelEntity(
          txId: parts[0],
          index: int.parse(parts[1]),
          label: label,
          origin: origin,
          spendable: simpleLabel.spendable,
        );
      case LabelType.xpub:
        return XpubLabelEntity(
          xpub: ref,
          label: label,
          origin: origin,
        );
    }
  }

  SimpleLabelEntity _toSimpleLabel(LabelEntity label) {
    bool? spendable;
    if (label is OutputLabelEntity) {
      spendable = label.spendable;
    }

    LabelType type;
    switch (label.type.bip329Type) {
      case 'tx':
        type = LabelType.tx;
        break;
      case 'addr':
        type = LabelType.address;
        break;
      case 'pubkey':
        type = LabelType.pubkey;
        break;
      case 'input':
        type = LabelType.input;
        break;
      case 'output':
        type = LabelType.output;
        break;
      case 'xpub':
        type = LabelType.xpub;
        break;
      default:
        throw Exception('Unknown label type: ${label.type.bip329Type}');
    }

    return SimpleLabelEntity(
      type: type,
      ref: label.ref,
      label: label.label,
      origin: label.origin,
      spendable: spendable,
    );
  }
}