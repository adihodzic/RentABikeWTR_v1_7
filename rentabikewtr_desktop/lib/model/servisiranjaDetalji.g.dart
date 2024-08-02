// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'servisiranjaDetalji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServisiranjaDetalji _$ServisiranjaDetaljiFromJson(Map<String, dynamic> json) =>
    ServisiranjaDetalji(
      servisiranjeId: (json['servisiranjeId'] as num?)?.toInt(),
      opisKvara: json['opisKvara'] as String?,
      preduzetaAkcija: json['preduzetaAkcija'] as String?,
      komentarServisera: json['komentarServisera'] as String?,
      biciklID: (json['biciklID'] as num?)?.toInt(),
      rezervniDijelovi: (json['rezervniDijelovi'] as List<dynamic>?)
          ?.map((e) =>
              RezervniDijeloviPregled.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServisiranjaDetaljiToJson(
        ServisiranjaDetalji instance) =>
    <String, dynamic>{
      'servisiranjeId': instance.servisiranjeId,
      'opisKvara': instance.opisKvara,
      'preduzetaAkcija': instance.preduzetaAkcija,
      'komentarServisera': instance.komentarServisera,
      'biciklID': instance.biciklID,
      'rezervniDijelovi': instance.rezervniDijelovi,
    };
