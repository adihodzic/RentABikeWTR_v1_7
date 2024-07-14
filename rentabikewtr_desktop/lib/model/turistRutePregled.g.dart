// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turistRutePregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TuristRutePregled _$TuristRutePregledFromJson(Map<String, dynamic> json) =>
    TuristRutePregled()
      ..turistRutaId = (json['turistRutaId'] as num?)?.toInt()
      ..naziv = json['naziv'] as String?
      ..opisRute = json['opisRute'] as String?
      ..cijenaRute = json['cijenaRute'] as num?
      ..slikaRute = json['slikaRute'] as String?;

Map<String, dynamic> _$TuristRutePregledToJson(TuristRutePregled instance) =>
    <String, dynamic>{
      'turistRutaId': instance.turistRutaId,
      'naziv': instance.naziv,
      'opisRute': instance.opisRute,
      'cijenaRute': instance.cijenaRute,
      'slikaRute': instance.slikaRute,
    };
