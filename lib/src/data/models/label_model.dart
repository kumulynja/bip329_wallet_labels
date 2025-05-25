import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/label_model.freezed.dart';
part 'generated/label_model.g.dart';

@freezed
sealed class LabelModel with _$LabelModel {
  const factory LabelModel({
    required String type,
    required String ref,
    String? label,
    String? origin,
    bool? spendable,
    int? height,
    String? time,
    int? fee,
    int? value,
    Map<String, double>? rate,
    String? keypath,
    Map<String, double>? fmv,
    @Default([]) List<int> heights,
  }) = _LabelModel;
  const LabelModel._();

  factory LabelModel.fromJson(Map<String, dynamic> json) =>
      _$LabelModelFromJson(json);
}
