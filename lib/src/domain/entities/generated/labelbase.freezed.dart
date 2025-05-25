// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../labelbase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Labelbase {

 String get id; String get name; String get fingerprint; String get about;
/// Create a copy of Labelbase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelbaseCopyWith<Labelbase> get copyWith => _$LabelbaseCopyWithImpl<Labelbase>(this as Labelbase, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Labelbase&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.fingerprint, fingerprint) || other.fingerprint == fingerprint)&&(identical(other.about, about) || other.about == about));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,fingerprint,about);

@override
String toString() {
  return 'Labelbase(id: $id, name: $name, fingerprint: $fingerprint, about: $about)';
}


}

/// @nodoc
abstract mixin class $LabelbaseCopyWith<$Res>  {
  factory $LabelbaseCopyWith(Labelbase value, $Res Function(Labelbase) _then) = _$LabelbaseCopyWithImpl;
@useResult
$Res call({
 String id, String name, String fingerprint, String about
});




}
/// @nodoc
class _$LabelbaseCopyWithImpl<$Res>
    implements $LabelbaseCopyWith<$Res> {
  _$LabelbaseCopyWithImpl(this._self, this._then);

  final Labelbase _self;
  final $Res Function(Labelbase) _then;

/// Create a copy of Labelbase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? fingerprint = null,Object? about = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fingerprint: null == fingerprint ? _self.fingerprint : fingerprint // ignore: cast_nullable_to_non_nullable
as String,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _Labelbase extends Labelbase {
  const _Labelbase({required this.id, required this.name, required this.fingerprint, required this.about}): super._();
  

@override final  String id;
@override final  String name;
@override final  String fingerprint;
@override final  String about;

/// Create a copy of Labelbase
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LabelbaseCopyWith<_Labelbase> get copyWith => __$LabelbaseCopyWithImpl<_Labelbase>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Labelbase&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.fingerprint, fingerprint) || other.fingerprint == fingerprint)&&(identical(other.about, about) || other.about == about));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,fingerprint,about);

@override
String toString() {
  return 'Labelbase(id: $id, name: $name, fingerprint: $fingerprint, about: $about)';
}


}

/// @nodoc
abstract mixin class _$LabelbaseCopyWith<$Res> implements $LabelbaseCopyWith<$Res> {
  factory _$LabelbaseCopyWith(_Labelbase value, $Res Function(_Labelbase) _then) = __$LabelbaseCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String fingerprint, String about
});




}
/// @nodoc
class __$LabelbaseCopyWithImpl<$Res>
    implements _$LabelbaseCopyWith<$Res> {
  __$LabelbaseCopyWithImpl(this._self, this._then);

  final _Labelbase _self;
  final $Res Function(_Labelbase) _then;

/// Create a copy of Labelbase
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? fingerprint = null,Object? about = null,}) {
  return _then(_Labelbase(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fingerprint: null == fingerprint ? _self.fingerprint : fingerprint // ignore: cast_nullable_to_non_nullable
as String,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
