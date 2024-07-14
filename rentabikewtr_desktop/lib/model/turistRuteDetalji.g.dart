// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turistRuteDetalji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TuristRuteDetalji _$TuristRuteDetaljiFromJson(Map<String, dynamic> json) =>
    TuristRuteDetalji(
      turistRutaId: (json['turistRutaId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
      opisRute: json['opisRute'] as String?,
      cijenaRute: json['cijenaRute'] as num?,
      slikaRute: json['slikaRute'] as String?,
    );

Map<String, dynamic> _$TuristRuteDetaljiToJson(TuristRuteDetalji instance) =>
    <String, dynamic>{
      'turistRutaId': instance.turistRutaId,
      'naziv': instance.naziv,
      'opisRute': instance.opisRute,
      'cijenaRute': instance.cijenaRute,
      'slikaRute': instance.slikaRute,
    };
