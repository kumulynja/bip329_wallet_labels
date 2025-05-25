import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/labelbase.freezed.dart';

@freezed
sealed class Labelbase with _$Labelbase {
  const factory Labelbase({
    required String id,
    required String name,
    required String fingerprint,
    required String about,
  }) = _Labelbase;
  const Labelbase._();
}
