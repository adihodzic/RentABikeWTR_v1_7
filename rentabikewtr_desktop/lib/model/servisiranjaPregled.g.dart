// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servisiranjaPregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServisiranjaPregled _$ServisiranjaPregledFromJson(Map<String, dynamic> json) =>
    ServisiranjaPregled()
      ..servisiranjeId = (json['servisiranjeId'] as num?)?.toInt()
      ..opisKvara = json['opisKvara'] as String?
      ..datumServisiranja = json['datumServisiranja'] == null
          ? null
          : DateTime.parse(json['datumServisiranja'] as String)
      ..preduzetaAkcija = json['preduzetaAkcija'] as String?
      ..komentarServisera = json['komentarServisera'] as String?
      ..nazivBicikla = json['nazivBicikla'] as String?
      ..biciklID = (json['biciklID'] as num?)?.toInt()
      ..rezervniDijelovi = (json['rezervniDijelovi'] as List<dynamic>?)
          ?.map((e) =>
              RezervniDijeloviPregled.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ServisiranjaPregledToJson(
        ServisiranjaPregled instance) =>
    <String, dynamic>{
      'servisiranjeId': instance.servisiranjeId,
      'opisKvara': instance.opisKvara,
      'datumServisiranja': instance.datumServisiranja?.toIso8601String(),
      'preduzetaAkcija': instance.preduzetaAkcija,
      'komentarServisera': instance.komentarServisera,
      'nazivBicikla': instance.nazivBicikla,
      'biciklID': instance.biciklID,
      'rezervniDijelovi': instance.rezervniDijelovi,
    };
