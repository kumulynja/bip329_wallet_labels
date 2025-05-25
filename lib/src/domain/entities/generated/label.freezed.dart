// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../label.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Label {

 String? get label; OriginatingWallet? get origin;
/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelCopyWith<Label> get copyWith => _$LabelCopyWithImpl<Label>(this as Label, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Label&&(identical(other.label, label) || other.label == label)&&(identical(other.origin, origin) || other.origin == origin));
}


@override
int get hashCode => Object.hash(runtimeType,label,origin);

@override
String toString() {
  return 'Label(label: $label, origin: $origin)';
}


}

/// @nodoc
abstract mixin class $LabelCopyWith<$Res>  {
  factory $LabelCopyWith(Label value, $Res Function(Label) _then) = _$LabelCopyWithImpl;
@useResult
$Res call({
 String? label, OriginatingWallet? origin
});


$OriginatingWalletCopyWith<$Res>? get origin;

}
/// @nodoc
class _$LabelCopyWithImpl<$Res>
    implements $LabelCopyWith<$Res> {
  _$LabelCopyWithImpl(this._self, this._then);

  final Label _self;
  final $Res Function(Label) _then;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = freezed,Object? origin = freezed,}) {
  return _then(_self.copyWith(
label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as OriginatingWallet?,
  ));
}
/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OriginatingWalletCopyWith<$Res>? get origin {
    if (_self.origin == null) {
    return null;
  }

  return $OriginatingWalletCopyWith<$Res>(_self.origin!, (value) {
    return _then(_self.copyWith(origin: value));
  });
}
}


/// @nodoc


class TransactionLabel extends Label {
  const TransactionLabel({required this.txId, this.label, this.origin, this.blockHeight, this.blockTime, this.valueSat, this.minerFeeSat, final  Map<String, double>? exchangeRates}): _exchangeRates = exchangeRates,super._();
  

 final  String txId;
@override final  String? label;
@override final  OriginatingWallet? origin;
 final  int? blockHeight;
 final  DateTime? blockTime;
 final  int? valueSat;
 final  int? minerFeeSat;
 final  Map<String, double>? _exchangeRates;
 Map<String, double>? get exchangeRates {
  final value = _exchangeRates;
  if (value == null) return null;
  if (_exchangeRates is EqualUnmodifiableMapView) return _exchangeRates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionLabelCopyWith<TransactionLabel> get copyWith => _$TransactionLabelCopyWithImpl<TransactionLabel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionLabel&&(identical(other.txId, txId) || other.txId == txId)&&(identical(other.label, label) || other.label == label)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.blockHeight, blockHeight) || other.blockHeight == blockHeight)&&(identical(other.blockTime, blockTime) || other.blockTime == blockTime)&&(identical(other.valueSat, valueSat) || other.valueSat == valueSat)&&(identical(other.minerFeeSat, minerFeeSat) || other.minerFeeSat == minerFeeSat)&&const DeepCollectionEquality().equals(other._exchangeRates, _exchangeRates));
}


@override
int get hashCode => Object.hash(runtimeType,txId,label,origin,blockHeight,blockTime,valueSat,minerFeeSat,const DeepCollectionEquality().hash(_exchangeRates));

@override
String toString() {
  return 'Label.transaction(txId: $txId, label: $label, origin: $origin, blockHeight: $blockHeight, blockTime: $blockTime, valueSat: $valueSat, minerFeeSat: $minerFeeSat, exchangeRates: $exchangeRates)';
}


}

