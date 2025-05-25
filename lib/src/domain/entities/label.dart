import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bip329_wallet_labels/src/domain/entities/originating_wallet.dart';

part 'generated/label.freezed.dart';

enum LabelType {
  transaction(bip329Type: 'tx'),
  address(bip329Type: 'addr'),
  pubkey(bip329Type: 'pubkey'),
  input(bip329Type: 'input'),
  output(bip329Type: 'output'),
  xpub(bip329Type: 'xpub');

  final String bip329Type;
  const LabelType({required this.bip329Type});
}

@freezed
sealed class Label with _$Label {
  const factory Label.transaction({
    required String txId,
    String? label,
    OriginatingWallet? origin,
    int? blockHeight,
    DateTime? blockTime,
    int? valueSat,
    int? minerFeeSat,
    Map<String, double>? exchangeRates,
  }) = TransactionLabel;
  const factory Label.address({
    required String address,
    String? label,
    OriginatingWallet? origin,
    String? keyPath,
    @Default([]) List<int> heights,
  }) = AddressLabel;
  const factory Label.pubkey({
    required String publicKey,
    String? label,
    OriginatingWallet? origin,
  }) = PubkeyLabel;
  const factory Label.input({
    required String txId,
    required int index,
    String? label,
    OriginatingWallet? origin,
    String? keyPath,
    int? valueSat,
    Map<String, double>? fairMarketValue,
    int? blockHeight,
    DateTime? blockTime,
  }) = InputLabel;
  const factory Label.output({
    required String txId,
    required int index,
    String? label,
    OriginatingWallet? origin,
    String? keyPath,
    bool? spendable,
    int? valueSat,
    Map<String, double>? fairMarketValue,
    int? blockHeight,
    DateTime? blockTime,
  }) = OutputLabel;
  const factory Label.xpub({
    required String xpub,
    String? label,
    OriginatingWallet? origin,
    String? keyPath,
  }) = XpubLabel;
  const Label._();

  LabelType get type {
    switch (this) {
      case TransactionLabel():
        return LabelType.transaction;
      case AddressLabel():
        return LabelType.address;
      case PubkeyLabel():
        return LabelType.pubkey;
      case InputLabel():
        return LabelType.input;
      case OutputLabel():
        return LabelType.output;
      case XpubLabel():
        return LabelType.xpub;
    }
  }

  String get ref {
    switch (this) {
      case TransactionLabel(:final txId):
        return txId;
      case AddressLabel(:final address):
        return address;
      case PubkeyLabel(:final publicKey):
        return publicKey;
      case InputLabel(:final txId, :final index):
        return '$txId:$index';
      case OutputLabel(:final txId, :final index):
        return '$txId:$index';
      case XpubLabel(:final xpub):
        return xpub;
    }
  }
}
