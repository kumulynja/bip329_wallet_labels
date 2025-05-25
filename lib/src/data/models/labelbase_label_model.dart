import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bip329_wallet_labels/src/data/models/label_model.dart';

part 'generated/labelbase_label_model.freezed.dart';

@freezed
sealed class LabelbaseLabelModel with _$LabelbaseLabelModel {
  const factory LabelbaseLabelModel({
    required String id,
    required LabelModel label,
  }) = _LabelbaseLabelModel;
  const LabelbaseLabelModel._();

  factory LabelbaseLabelModel.fromLabelModel(
    LabelModel label, {
    required String labelbaseLabelId,
  }) {
    return LabelbaseLabelModel(id: labelbaseLabelId, label: label);
  }
}