/// @nodoc
abstract mixin class $TransactionLabelCopyWith<$Res> implements $LabelCopyWith<$Res> {
  factory $TransactionLabelCopyWith(TransactionLabel value, $Res Function(TransactionLabel) _then) = _$TransactionLabelCopyWithImpl;
@override @useResult
$Res call({
 String txId, String? label, OriginatingWallet? origin, int? blockHeight, DateTime? blockTime, int? valueSat, int? minerFeeSat, Map<String, double>? exchangeRates
});


@override $OriginatingWalletCopyWith<$Res>? get origin;

}
/// @nodoc
class _$TransactionLabelCopyWithImpl<$Res>
    implements $TransactionLabelCopyWith<$Res> {
  _$TransactionLabelCopyWithImpl(this._self, this._then);

  final TransactionLabel _self;
  final $Res Function(TransactionLabel) _then;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? txId = null,Object? label = freezed,Object? origin = freezed,Object? blockHeight = freezed,Object? blockTime = freezed,Object? valueSat = freezed,Object? minerFeeSat = freezed,Object? exchangeRates = freezed,}) {
  return _then(TransactionLabel(
txId: null == txId ? _self.txId : txId // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as OriginatingWallet?,blockHeight: freezed == blockHeight ? _self.blockHeight : blockHeight // ignore: cast_nullable_to_non_nullable
as int?,blockTime: freezed == blockTime ? _self.blockTime : blockTime // ignore: cast_nullable_to_non_nullable
as DateTime?,valueSat: freezed == valueSat ? _self.valueSat : valueSat // ignore: cast_nullable_to_non_nullable
as int?,minerFeeSat: freezed == minerFeeSat ? _self.minerFeeSat : minerFeeSat // ignore: cast_nullable_to_non_nullable
as int?,exchangeRates: freezed == exchangeRates ? _self._exchangeRates : exchangeRates // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,
  ));
}

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OriginatingWalletCopyWith<$Res>? get origin {
    if (_self.origin == null) {
    return null;
  }

  return $OriginatingWalletCopyWith<$Res>(_self.origin!, (value) {
    return _then(_self.copyWith(origin: value));
  });
}
}

/// @nodoc


class AddressLabel extends Label {
  const AddressLabel({required this.address, this.label, this.origin, this.keyPath, final  List<int> heights = const []}): _heights = heights,super._();
  

 final  String address;
@override final  String? label;
@override final  OriginatingWallet? origin;
 final  String? keyPath;
 final  List<int> _heights;
@JsonKey() List<int> get heights {
  if (_heights is EqualUnmodifiableListView) return _heights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_heights);
}


/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressLabelCopyWith<AddressLabel> get copyWith => _$AddressLabelCopyWithImpl<AddressLabel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressLabel&&(identical(other.address, address) || other.address == address)&&(identical(other.label, label) || other.label == label)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.keyPath, keyPath) || other.keyPath == keyPath)&&const DeepCollectionEquality().equals(other._heights, _heights));
}


@override
int get hashCode => Object.hash(runtimeType,address,label,origin,keyPath,const DeepCollectionEquality().hash(_heights));

@override
String toString() {
  return 'Label.address(address: $address, label: $label, origin: $origin, keyPath: $keyPath, heights: $heights)';
}


}

/// @nodoc
abstract mixin class $AddressLabelCopyWith<$Res> implements $LabelCopyWith<$Res> {
  factory $AddressLabelCopyWith(AddressLabel value, $Res Function(AddressLabel) _then) = _$AddressLabelCopyWithImpl;
@override @useResult
$Res call({
 String address, String? label, OriginatingWallet? origin, String? keyPath, List<int> heights
});


@override $OriginatingWalletCopyWith<$Res>? get origin;

}
/// @nodoc
class _$AddressLabelCopyWithImpl<$Res>
    implements $AddressLabelCopyWith<$Res> {
  _$AddressLabelCopyWithImpl(this._self, this._then);

  final AddressLabel _self;
  final $Res Function(AddressLabel) _then;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? label = freezed,Object? origin = freezed,Object? keyPath = freezed,Object? heights = null,}) {
  return _then(AddressLabel(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as OriginatingWallet?,keyPath: freezed == keyPath ? _self.keyPath : keyPath // ignore: cast_nullable_to_non_nullable
as String?,heights: null == heights ? _self._heights : heights // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OriginatingWalletCopyWith<$Res>? get origin {
    if (_self.origin == null) {
    return null;
  }

  return $OriginatingWalletCopyWith<$Res>(_self.origin!, (value) {
    return _then(_self.copyWith(origin: value));
  });
}
}

/// @nodoc


class PubkeyLabel extends Label {
  const PubkeyLabel({required this.publicKey, this.label, this.origin}): super._();
  

 final  String publicKey;
@override final  String? label;
@override final  OriginatingWallet? origin;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PubkeyLabelCopyWith<PubkeyLabel> get copyWith => _$PubkeyLabelCopyWithImpl<PubkeyLabel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PubkeyLabel&&(identical(other.publicKey, publicKey) || other.publicKey == publicKey)&&(identical(other.label, label) || other.label == label)&&(identical(other.origin, origin) || other.origin == origin));
}


