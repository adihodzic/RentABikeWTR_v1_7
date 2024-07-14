// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turistickiVodiciUpsert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TuristickiVodiciUpsert _$TuristickiVodiciUpsertFromJson(
        Map<String, dynamic> json) =>
    TuristickiVodiciUpsert(
      turistickiVodicId: (json['turistickiVodicId'] as num?)?.toInt(),
      naziv: json['naziv'] as String?,
      jezik: json['jezik'] as String?,
      cijenaVodica: json['cijenaVodica'] as num?,
    );

Map<String, dynamic> _$TuristickiVodiciUpsertToJson(
        TuristickiVodiciUpsert instance) =>
    <String, dynamic>{
      'turistickiVodicId': instance.turistickiVodicId,
      'naziv': instance.naziv,
      'jezik': instance.jezik,
      'cijenaVodica': instance.cijenaVodica,
    };
