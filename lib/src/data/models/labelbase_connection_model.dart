import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/labelbase_connection_model.freezed.dart';

@freezed
sealed class LabelbaseConnectionModel with _$LabelbaseConnectionModel {
  const factory LabelbaseConnectionModel.unscoped({
    required Uri baseUrl,
    required String apiKey,
  }) = UnscopedLabelbaseConnectionModel;
  const factory LabelbaseConnectionModel.scoped({
    required Uri baseUrl,
    required String apiKey,
    required String labelbaseId,
  }) = ScopedLabelbaseConnectionModel;
  const LabelbaseConnectionModel._();

  Map<String, String> get headers => {'Authorization': 'Token $apiKey'};

  ScopedLabelbaseConnectionModel scopedWith(String labelbaseId) {
    switch (this) {
      case UnscopedLabelbaseConnectionModel(:final baseUrl, :final apiKey):
        return LabelbaseConnectionModel.scoped(
              baseUrl: baseUrl,
              apiKey: apiKey,
              labelbaseId: labelbaseId,
            )
            as ScopedLabelbaseConnectionModel;
      case ScopedLabelbaseConnectionModel():
        return this as ScopedLabelbaseConnectionModel;
    }
  }
}
