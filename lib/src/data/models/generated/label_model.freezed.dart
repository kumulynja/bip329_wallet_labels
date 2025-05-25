// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../label_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LabelModel {

 String get type; String get ref; String? get label; String? get origin; bool? get spendable; int? get height; String? get time; int? get fee; int? get value; Map<String, double>? get rate; String? get keypath; Map<String, double>? get fmv; List<int> get heights;
/// Create a copy of LabelModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelModelCopyWith<LabelModel> get copyWith => _$LabelModelCopyWithImpl<LabelModel>(this as LabelModel, _$identity);

  /// Serializes this LabelModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabelModel&&(identical(other.type, type) || other.type == type)&&(identical(other.ref, ref) || other.ref == ref)&&(identical(other.label, label) || other.label == label)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.spendable, spendable) || other.spendable == spendable)&&(identical(other.height, height) || other.height == height)&&(identical(other.time, time) || other.time == time)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.rate, rate)&&(identical(other.keypath, keypath) || other.keypath == keypath)&&const DeepCollectionEquality().equals(other.fmv, fmv)&&const DeepCollectionEquality().equals(other.heights, heights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,ref,label,origin,spendable,height,time,fee,value,const DeepCollectionEquality().hash(rate),keypath,const DeepCollectionEquality().hash(fmv),const DeepCollectionEquality().hash(heights));

@override
String toString() {
  return 'LabelModel(type: $type, ref: $ref, label: $label, origin: $origin, spendable: $spendable, height: $height, time: $time, fee: $fee, value: $value, rate: $rate, keypath: $keypath, fmv: $fmv, heights: $heights)';
}


}

/// @nodoc
abstract mixin class $LabelModelCopyWith<$Res>  {
  factory $LabelModelCopyWith(LabelModel value, $Res Function(LabelModel) _then) = _$LabelModelCopyWithImpl;
@useResult
$Res call({
 String type, String ref, String? label, String? origin, bool? spendable, int? height, String? time, int? fee, int? value, Map<String, double>? rate, String? keypath, Map<String, double>? fmv, List<int> heights
});




}
/// @nodoc
class _$LabelModelCopyWithImpl<$Res>
    implements $LabelModelCopyWith<$Res> {
  _$LabelModelCopyWithImpl(this._self, this._then);

  final LabelModel _self;
  final $Res Function(LabelModel) _then;

/// Create a copy of LabelModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? ref = null,Object? label = freezed,Object? origin = freezed,Object? spendable = freezed,Object? height = freezed,Object? time = freezed,Object? fee = freezed,Object? value = freezed,Object? rate = freezed,Object? keypath = freezed,Object? fmv = freezed,Object? heights = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,ref: null == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String?,spendable: freezed == spendable ? _self.spendable : spendable // ignore: cast_nullable_to_non_nullable
as bool?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,fee: freezed == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as int?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,rate: freezed == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,keypath: freezed == keypath ? _self.keypath : keypath // ignore: cast_nullable_to_non_nullable
as String?,fmv: freezed == fmv ? _self.fmv : fmv // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,heights: null == heights ? _self.heights : heights // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LabelModel extends LabelModel {
  const _LabelModel({required this.type, required this.ref, this.label, this.origin, this.spendable, this.height, this.time, this.fee, this.value, final  Map<String, double>? rate, this.keypath, final  Map<String, double>? fmv, final  List<int> heights = const []}): _rate = rate,_fmv = fmv,_heights = heights,super._();
  factory _LabelModel.fromJson(Map<String, dynamic> json) => _$LabelModelFromJson(json);

@override final  String type;
@override final  String ref;
@override final  String? label;
@override final  String? origin;
@override final  bool? spendable;
@override final  int? height;
@override final  String? time;
@override final  int? fee;
@override final  int? value;
 final  Map<String, double>? _rate;
@override Map<String, double>? get rate {
  final value = _rate;
  if (value == null) return null;
  if (_rate is EqualUnmodifiableMapView) return _rate;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? keypath;
 final  Map<String, double>? _fmv;
@override Map<String, double>? get fmv {
  final value = _fmv;
  if (value == null) return null;
  if (_fmv is EqualUnmodifiableMapView) return _fmv;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<int> _heights;
@override@JsonKey() List<int> get heights {
  if (_heights is EqualUnmodifiableListView) return _heights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_heights);
}


/// Create a copy of LabelModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LabelModelCopyWith<_LabelModel> get copyWith => __$LabelModelCopyWithImpl<_LabelModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LabelModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LabelModel&&(identical(other.type, type) || other.type == type)&&(identical(other.ref, ref) || other.ref == ref)&&(identical(other.label, label) || other.label == label)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.spendable, spendable) || other.spendable == spendable)&&(identical(other.height, height) || other.height == height)&&(identical(other.time, time) || other.time == time)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other._rate, _rate)&&(identical(other.keypath, keypath) || other.keypath == keypath)&&const DeepCollectionEquality().equals(other._fmv, _fmv)&&const DeepCollectionEquality().equals(other._heights, _heights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,ref,label,origin,spendable,height,time,fee,value,const DeepCollectionEquality().hash(_rate),keypath,const DeepCollectionEquality().hash(_fmv),const DeepCollectionEquality().hash(_heights));

@override
String toString() {
  return 'LabelModel(type: $type, ref: $ref, label: $label, origin: $origin, spendable: $spendable, height: $height, time: $time, fee: $fee, value: $value, rate: $rate, keypath: $keypath, fmv: $fmv, heights: $heights)';
}


}

/// @nodoc
abstract mixin class _$LabelModelCopyWith<$Res> implements $LabelModelCopyWith<$Res> {
  factory _$LabelModelCopyWith(_LabelModel value, $Res Function(_LabelModel) _then) = __$LabelModelCopyWithImpl;
@override @useResult
$Res call({
 String type, String ref, String? label, String? origin, bool? spendable, int? height, String? time, int? fee, int? value, Map<String, double>? rate, String? keypath, Map<String, double>? fmv, List<int> heights
});




}
/// @nodoc
class __$LabelModelCopyWithImpl<$Res>
    implements _$LabelModelCopyWith<$Res> {
  __$LabelModelCopyWithImpl(this._self, this._then);

  final _LabelModel _self;
  final $Res Function(_LabelModel) _then;

/// Create a copy of LabelModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? ref = null,Object? label = freezed,Object? origin = freezed,Object? spendable = freezed,Object? height = freezed,Object? time = freezed,Object? fee = freezed,Object? value = freezed,Object? rate = freezed,Object? keypath = freezed,Object? fmv = freezed,Object? heights = null,}) {
  return _then(_LabelModel(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,ref: null == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String?,spendable: freezed == spendable ? _self.spendable : spendable // ignore: cast_nullable_to_non_nullable
as bool?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,fee: freezed == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as int?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int?,rate: freezed == rate ? _self._rate : rate // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,keypath: freezed == keypath ? _self.keypath : keypath // ignore: cast_nullable_to_non_nullable
as String?,fmv: freezed == fmv ? _self._fmv : fmv // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,heights: null == heights ? _self._heights : heights // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