@override
int get hashCode => Object.hash(runtimeType,publicKey,label,origin);

@override
String toString() {
  return 'Label.pubkey(publicKey: $publicKey, label: $label, origin: $origin)';
}


}

/// @nodoc
abstract mixin class $PubkeyLabelCopyWith<$Res> implements $LabelCopyWith<$Res> {
  factory $PubkeyLabelCopyWith(PubkeyLabel value, $Res Function(PubkeyLabel) _then) = _$PubkeyLabelCopyWithImpl;
@override @useResult
$Res call({
 String publicKey, String? label, OriginatingWallet? origin
});


@override $OriginatingWalletCopyWith<$Res>? get origin;

}
/// @nodoc
class _$PubkeyLabelCopyWithImpl<$Res>
    implements $PubkeyLabelCopyWith<$Res> {
  _$PubkeyLabelCopyWithImpl(this._self, this._then);

  final PubkeyLabel _self;
  final $Res Function(PubkeyLabel) _then;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? publicKey = null,Object? label = freezed,Object? origin = freezed,}) {
  return _then(PubkeyLabel(
publicKey: null == publicKey ? _self.publicKey : publicKey // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as OriginatingWallet?,
  ));
}

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OriginatingWalletCopyWith<$Res>? get origin {
    if (_self.origin == null) {
    return null;
  }

  return $OriginatingWalletCopyWith<$Res>(_self.origin!, (value) {
    return _then(_self.copyWith(origin: value));
  });
}
}

/// @nodoc


class InputLabel extends Label {
  const InputLabel({required this.txId, required this.index, this.label, this.origin, this.keyPath, this.valueSat, final  Map<String, double>? fairMarketValue, this.blockHeight, this.blockTime}): _fairMarketValue = fairMarketValue,super._();
  

 final  String txId;
 final  int index;
@override final  String? label;
@override final  OriginatingWallet? origin;
 final  String? keyPath;
 final  int? valueSat;
 final  Map<String, double>? _fairMarketValue;
 Map<String, double>? get fairMarketValue {
  final value = _fairMarketValue;
  if (value == null) return null;
  if (_fairMarketValue is EqualUnmodifiableMapView) return _fairMarketValue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  int? blockHeight;
 final  DateTime? blockTime;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InputLabelCopyWith<InputLabel> get copyWith => _$InputLabelCopyWithImpl<InputLabel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputLabel&&(identical(other.txId, txId) || other.txId == txId)&&(identical(other.index, index) || other.index == index)&&(identical(other.label, label) || other.label == label)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.keyPath, keyPath) || other.keyPath == keyPath)&&(identical(other.valueSat, valueSat) || other.valueSat == valueSat)&&const DeepCollectionEquality().equals(other._fairMarketValue, _fairMarketValue)&&(identical(other.blockHeight, blockHeight) || other.blockHeight == blockHeight)&&(identical(other.blockTime, blockTime) || other.blockTime == blockTime));
}


@override
int get hashCode => Object.hash(runtimeType,txId,index,label,origin,keyPath,valueSat,const DeepCollectionEquality().hash(_fairMarketValue),blockHeight,blockTime);

@override
String toString() {
  return 'Label.input(txId: $txId, index: $index, label: $label, origin: $origin, keyPath: $keyPath, valueSat: $valueSat, fairMarketValue: $fairMarketValue, blockHeight: $blockHeight, blockTime: $blockTime)';
}


}

