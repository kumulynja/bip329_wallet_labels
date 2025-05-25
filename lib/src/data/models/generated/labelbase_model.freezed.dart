// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../labelbase_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LabelbaseModel {

 String get name; String get fingerprint; String get about;
/// Create a copy of LabelbaseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelbaseModelCopyWith<LabelbaseModel> get copyWith => _$LabelbaseModelCopyWithImpl<LabelbaseModel>(this as LabelbaseModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabelbaseModel&&(identical(other.name, name) || other.name == name)&&(identical(other.fingerprint, fingerprint) || other.fingerprint == fingerprint)&&(identical(other.about, about) || other.about == about));
}


@override
int get hashCode => Object.hash(runtimeType,name,fingerprint,about);

@override
String toString() {
  return 'LabelbaseModel(name: $name, fingerprint: $fingerprint, about: $about)';
}


}

/// @nodoc
abstract mixin class $LabelbaseModelCopyWith<$Res>  {
  factory $LabelbaseModelCopyWith(LabelbaseModel value, $Res Function(LabelbaseModel) _then) = _$LabelbaseModelCopyWithImpl;
@useResult
$Res call({
 String name, String fingerprint, String about
});




}
/// @nodoc
class _$LabelbaseModelCopyWithImpl<$Res>
    implements $LabelbaseModelCopyWith<$Res> {
  _$LabelbaseModelCopyWithImpl(this._self, this._then);

  final LabelbaseModel _self;
  final $Res Function(LabelbaseModel) _then;

/// Create a copy of LabelbaseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? fingerprint = null,Object? about = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fingerprint: null == fingerprint ? _self.fingerprint : fingerprint // ignore: cast_nullable_to_non_nullable
as String,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class NewLabelbaseModel extends LabelbaseModel {
  const NewLabelbaseModel({required this.name, required this.fingerprint, required this.about}): super._();
  

@override final  String name;
@override final  String fingerprint;
@override final  String about;

/// Create a copy of LabelbaseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewLabelbaseModelCopyWith<NewLabelbaseModel> get copyWith => _$NewLabelbaseModelCopyWithImpl<NewLabelbaseModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewLabelbaseModel&&(identical(other.name, name) || other.name == name)&&(identical(other.fingerprint, fingerprint) || other.fingerprint == fingerprint)&&(identical(other.about, about) || other.about == about));
}


@override
int get hashCode => Object.hash(runtimeType,name,fingerprint,about);

@override
String toString() {
  return 'LabelbaseModel(name: $name, fingerprint: $fingerprint, about: $about)';
}


}

/// @nodoc
abstract mixin class $NewLabelbaseModelCopyWith<$Res> implements $LabelbaseModelCopyWith<$Res> {
  factory $NewLabelbaseModelCopyWith(NewLabelbaseModel value, $Res Function(NewLabelbaseModel) _then) = _$NewLabelbaseModelCopyWithImpl;
@override @useResult
$Res call({
 String name, String fingerprint, String about
});




}
/// @nodoc
class _$NewLabelbaseModelCopyWithImpl<$Res>
    implements $NewLabelbaseModelCopyWith<$Res> {
  _$NewLabelbaseModelCopyWithImpl(this._self, this._then);

  final NewLabelbaseModel _self;
  final $Res Function(NewLabelbaseModel) _then;

/// Create a copy of LabelbaseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? fingerprint = null,Object? about = null,}) {
  return _then(NewLabelbaseModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fingerprint: null == fingerprint ? _self.fingerprint : fingerprint // ignore: cast_nullable_to_non_nullable
as String,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ExistingLabelbaseModel extends LabelbaseModel {
  const ExistingLabelbaseModel({required this.id, required this.name, required this.fingerprint, required this.about}): super._();
  

 final  String id;
@override final  String name;
@override final  String fingerprint;
@override final  String about;

/// Create a copy of LabelbaseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExistingLabelbaseModelCopyWith<ExistingLabelbaseModel> get copyWith => _$ExistingLabelbaseModelCopyWithImpl<ExistingLabelbaseModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExistingLabelbaseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.fingerprint, fingerprint) || other.fingerprint == fingerprint)&&(identical(other.about, about) || other.about == about));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,fingerprint,about);

@override
String toString() {
  return 'LabelbaseModel.existing(id: $id, name: $name, fingerprint: $fingerprint, about: $about)';
}


}

/// @nodoc
abstract mixin class $ExistingLabelbaseModelCopyWith<$Res> implements $LabelbaseModelCopyWith<$Res> {
  factory $ExistingLabelbaseModelCopyWith(ExistingLabelbaseModel value, $Res Function(ExistingLabelbaseModel) _then) = _$ExistingLabelbaseModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String fingerprint, String about
});




}
/// @nodoc
class _$ExistingLabelbaseModelCopyWithImpl<$Res>
    implements $ExistingLabelbaseModelCopyWith<$Res> {
  _$ExistingLabelbaseModelCopyWithImpl(this._self, this._then);

  final ExistingLabelbaseModel _self;
  final $Res Function(ExistingLabelbaseModel) _then;

/// Create a copy of LabelbaseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? fingerprint = null,Object? about = null,}) {
  return _then(ExistingLabelbaseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,fingerprint: null == fingerprint ? _self.fingerprint : fingerprint // ignore: cast_nullable_to_non_nullable
as String,about: null == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
