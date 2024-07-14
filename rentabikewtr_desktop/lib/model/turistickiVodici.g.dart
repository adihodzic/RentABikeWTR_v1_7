// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turistickiVodici.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TuristickiVodici _$TuristickiVodiciFromJson(Map<String, dynamic> json) =>
    TuristickiVodici()
      ..turistickiVodicId = (json['turistickiVodicId'] as num?)?.toInt()
      ..naziv = json['naziv'] as String?
      ..jezik = json['jezik'] as String?
      ..cijenaVodica = json['cijenaVodica'] as num?;

Map<String, dynamic> _$TuristickiVodiciToJson(TuristickiVodici instance) =>
    <String, dynamic>{
      'turistickiVodicId': instance.turistickiVodicId,
      'naziv': instance.naziv,
      'jezik': instance.jezik,
      'cijenaVodica': instance.cijenaVodica,
    };
