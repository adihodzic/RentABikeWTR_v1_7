// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tipoviBiciklaDetalji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipoviBiciklaDetalji _$TipoviBiciklaDetaljiFromJson(
        Map<String, dynamic> json) =>
    TipoviBiciklaDetalji(
      tipBiciklaId: (json['tipBiciklaId'] as num?)?.toInt(),
      nazivTipa: json['nazivTipa'] as String?,
    );

Map<String, dynamic> _$TipoviBiciklaDetaljiToJson(
        TipoviBiciklaDetalji instance) =>
    <String, dynamic>{
      'tipBiciklaId': instance.tipBiciklaId,
      'nazivTipa': instance.nazivTipa,
    };
