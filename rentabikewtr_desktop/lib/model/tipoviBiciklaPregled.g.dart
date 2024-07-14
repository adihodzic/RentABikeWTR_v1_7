// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tipoviBiciklaPregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipoviBiciklaPregled _$TipoviBiciklaPregledFromJson(
        Map<String, dynamic> json) =>
    TipoviBiciklaPregled()
      ..tipBiciklaId = (json['tipBiciklaId'] as num?)?.toInt()
      ..nazivTipa = json['nazivTipa'] as String?;

Map<String, dynamic> _$TipoviBiciklaPregledToJson(
        TipoviBiciklaPregled instance) =>
    <String, dynamic>{
      'tipBiciklaId': instance.tipBiciklaId,
      'nazivTipa': instance.nazivTipa,
    };
