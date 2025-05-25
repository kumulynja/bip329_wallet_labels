// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../label_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LabelFilter {

 List<LabelType>? get type; List<String>? get labels; List<OriginatingWallet>? get origins; List<String>? get txIds; List<String>? get addresses; List<String>? get publicKeys; List<String>? get xpubs; List<String>? get keyPaths;
/// Create a copy of LabelFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelFilterCopyWith<LabelFilter> get copyWith => _$LabelFilterCopyWithImpl<LabelFilter>(this as LabelFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabelFilter&&const DeepCollectionEquality().equals(other.type, type)&&const DeepCollectionEquality().equals(other.labels, labels)&&const DeepCollectionEquality().equals(other.origins, origins)&&const DeepCollectionEquality().equals(other.txIds, txIds)&&const DeepCollectionEquality().equals(other.addresses, addresses)&&const DeepCollectionEquality().equals(other.publicKeys, publicKeys)&&const DeepCollectionEquality().equals(other.xpubs, xpubs)&&const DeepCollectionEquality().equals(other.keyPaths, keyPaths));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(type),const DeepCollectionEquality().hash(labels),const DeepCollectionEquality().hash(origins),const DeepCollectionEquality().hash(txIds),const DeepCollectionEquality().hash(addresses),const DeepCollectionEquality().hash(publicKeys),const DeepCollectionEquality().hash(xpubs),const DeepCollectionEquality().hash(keyPaths));

@override
String toString() {
  return 'LabelFilter(type: $type, labels: $labels, origins: $origins, txIds: $txIds, addresses: $addresses, publicKeys: $publicKeys, xpubs: $xpubs, keyPaths: $keyPaths)';
}


}

