import '../../domain/label_entity.dart';
import '../../domain/label_type_value_object.dart';
import '../../infrastructure/labelbase/labelbase_label_model.dart';

class LabelEntityMapper {
  static LabelEntity fromLabelbaseLabel(LabelbaseLabelModel labelbaseLabel) {
    final type = LabelTypeValueObject.fromBip329Type(labelbaseLabel.type);
    final data = labelbaseLabel.data;

    switch (type) {
      case LabelTypeValueObject.transaction:
        return TransactionLabelEntity(
          txId: data.ref,
          label: data.label,
          origin: data.origin,
        );

      case LabelTypeValueObject.address:
        return AddressLabelEntity(
          address: data.ref,
          label: data.label,
          origin: data.origin,
        );

      case LabelTypeValueObject.pubkey:
        return PubkeyLabelEntity(
          publicKey: data.ref,
          label: data.label,
          origin: data.origin,
        );

      case LabelTypeValueObject.input:
        final parts = data.ref.split(':');
        return InputLabelEntity(
          txId: parts[0],
          index: int.parse(parts[1]),
          label: data.label,
          origin: data.origin,
        );

      case LabelTypeValueObject.output:
        final parts = data.ref.split(':');
        return OutputLabelEntity(
          txId: parts[0],
          index: int.parse(parts[1]),
          label: data.label,
          origin: data.origin,
          spendable: data.spendable,
        );

      case LabelTypeValueObject.xpub:
        return XpubLabelEntity(
          xpub: data.ref,
          label: data.label,
          origin: data.origin,
        );
    }
  }

  static LabelbaseLabelDataModel toLabelbaseLabelDataModel(LabelEntity entity) {
    switch (entity) {
      case TransactionLabelEntity entity:
        return LabelbaseLabelDataModel(
          type: entity.type.bip329Type,
          ref: entity.ref,
          label: entity.label,
          origin: entity.origin,
        );

      case AddressLabelEntity entity:
        return LabelbaseLabelDataModel(
          type: entity.type.bip329Type,
          ref: entity.ref,
          label: entity.label,
          origin: entity.origin,
        );

      case PubkeyLabelEntity entity:
        return LabelbaseLabelDataModel(
          type: entity.type.bip329Type,
          ref: entity.ref,
          label: entity.label,
          origin: entity.origin,
        );

      case InputLabelEntity entity:
        return LabelbaseLabelDataModel(
          type: entity.type.bip329Type,
          ref: entity.ref,
          label: entity.label,
          origin: entity.origin,
        );

      case OutputLabelEntity entity:
        return LabelbaseLabelDataModel(
          type: entity.type.bip329Type,
          ref: entity.ref,
          label: entity.label,
          origin: entity.origin,
          spendable: entity.spendable,
        );

      case XpubLabelEntity entity:
        return LabelbaseLabelDataModel(
          type: entity.type.bip329Type,
          ref: entity.ref,
          label: entity.label,
          origin: entity.origin,
        );
    }
  }
}
