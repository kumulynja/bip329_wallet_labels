import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bip329_wallet_labels/src/domain/entities/label.dart';
import 'package:bip329_wallet_labels/src/domain/entities/originating_wallet.dart';

part 'generated/label_filter.freezed.dart';

@freezed
sealed class LabelFilter with _$LabelFilter {
  const factory LabelFilter({
    List<LabelType>? type,
    List<String>? labels,
    List<OriginatingWallet>? origins,
    List<String>? txIds,
    List<String>? addresses,
    List<String>? publicKeys,
    List<String>? xpubs,
    List<String>? keyPaths,
  }) = _LabelFilter;
  const LabelFilter._();
}