/// @nodoc
abstract mixin class $InputLabelCopyWith<$Res> implements $LabelCopyWith<$Res> {
  factory $InputLabelCopyWith(InputLabel value, $Res Function(InputLabel) _then) = _$InputLabelCopyWithImpl;
@override @useResult
$Res call({
 String txId, int index, String? label, OriginatingWallet? origin, String? keyPath, int? valueSat, Map<String, double>? fairMarketValue, int? blockHeight, DateTime? blockTime
});


@override $OriginatingWalletCopyWith<$Res>? get origin;

}
/// @nodoc
class _$InputLabelCopyWithImpl<$Res>
    implements $InputLabelCopyWith<$Res> {
  _$InputLabelCopyWithImpl(this._self, this._then);

  final InputLabel _self;
  final $Res Function(InputLabel) _then;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? txId = null,Object? index = null,Object? label = freezed,Object? origin = freezed,Object? keyPath = freezed,Object? valueSat = freezed,Object? fairMarketValue = freezed,Object? blockHeight = freezed,Object? blockTime = freezed,}) {
  return _then(InputLabel(
txId: null == txId ? _self.txId : txId // ignore: cast_nullable_to_non_nullable
as String,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as OriginatingWallet?,keyPath: freezed == keyPath ? _self.keyPath : keyPath // ignore: cast_nullable_to_non_nullable
as String?,valueSat: freezed == valueSat ? _self.valueSat : valueSat // ignore: cast_nullable_to_non_nullable
as int?,fairMarketValue: freezed == fairMarketValue ? _self._fairMarketValue : fairMarketValue // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,blockHeight: freezed == blockHeight ? _self.blockHeight : blockHeight // ignore: cast_nullable_to_non_nullable
as int?,blockTime: freezed == blockTime ? _self.blockTime : blockTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OriginatingWalletCopyWith<$Res>? get origin {
    if (_self.origin == null) {
    return null;
  }

  return $OriginatingWalletCopyWith<$Res>(_self.origin!, (value) {
    return _then(_self.copyWith(origin: value));
  });
}
}

/// @nodoc


class OutputLabel extends Label {
  const OutputLabel({required this.txId, required this.index, this.label, this.origin, this.keyPath, this.spendable, this.valueSat, final  Map<String, double>? fairMarketValue, this.blockHeight, this.blockTime}): _fairMarketValue = fairMarketValue,super._();
  

 final  String txId;
 final  int index;
@override final  String? label;
@override final  OriginatingWallet? origin;
 final  String? keyPath;
 final  bool? spendable;
 final  int? valueSat;
 final  Map<String, double>? _fairMarketValue;
 Map<String, double>? get fairMarketValue {
  final value = _fairMarketValue;
  if (value == null) return null;
  if (_fairMarketValue is EqualUnmodifiableMapView) return _fairMarketValue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  int? blockHeight;
 final  DateTime? blockTime;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutputLabelCopyWith<OutputLabel> get copyWith => _$OutputLabelCopyWithImpl<OutputLabel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OutputLabel&&(identical(other.txId, txId) || other.txId == txId)&&(identical(other.index, index) || other.index == index)&&(identical(other.label, label) || other.label == label)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.keyPath, keyPath) || other.keyPath == keyPath)&&(identical(other.spendable, spendable) || other.spendable == spendable)&&(identical(other.valueSat, valueSat) || other.valueSat == valueSat)&&const DeepCollectionEquality().equals(other._fairMarketValue, _fairMarketValue)&&(identical(other.blockHeight, blockHeight) || other.blockHeight == blockHeight)&&(identical(other.blockTime, blockTime) || other.blockTime == blockTime));
}


@override
int get hashCode => Object.hash(runtimeType,txId,index,label,origin,keyPath,spendable,valueSat,const DeepCollectionEquality().hash(_fairMarketValue),blockHeight,blockTime);

@override
String toString() {
  return 'Label.output(txId: $txId, index: $index, label: $label, origin: $origin, keyPath: $keyPath, spendable: $spendable, valueSat: $valueSat, fairMarketValue: $fairMarketValue, blockHeight: $blockHeight, blockTime: $blockTime)';
}


}

