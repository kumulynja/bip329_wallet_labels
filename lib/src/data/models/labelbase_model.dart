import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/labelbase_model.freezed.dart';

@freezed
sealed class LabelbaseModel with _$LabelbaseModel {
  const factory LabelbaseModel({
    required String name,
    required String fingerprint,
    required String about,
  }) = NewLabelbaseModel;
  const factory LabelbaseModel.existing({
    required String id,
    required String name,
    required String fingerprint,
    required String about,
    //required String createdAt,
  }) = ExistingLabelbaseModel;
  const LabelbaseModel._();

  ExistingLabelbaseModel existingWith(String labelbaseId) {
    switch (this) {
      case NewLabelbaseModel(:final name, :final fingerprint, :final about):
        return LabelbaseModel.existing(
              id: labelbaseId,
              name: name,
              fingerprint: fingerprint,
              about: about,
            )
            as ExistingLabelbaseModel;
      case ExistingLabelbaseModel():
        return this as ExistingLabelbaseModel;
    }
  }
}
