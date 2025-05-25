// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../labelbase_connection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LabelbaseConnectionModel {

 Uri get baseUrl; String get apiKey;
/// Create a copy of LabelbaseConnectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelbaseConnectionModelCopyWith<LabelbaseConnectionModel> get copyWith => _$LabelbaseConnectionModelCopyWithImpl<LabelbaseConnectionModel>(this as LabelbaseConnectionModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabelbaseConnectionModel&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey));
}


@override
int get hashCode => Object.hash(runtimeType,baseUrl,apiKey);

@override
String toString() {
  return 'LabelbaseConnectionModel(baseUrl: $baseUrl, apiKey: $apiKey)';
}


}

/// @nodoc
abstract mixin class $LabelbaseConnectionModelCopyWith<$Res>  {
  factory $LabelbaseConnectionModelCopyWith(LabelbaseConnectionModel value, $Res Function(LabelbaseConnectionModel) _then) = _$LabelbaseConnectionModelCopyWithImpl;
@useResult
$Res call({
 Uri baseUrl, String apiKey
});




}
/// @nodoc
class _$LabelbaseConnectionModelCopyWithImpl<$Res>
    implements $LabelbaseConnectionModelCopyWith<$Res> {
  _$LabelbaseConnectionModelCopyWithImpl(this._self, this._then);

  final LabelbaseConnectionModel _self;
  final $Res Function(LabelbaseConnectionModel) _then;

/// Create a copy of LabelbaseConnectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseUrl = null,Object? apiKey = null,}) {
  return _then(_self.copyWith(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as Uri,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class UnscopedLabelbaseConnectionModel extends LabelbaseConnectionModel {
  const UnscopedLabelbaseConnectionModel({required this.baseUrl, required this.apiKey}): super._();
  

@override final  Uri baseUrl;
@override final  String apiKey;

/// Create a copy of LabelbaseConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnscopedLabelbaseConnectionModelCopyWith<UnscopedLabelbaseConnectionModel> get copyWith => _$UnscopedLabelbaseConnectionModelCopyWithImpl<UnscopedLabelbaseConnectionModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnscopedLabelbaseConnectionModel&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey));
}


@override
int get hashCode => Object.hash(runtimeType,baseUrl,apiKey);

@override
String toString() {
  return 'LabelbaseConnectionModel.unscoped(baseUrl: $baseUrl, apiKey: $apiKey)';
}


}

/// @nodoc
abstract mixin class $UnscopedLabelbaseConnectionModelCopyWith<$Res> implements $LabelbaseConnectionModelCopyWith<$Res> {
  factory $UnscopedLabelbaseConnectionModelCopyWith(UnscopedLabelbaseConnectionModel value, $Res Function(UnscopedLabelbaseConnectionModel) _then) = _$UnscopedLabelbaseConnectionModelCopyWithImpl;
@override @useResult
$Res call({
 Uri baseUrl, String apiKey
});




}
/// @nodoc
class _$UnscopedLabelbaseConnectionModelCopyWithImpl<$Res>
    implements $UnscopedLabelbaseConnectionModelCopyWith<$Res> {
  _$UnscopedLabelbaseConnectionModelCopyWithImpl(this._self, this._then);

  final UnscopedLabelbaseConnectionModel _self;
  final $Res Function(UnscopedLabelbaseConnectionModel) _then;

/// Create a copy of LabelbaseConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseUrl = null,Object? apiKey = null,}) {
  return _then(UnscopedLabelbaseConnectionModel(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as Uri,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ScopedLabelbaseConnectionModel extends LabelbaseConnectionModel {
  const ScopedLabelbaseConnectionModel({required this.baseUrl, required this.apiKey, required this.labelbaseId}): super._();
  

@override final  Uri baseUrl;
@override final  String apiKey;
 final  String labelbaseId;

/// Create a copy of LabelbaseConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScopedLabelbaseConnectionModelCopyWith<ScopedLabelbaseConnectionModel> get copyWith => _$ScopedLabelbaseConnectionModelCopyWithImpl<ScopedLabelbaseConnectionModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScopedLabelbaseConnectionModel&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.labelbaseId, labelbaseId) || other.labelbaseId == labelbaseId));
}


@override
int get hashCode => Object.hash(runtimeType,baseUrl,apiKey,labelbaseId);

@override
String toString() {
  return 'LabelbaseConnectionModel.scoped(baseUrl: $baseUrl, apiKey: $apiKey, labelbaseId: $labelbaseId)';
}


}

/// @nodoc
abstract mixin class $ScopedLabelbaseConnectionModelCopyWith<$Res> implements $LabelbaseConnectionModelCopyWith<$Res> {
  factory $ScopedLabelbaseConnectionModelCopyWith(ScopedLabelbaseConnectionModel value, $Res Function(ScopedLabelbaseConnectionModel) _then) = _$ScopedLabelbaseConnectionModelCopyWithImpl;
@override @useResult
$Res call({
 Uri baseUrl, String apiKey, String labelbaseId
});




}
/// @nodoc
class _$ScopedLabelbaseConnectionModelCopyWithImpl<$Res>
    implements $ScopedLabelbaseConnectionModelCopyWith<$Res> {
  _$ScopedLabelbaseConnectionModelCopyWithImpl(this._self, this._then);

  final ScopedLabelbaseConnectionModel _self;
  final $Res Function(ScopedLabelbaseConnectionModel) _then;

/// Create a copy of LabelbaseConnectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseUrl = null,Object? apiKey = null,Object? labelbaseId = null,}) {
  return _then(ScopedLabelbaseConnectionModel(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as Uri,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,labelbaseId: null == labelbaseId ? _self.labelbaseId : labelbaseId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
