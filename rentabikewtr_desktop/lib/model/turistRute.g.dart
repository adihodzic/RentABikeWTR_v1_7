// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turistRute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TuristRute _$TuristRuteFromJson(Map<String, dynamic> json) => TuristRute(
      naziv: json['naziv'] as String?,
      opisRute: json['opisRute'] as String?,
      cijenaRute: json['cijenaRute'] as num?,
      slikaRute: json['slikaRute'] as String?,
    );

Map<String, dynamic> _$TuristRuteToJson(TuristRute instance) =>
    <String, dynamic>{
      'naziv': instance.naziv,
      'opisRute': instance.opisRute,
      'cijenaRute': instance.cijenaRute,
      'slikaRute': instance.slikaRute,
    };
