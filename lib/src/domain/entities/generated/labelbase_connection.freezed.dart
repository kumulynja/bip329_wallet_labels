// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../labelbase_connection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LabelbaseConnection {

 Uri get baseUrl; String get apiKey;
/// Create a copy of LabelbaseConnection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelbaseConnectionCopyWith<LabelbaseConnection> get copyWith => _$LabelbaseConnectionCopyWithImpl<LabelbaseConnection>(this as LabelbaseConnection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabelbaseConnection&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey));
}


@override
int get hashCode => Object.hash(runtimeType,baseUrl,apiKey);

@override
String toString() {
  return 'LabelbaseConnection(baseUrl: $baseUrl, apiKey: $apiKey)';
}


}

/// @nodoc
abstract mixin class $LabelbaseConnectionCopyWith<$Res>  {
  factory $LabelbaseConnectionCopyWith(LabelbaseConnection value, $Res Function(LabelbaseConnection) _then) = _$LabelbaseConnectionCopyWithImpl;
@useResult
$Res call({
 Uri baseUrl, String apiKey
});




}
/// @nodoc
class _$LabelbaseConnectionCopyWithImpl<$Res>
    implements $LabelbaseConnectionCopyWith<$Res> {
  _$LabelbaseConnectionCopyWithImpl(this._self, this._then);

  final LabelbaseConnection _self;
  final $Res Function(LabelbaseConnection) _then;

/// Create a copy of LabelbaseConnection
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


class LabelbaseConnectionBase extends LabelbaseConnection {
  const LabelbaseConnectionBase({required this.baseUrl, required this.apiKey}): super._();
  

@override final  Uri baseUrl;
@override final  String apiKey;

/// Create a copy of LabelbaseConnection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelbaseConnectionBaseCopyWith<LabelbaseConnectionBase> get copyWith => _$LabelbaseConnectionBaseCopyWithImpl<LabelbaseConnectionBase>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabelbaseConnectionBase&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey));
}


@override
int get hashCode => Object.hash(runtimeType,baseUrl,apiKey);

@override
String toString() {
  return 'LabelbaseConnection.base(baseUrl: $baseUrl, apiKey: $apiKey)';
}


}

/// @nodoc
abstract mixin class $LabelbaseConnectionBaseCopyWith<$Res> implements $LabelbaseConnectionCopyWith<$Res> {
  factory $LabelbaseConnectionBaseCopyWith(LabelbaseConnectionBase value, $Res Function(LabelbaseConnectionBase) _then) = _$LabelbaseConnectionBaseCopyWithImpl;
@override @useResult
$Res call({
 Uri baseUrl, String apiKey
});




}
/// @nodoc
class _$LabelbaseConnectionBaseCopyWithImpl<$Res>
    implements $LabelbaseConnectionBaseCopyWith<$Res> {
  _$LabelbaseConnectionBaseCopyWithImpl(this._self, this._then);

  final LabelbaseConnectionBase _self;
  final $Res Function(LabelbaseConnectionBase) _then;

/// Create a copy of LabelbaseConnection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseUrl = null,Object? apiKey = null,}) {
  return _then(LabelbaseConnectionBase(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as Uri,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LabelbaseConnectionWithId extends LabelbaseConnection {
  const LabelbaseConnectionWithId({required this.baseUrl, required this.apiKey, required this.labelbaseId}): super._();
  

@override final  Uri baseUrl;
@override final  String apiKey;
 final  String labelbaseId;

/// Create a copy of LabelbaseConnection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelbaseConnectionWithIdCopyWith<LabelbaseConnectionWithId> get copyWith => _$LabelbaseConnectionWithIdCopyWithImpl<LabelbaseConnectionWithId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabelbaseConnectionWithId&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.labelbaseId, labelbaseId) || other.labelbaseId == labelbaseId));
}


@override
int get hashCode => Object.hash(runtimeType,baseUrl,apiKey,labelbaseId);

@override
String toString() {
  return 'LabelbaseConnection.withId(baseUrl: $baseUrl, apiKey: $apiKey, labelbaseId: $labelbaseId)';
}


}

/// @nodoc
abstract mixin class $LabelbaseConnectionWithIdCopyWith<$Res> implements $LabelbaseConnectionCopyWith<$Res> {
  factory $LabelbaseConnectionWithIdCopyWith(LabelbaseConnectionWithId value, $Res Function(LabelbaseConnectionWithId) _then) = _$LabelbaseConnectionWithIdCopyWithImpl;
@override @useResult
$Res call({
 Uri baseUrl, String apiKey, String labelbaseId
});




}
/// @nodoc
class _$LabelbaseConnectionWithIdCopyWithImpl<$Res>
    implements $LabelbaseConnectionWithIdCopyWith<$Res> {
  _$LabelbaseConnectionWithIdCopyWithImpl(this._self, this._then);

  final LabelbaseConnectionWithId _self;
  final $Res Function(LabelbaseConnectionWithId) _then;

/// Create a copy of LabelbaseConnection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseUrl = null,Object? apiKey = null,Object? labelbaseId = null,}) {
  return _then(LabelbaseConnectionWithId(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as Uri,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,labelbaseId: null == labelbaseId ? _self.labelbaseId : labelbaseId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
