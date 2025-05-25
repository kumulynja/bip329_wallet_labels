import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/originating_wallet.freezed.dart';

@freezed
sealed class OriginatingWallet with _$OriginatingWallet {
  const factory OriginatingWallet(String origin) = _OriginatingWallet;
  const OriginatingWallet._();

  factory OriginatingWallet.fromOutputDescriptor({
    required String outputDescriptor,
  }) {
    // TODO(kumulynja): Implement logic to extract the origin from an output descriptor.
    final origin = '';
    return OriginatingWallet(origin);
  }
}
