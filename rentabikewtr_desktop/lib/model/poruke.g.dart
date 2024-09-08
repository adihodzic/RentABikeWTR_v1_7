// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poruke.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Poruke _$PorukeFromJson(Map<String, dynamic> json) => Poruke(
      tekst: json['tekst'] as String?,
      datumPoruke: json['datumPoruke'] == null
          ? null
          : DateTime.parse(json['datumPoruke'] as String),
      korisnikID: (json['korisnikID'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PorukeToJson(Poruke instance) => <String, dynamic>{
      'tekst': instance.tekst,
      'datumPoruke': instance.datumPoruke?.toIso8601String(),
      'korisnikID': instance.korisnikID,
    };
