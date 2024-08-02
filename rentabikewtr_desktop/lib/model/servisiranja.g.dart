// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servisiranja.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Servisiranja _$ServisiranjaFromJson(Map<String, dynamic> json) => Servisiranja(
      opisKvara: json['opisKvara'] as String?,
      datumServisiranja: json['datumServisiranja'] == null
          ? null
          : DateTime.parse(json['datumServisiranja'] as String),
      preduzetaAkcija: json['preduzetaAkcija'] as String?,
      komentarServisera: json['komentarServisera'] as String?,
      biciklID: (json['biciklID'] as num?)?.toInt(),
      rezervniDijelovi: (json['rezervniDijelovi'] as List<dynamic>?)
          ?.map((e) =>
              RezervniDijeloviPregled.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServisiranjaToJson(Servisiranja instance) =>
    <String, dynamic>{
      'opisKvara': instance.opisKvara,
      'datumServisiranja': instance.datumServisiranja?.toIso8601String(),
      'preduzetaAkcija': instance.preduzetaAkcija,
      'komentarServisera': instance.komentarServisera,
      'biciklID': instance.biciklID,
      'rezervniDijelovi': instance.rezervniDijelovi,
    };
