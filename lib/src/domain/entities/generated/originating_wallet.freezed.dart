// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../originating_wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OriginatingWallet {

 String get origin;
/// Create a copy of OriginatingWallet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OriginatingWalletCopyWith<OriginatingWallet> get copyWith => _$OriginatingWalletCopyWithImpl<OriginatingWallet>(this as OriginatingWallet, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OriginatingWallet&&(identical(other.origin, origin) || other.origin == origin));
}


@override
int get hashCode => Object.hash(runtimeType,origin);

@override
String toString() {
  return 'OriginatingWallet(origin: $origin)';
}


}

/// @nodoc
abstract mixin class $OriginatingWalletCopyWith<$Res>  {
  factory $OriginatingWalletCopyWith(OriginatingWallet value, $Res Function(OriginatingWallet) _then) = _$OriginatingWalletCopyWithImpl;
@useResult
$Res call({
 String origin
});




}
/// @nodoc
class _$OriginatingWalletCopyWithImpl<$Res>
    implements $OriginatingWalletCopyWith<$Res> {
  _$OriginatingWalletCopyWithImpl(this._self, this._then);

  final OriginatingWallet _self;
  final $Res Function(OriginatingWallet) _then;

/// Create a copy of OriginatingWallet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? origin = null,}) {
  return _then(_self.copyWith(
origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _OriginatingWallet extends OriginatingWallet {
  const _OriginatingWallet(this.origin): super._();
  

@override final  String origin;

/// Create a copy of OriginatingWallet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OriginatingWalletCopyWith<_OriginatingWallet> get copyWith => __$OriginatingWalletCopyWithImpl<_OriginatingWallet>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OriginatingWallet&&(identical(other.origin, origin) || other.origin == origin));
}


@override
int get hashCode => Object.hash(runtimeType,origin);

@override
String toString() {
  return 'OriginatingWallet(origin: $origin)';
}


}

/// @nodoc
abstract mixin class _$OriginatingWalletCopyWith<$Res> implements $OriginatingWalletCopyWith<$Res> {
  factory _$OriginatingWalletCopyWith(_OriginatingWallet value, $Res Function(_OriginatingWallet) _then) = __$OriginatingWalletCopyWithImpl;
@override @useResult
$Res call({
 String origin
});




}
/// @nodoc
class __$OriginatingWalletCopyWithImpl<$Res>
    implements _$OriginatingWalletCopyWith<$Res> {
  __$OriginatingWalletCopyWithImpl(this._self, this._then);

  final _OriginatingWallet _self;
  final $Res Function(_OriginatingWallet) _then;

/// Create a copy of OriginatingWallet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? origin = null,}) {
  return _then(_OriginatingWallet(
null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
