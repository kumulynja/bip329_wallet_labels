import 'package:bip329_wallet_labels/src/data/models/label_model.dart';
import 'package:bip329_wallet_labels/src/domain/entities/label.dart';
import 'package:bip329_wallet_labels/src/domain/entities/originating_wallet.dart';

class LabelMapper {
  static LabelModel fromEntity(Label label) {
    switch (label) {
      case TransactionLabel _:
        return LabelModel(
          type: label.type.bip329Type,
          ref: label.txId,
          label: label.label,
          origin: label.origin?.origin,
          height: label.blockHeight,
          time: label.blockTime?.toIso8601String(),
          fee: label.minerFeeSat,
          value: label.valueSat,
          rate: label.exchangeRates,
        );
      case AddressLabel _:
        return LabelModel(
          type: label.type.bip329Type,
          ref: label.address,
          label: label.label,
          origin: label.origin?.origin,
          keypath: label.keyPath,
          heights: label.heights,
        );
      case PubkeyLabel _:
        return LabelModel(
          type: label.type.bip329Type,
          ref: label.publicKey,
          label: label.label,
          origin: label.origin?.origin,
        );
      case InputLabel _:
        return LabelModel(
          type: label.type.bip329Type,
          ref: '${label.txId}:${label.index}',
          label: label.label,
          origin: label.origin?.origin,
          keypath: label.keyPath,
          value: label.valueSat,
          fmv: label.fairMarketValue,
          height: label.blockHeight,
          time: label.blockTime?.toIso8601String(),
        );
      case OutputLabel _:
        return LabelModel(
          type: label.type.bip329Type,
          ref: '${label.txId}:${label.index}',
          label: label.label,
          origin: label.origin?.origin,
          keypath: label.keyPath,
          spendable: label.spendable,
          value: label.valueSat,
          fmv: label.fairMarketValue,
          height: label.blockHeight,
          time: label.blockTime?.toIso8601String(),
        );
      case XpubLabel _:
        return LabelModel(
          type: label.type.bip329Type,
          ref: label.xpub,
          label: label.label,
          origin: label.origin?.origin,
        );
    }
  }

  static Label toEntity(LabelModel model) {
    switch (model.type) {
      case 'transaction':
        return TransactionLabel(
          txId: model.ref,
          label: model.label,
          origin:
              model.origin != null ? OriginatingWallet(model.origin!) : null,
          blockHeight: model.height,
          blockTime: model.time != null ? DateTime.parse(model.time!) : null,
          valueSat: model.value,
          minerFeeSat: model.fee,
          exchangeRates: model.rate,
        );
      case 'address':
        return AddressLabel(
          address: model.ref,
          label: model.label,
          origin:
              model.origin != null ? OriginatingWallet(model.origin!) : null,
          keyPath: model.keypath,
          heights: List<int>.from(model.heights),
        );
      case 'pubkey':
        return PubkeyLabel(
          publicKey: model.ref,
          label: model.label,
          origin:
              model.origin != null ? OriginatingWallet(model.origin!) : null,
        );
      case 'input':
        final parts = model.ref.split(':');
        return InputLabel(
          txId: parts[0],
          index: int.parse(parts[1]),
          label: model.label,
          origin:
              model.origin != null ? OriginatingWallet(model.origin!) : null,
          keyPath: model.keypath,
          valueSat: model.value,
          fairMarketValue: model.fmv,
          blockHeight: model.height,
          blockTime: model.time != null ? DateTime.parse(model.time!) : null,
        );
      case 'output':
        final parts = model.ref.split(':');
        return OutputLabel(
          txId: parts[0],
          index: int.parse(parts[1]),
          label: model.label,
          origin:
              model.origin != null ? OriginatingWallet(model.origin!) : null,
          keyPath: model.keypath,
          spendable: model.spendable ?? false,
          valueSat: model.value,
          fairMarketValue: model.fmv,
          blockHeight: model.height,
          blockTime: model.time != null ? DateTime.parse(model.time!) : null,
        );
      case 'xpub':
        return XpubLabel(
          xpub: model.ref,
          label: model.label,
          origin:
              model.origin != null ? OriginatingWallet(model.origin!) : null,
        );
      default:
        throw LabelTypeException(model.type);
    }
  }
}

class LabelTypeException implements Exception {
  final String message;

  LabelTypeException(this.message);

  @override
  String toString() => 'LabelTypeException: $message';
}