/// @nodoc
abstract mixin class $LabelFilterCopyWith<$Res>  {
  factory $LabelFilterCopyWith(LabelFilter value, $Res Function(LabelFilter) _then) = _$LabelFilterCopyWithImpl;
@useResult
$Res call({
 List<LabelType>? type, List<String>? labels, List<OriginatingWallet>? origins, List<String>? txIds, List<String>? addresses, List<String>? publicKeys, List<String>? xpubs, List<String>? keyPaths
});




}
/// @nodoc
class _$LabelFilterCopyWithImpl<$Res>
    implements $LabelFilterCopyWith<$Res> {
  _$LabelFilterCopyWithImpl(this._self, this._then);

  final LabelFilter _self;
  final $Res Function(LabelFilter) _then;

/// Create a copy of LabelFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? labels = freezed,Object? origins = freezed,Object? txIds = freezed,Object? addresses = freezed,Object? publicKeys = freezed,Object? xpubs = freezed,Object? keyPaths = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as List<LabelType>?,labels: freezed == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>?,origins: freezed == origins ? _self.origins : origins // ignore: cast_nullable_to_non_nullable
as List<OriginatingWallet>?,txIds: freezed == txIds ? _self.txIds : txIds // ignore: cast_nullable_to_non_nullable
as List<String>?,addresses: freezed == addresses ? _self.addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<String>?,publicKeys: freezed == publicKeys ? _self.publicKeys : publicKeys // ignore: cast_nullable_to_non_nullable
as List<String>?,xpubs: freezed == xpubs ? _self.xpubs : xpubs // ignore: cast_nullable_to_non_nullable
as List<String>?,keyPaths: freezed == keyPaths ? _self.keyPaths : keyPaths // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// @nodoc


class _LabelFilter extends LabelFilter {
  const _LabelFilter({final  List<LabelType>? type, final  List<String>? labels, final  List<OriginatingWallet>? origins, final  List<String>? txIds, final  List<String>? addresses, final  List<String>? publicKeys, final  List<String>? xpubs, final  List<String>? keyPaths}): _type = type,_labels = labels,_origins = origins,_txIds = txIds,_addresses = addresses,_publicKeys = publicKeys,_xpubs = xpubs,_keyPaths = keyPaths,super._();
  

 final  List<LabelType>? _type;
@override List<LabelType>? get type {
  final value = _type;
  if (value == null) return null;
  if (_type is EqualUnmodifiableListView) return _type;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _labels;
@override List<String>? get labels {
  final value = _labels;
  if (value == null) return null;
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<OriginatingWallet>? _origins;
@override List<OriginatingWallet>? get origins {
  final value = _origins;
  if (value == null) return null;
  if (_origins is EqualUnmodifiableListView) return _origins;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _txIds;
@override List<String>? get txIds {
  final value = _txIds;
  if (value == null) return null;
  if (_txIds is EqualUnmodifiableListView) return _txIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _addresses;
@override List<String>? get addresses {
  final value = _addresses;
  if (value == null) return null;
  if (_addresses is EqualUnmodifiableListView) return _addresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _publicKeys;
@override List<String>? get publicKeys {
  final value = _publicKeys;
  if (value == null) return null;
  if (_publicKeys is EqualUnmodifiableListView) return _publicKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _xpubs;
@override List<String>? get xpubs {
  final value = _xpubs;
  if (value == null) return null;
  if (_xpubs is EqualUnmodifiableListView) return _xpubs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _keyPaths;
@override List<String>? get keyPaths {
  final value = _keyPaths;
  if (value == null) return null;
  if (_keyPaths is EqualUnmodifiableListView) return _keyPaths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of LabelFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LabelFilterCopyWith<_LabelFilter> get copyWith => __$LabelFilterCopyWithImpl<_LabelFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LabelFilter&&const DeepCollectionEquality().equals(other._type, _type)&&const DeepCollectionEquality().equals(other._labels, _labels)&&const DeepCollectionEquality().equals(other._origins, _origins)&&const DeepCollectionEquality().equals(other._txIds, _txIds)&&const DeepCollectionEquality().equals(other._addresses, _addresses)&&const DeepCollectionEquality().equals(other._publicKeys, _publicKeys)&&const DeepCollectionEquality().equals(other._xpubs, _xpubs)&&const DeepCollectionEquality().equals(other._keyPaths, _keyPaths));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_type),const DeepCollectionEquality().hash(_labels),const DeepCollectionEquality().hash(_origins),const DeepCollectionEquality().hash(_txIds),const DeepCollectionEquality().hash(_addresses),const DeepCollectionEquality().hash(_publicKeys),const DeepCollectionEquality().hash(_xpubs),const DeepCollectionEquality().hash(_keyPaths));

@override
String toString() {
  return 'LabelFilter(type: $type, labels: $labels, origins: $origins, txIds: $txIds, addresses: $addresses, publicKeys: $publicKeys, xpubs: $xpubs, keyPaths: $keyPaths)';
}


}

/// @nodoc
abstract mixin class _$LabelFilterCopyWith<$Res> implements $LabelFilterCopyWith<$Res> {
  factory _$LabelFilterCopyWith(_LabelFilter value, $Res Function(_LabelFilter) _then) = __$LabelFilterCopyWithImpl;
@override @useResult
$Res call({
 List<LabelType>? type, List<String>? labels, List<OriginatingWallet>? origins, List<String>? txIds, List<String>? addresses, List<String>? publicKeys, List<String>? xpubs, List<String>? keyPaths
});




}
/// @nodoc
class __$LabelFilterCopyWithImpl<$Res>
    implements _$LabelFilterCopyWith<$Res> {
  __$LabelFilterCopyWithImpl(this._self, this._then);

  final _LabelFilter _self;
  final $Res Function(_LabelFilter) _then;

/// Create a copy of LabelFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? labels = freezed,Object? origins = freezed,Object? txIds = freezed,Object? addresses = freezed,Object? publicKeys = freezed,Object? xpubs = freezed,Object? keyPaths = freezed,}) {
  return _then(_LabelFilter(
type: freezed == type ? _self._type : type // ignore: cast_nullable_to_non_nullable
as List<LabelType>?,labels: freezed == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>?,origins: freezed == origins ? _self._origins : origins // ignore: cast_nullable_to_non_nullable
as List<OriginatingWallet>?,txIds: freezed == txIds ? _self._txIds : txIds // ignore: cast_nullable_to_non_nullable
as List<String>?,addresses: freezed == addresses ? _self._addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<String>?,publicKeys: freezed == publicKeys ? _self._publicKeys : publicKeys // ignore: cast_nullable_to_non_nullable
as List<String>?,xpubs: freezed == xpubs ? _self._xpubs : xpubs // ignore: cast_nullable_to_non_nullable
as List<String>?,keyPaths: freezed == keyPaths ? _self._keyPaths : keyPaths // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
