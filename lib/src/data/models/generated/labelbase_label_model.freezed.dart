// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../labelbase_label_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LabelbaseLabelModel {

 String get id; LabelModel get label;
/// Create a copy of LabelbaseLabelModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelbaseLabelModelCopyWith<LabelbaseLabelModel> get copyWith => _$LabelbaseLabelModelCopyWithImpl<LabelbaseLabelModel>(this as LabelbaseLabelModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabelbaseLabelModel&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'LabelbaseLabelModel(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class $LabelbaseLabelModelCopyWith<$Res>  {
  factory $LabelbaseLabelModelCopyWith(LabelbaseLabelModel value, $Res Function(LabelbaseLabelModel) _then) = _$LabelbaseLabelModelCopyWithImpl;
@useResult
$Res call({
 String id, LabelModel label
});


$LabelModelCopyWith<$Res> get label;

}
/// @nodoc
class _$LabelbaseLabelModelCopyWithImpl<$Res>
    implements $LabelbaseLabelModelCopyWith<$Res> {
  _$LabelbaseLabelModelCopyWithImpl(this._self, this._then);

  final LabelbaseLabelModel _self;
  final $Res Function(LabelbaseLabelModel) _then;

/// Create a copy of LabelbaseLabelModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LabelModel,
  ));
}
/// Create a copy of LabelbaseLabelModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LabelModelCopyWith<$Res> get label {
  
  return $LabelModelCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}
}


/// @nodoc


class _LabelbaseLabelModel extends LabelbaseLabelModel {
  const _LabelbaseLabelModel({required this.id, required this.label}): super._();
  

@override final  String id;
@override final  LabelModel label;

/// Create a copy of LabelbaseLabelModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LabelbaseLabelModelCopyWith<_LabelbaseLabelModel> get copyWith => __$LabelbaseLabelModelCopyWithImpl<_LabelbaseLabelModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LabelbaseLabelModel&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,id,label);

@override
String toString() {
  return 'LabelbaseLabelModel(id: $id, label: $label)';
}


}

/// @nodoc
abstract mixin class _$LabelbaseLabelModelCopyWith<$Res> implements $LabelbaseLabelModelCopyWith<$Res> {
  factory _$LabelbaseLabelModelCopyWith(_LabelbaseLabelModel value, $Res Function(_LabelbaseLabelModel) _then) = __$LabelbaseLabelModelCopyWithImpl;
@override @useResult
$Res call({
 String id, LabelModel label
});


@override $LabelModelCopyWith<$Res> get label;

}
/// @nodoc
class __$LabelbaseLabelModelCopyWithImpl<$Res>
    implements _$LabelbaseLabelModelCopyWith<$Res> {
  __$LabelbaseLabelModelCopyWithImpl(this._self, this._then);

  final _LabelbaseLabelModel _self;
  final $Res Function(_LabelbaseLabelModel) _then;

/// Create a copy of LabelbaseLabelModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,}) {
  return _then(_LabelbaseLabelModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LabelModel,
  ));
}

/// Create a copy of LabelbaseLabelModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LabelModelCopyWith<$Res> get label {
  
  return $LabelModelCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}
}

// dart format on
