// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../label_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LabelModel _$LabelModelFromJson(Map<String, dynamic> json) => _LabelModel(
  type: json['type'] as String,
  ref: json['ref'] as String,
  label: json['label'] as String?,
  origin: json['origin'] as String?,
  spendable: json['spendable'] as bool?,
  height: (json['height'] as num?)?.toInt(),
  time: json['time'] as String?,
  fee: (json['fee'] as num?)?.toInt(),
  value: (json['value'] as num?)?.toInt(),
  rate: (json['rate'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
  keypath: json['keypath'] as String?,
  fmv: (json['fmv'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
  heights:
      (json['heights'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$LabelModelToJson(_LabelModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'ref': instance.ref,
      if (instance.label case final value?) 'label': value,
      if (instance.origin case final value?) 'origin': value,
      if (instance.spendable case final value?) 'spendable': value,
      if (instance.height case final value?) 'height': value,
      if (instance.time case final value?) 'time': value,
      if (instance.fee case final value?) 'fee': value,
      if (instance.value case final value?) 'value': value,
      if (instance.rate case final value?) 'rate': value,
      if (instance.keypath case final value?) 'keypath': value,
      if (instance.fmv case final value?) 'fmv': value,
      'heights': instance.heights,
    };
