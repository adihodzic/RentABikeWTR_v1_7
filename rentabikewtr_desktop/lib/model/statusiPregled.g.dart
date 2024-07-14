// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statusiPregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusiPregled _$StatusiPregledFromJson(Map<String, dynamic> json) =>
    StatusiPregled()
      ..statusId = (json['statusId'] as num?)?.toInt()
      ..nazivStatusa = json['nazivStatusa'] as String?;

Map<String, dynamic> _$StatusiPregledToJson(StatusiPregled instance) =>
    <String, dynamic>{
      'statusId': instance.statusId,
      'nazivStatusa': instance.nazivStatusa,
    };
