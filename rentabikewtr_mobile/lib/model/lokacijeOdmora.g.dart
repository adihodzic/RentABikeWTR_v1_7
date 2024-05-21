// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lokacijeOdmora.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LokacijeOdmora _$LokacijeOdmoraFromJson(Map<String, dynamic> json) =>
    LokacijeOdmora()
      ..lokacijaOdmoraId = json['lokacijaOdmoraId'] as int?
      ..naziv = json['naziv'] as String?
      ..opis = json['opis'] as String?;

Map<String, dynamic> _$LokacijeOdmoraToJson(LokacijeOdmora instance) =>
    <String, dynamic>{
      'lokacijaOdmoraId': instance.lokacijaOdmoraId,
      'naziv': instance.naziv,
      'opis': instance.opis,
    };