/// @nodoc
abstract mixin class $OutputLabelCopyWith<$Res> implements $LabelCopyWith<$Res> {
  factory $OutputLabelCopyWith(OutputLabel value, $Res Function(OutputLabel) _then) = _$OutputLabelCopyWithImpl;
@override @useResult
$Res call({
 String txId, int index, String? label, OriginatingWallet? origin, String? keyPath, bool? spendable, int? valueSat, Map<String, double>? fairMarketValue, int? blockHeight, DateTime? blockTime
});


@override $OriginatingWalletCopyWith<$Res>? get origin;

}
/// @nodoc
class _$OutputLabelCopyWithImpl<$Res>
    implements $OutputLabelCopyWith<$Res> {
  _$OutputLabelCopyWithImpl(this._self, this._then);

  final OutputLabel _self;
  final $Res Function(OutputLabel) _then;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? txId = null,Object? index = null,Object? label = freezed,Object? origin = freezed,Object? keyPath = freezed,Object? spendable = freezed,Object? valueSat = freezed,Object? fairMarketValue = freezed,Object? blockHeight = freezed,Object? blockTime = freezed,}) {
  return _then(OutputLabel(
txId: null == txId ? _self.txId : txId // ignore: cast_nullable_to_non_nullable
as String,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as OriginatingWallet?,keyPath: freezed == keyPath ? _self.keyPath : keyPath // ignore: cast_nullable_to_non_nullable
as String?,spendable: freezed == spendable ? _self.spendable : spendable // ignore: cast_nullable_to_non_nullable
as bool?,valueSat: freezed == valueSat ? _self.valueSat : valueSat // ignore: cast_nullable_to_non_nullable
as int?,fairMarketValue: freezed == fairMarketValue ? _self._fairMarketValue : fairMarketValue // ignore: cast_nullable_to_non_nullable
as Map<String, double>?,blockHeight: freezed == blockHeight ? _self.blockHeight : blockHeight // ignore: cast_nullable_to_non_nullable
as int?,blockTime: freezed == blockTime ? _self.blockTime : blockTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OriginatingWalletCopyWith<$Res>? get origin {
    if (_self.origin == null) {
    return null;
  }

  return $OriginatingWalletCopyWith<$Res>(_self.origin!, (value) {
    return _then(_self.copyWith(origin: value));
  });
}
}

/// @nodoc


class XpubLabel extends Label {
  const XpubLabel({required this.xpub, this.label, this.origin, this.keyPath}): super._();
  

 final  String xpub;
@override final  String? label;
@override final  OriginatingWallet? origin;
 final  String? keyPath;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$XpubLabelCopyWith<XpubLabel> get copyWith => _$XpubLabelCopyWithImpl<XpubLabel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is XpubLabel&&(identical(other.xpub, xpub) || other.xpub == xpub)&&(identical(other.label, label) || other.label == label)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.keyPath, keyPath) || other.keyPath == keyPath));
}


@override
int get hashCode => Object.hash(runtimeType,xpub,label,origin,keyPath);

@override
String toString() {
  return 'Label.xpub(xpub: $xpub, label: $label, origin: $origin, keyPath: $keyPath)';
}


}

/// @nodoc
abstract mixin class $XpubLabelCopyWith<$Res> implements $LabelCopyWith<$Res> {
  factory $XpubLabelCopyWith(XpubLabel value, $Res Function(XpubLabel) _then) = _$XpubLabelCopyWithImpl;
@override @useResult
$Res call({
 String xpub, String? label, OriginatingWallet? origin, String? keyPath
});


@override $OriginatingWalletCopyWith<$Res>? get origin;

}
/// @nodoc
class _$XpubLabelCopyWithImpl<$Res>
    implements $XpubLabelCopyWith<$Res> {
  _$XpubLabelCopyWithImpl(this._self, this._then);

  final XpubLabel _self;
  final $Res Function(XpubLabel) _then;

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? xpub = null,Object? label = freezed,Object? origin = freezed,Object? keyPath = freezed,}) {
  return _then(XpubLabel(
xpub: null == xpub ? _self.xpub : xpub // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,origin: freezed == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as OriginatingWallet?,keyPath: freezed == keyPath ? _self.keyPath : keyPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Label
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OriginatingWalletCopyWith<$Res>? get origin {
    if (_self.origin == null) {
    return null;
  }

  return $OriginatingWalletCopyWith<$Res>(_self.origin!, (value) {
    return _then(_self.copyWith(origin: value));
  });
}
}

// dart format on
