// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poziviDezurnomVoziluPregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoziviDezurnomVoziluPregled _$PoziviDezurnomVoziluPregledFromJson(
        Map<String, dynamic> json) =>
    PoziviDezurnomVoziluPregled()
      ..pozivDezurnomVoziluId = (json['pozivDezurnomVoziluId'] as num?)?.toInt()
      ..viseDetalja = json['viseDetalja'] as String?
      ..nesreca = json['nesreca'] as bool?
      ..zahtjevKlijenta = json['zahtjevKlijenta'] as bool?
      ..kvar = json['kvar'] as bool?
      ..losiVremenskiUslovi = json['losiVremenskiUslovi'] as bool?
      ..datumPoziva = json['datumPoziva'] == null
          ? null
          : DateTime.parse(json['datumPoziva'] as String)
      ..vrijemePoziva = json['vrijemePoziva'] == null
          ? null
          : DateTime.parse(json['vrijemePoziva'] as String)
      ..nazivDezurnogVozila = json['nazivDezurnogVozila'] as String?
      ..naziv = json['naziv'] as String?
      ..nazivPoslovnice = json['nazivPoslovnice'] as String?;

Map<String, dynamic> _$PoziviDezurnomVoziluPregledToJson(
        PoziviDezurnomVoziluPregled instance) =>
    <String, dynamic>{
      'pozivDezurnomVoziluId': instance.pozivDezurnomVoziluId,
      'viseDetalja': instance.viseDetalja,
      'nesreca': instance.nesreca,
      'zahtjevKlijenta': instance.zahtjevKlijenta,
      'kvar': instance.kvar,
      'losiVremenskiUslovi': instance.losiVremenskiUslovi,
      'datumPoziva': instance.datumPoziva?.toIso8601String(),
      'vrijemePoziva': instance.vrijemePoziva?.toIso8601String(),
      'nazivDezurnogVozila': instance.nazivDezurnogVozila,
      'naziv': instance.naziv,
      'nazivPoslovnice': instance.nazivPoslovnice,
    };
