import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/labelbase_connection.freezed.dart';

@freezed
sealed class LabelbaseConnection with _$LabelbaseConnection {
  const factory LabelbaseConnection.base({
    required Uri baseUrl,
    required String apiKey,
  }) = LabelbaseConnectionBase;
  const factory LabelbaseConnection.withId({
    required Uri baseUrl,
    required String apiKey,
    required String labelbaseId,
  }) = LabelbaseConnectionWithId;
  const LabelbaseConnection._();
}
