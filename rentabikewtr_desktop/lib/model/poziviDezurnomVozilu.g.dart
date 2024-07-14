// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poziviDezurnomVozilu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoziviDezurnomVozilu _$PoziviDezurnomVoziluFromJson(
        Map<String, dynamic> json) =>
    PoziviDezurnomVozilu(
      viseDetalja: json['viseDetalja'] as String?,
      nesreca: json['nesreca'] as bool?,
      zahtjevKlijenta: json['zahtjevKlijenta'] as bool?,
      kvar: json['kvar'] as bool?,
      losiVremenskiUslovi: json['losiVremenskiUslovi'] as bool?,
      datumPoziva: json['datumPoziva'] == null
          ? null
          : DateTime.parse(json['datumPoziva'] as String),
      vrijemePoziva: json['vrijemePoziva'] == null
          ? null
          : DateTime.parse(json['vrijemePoziva'] as String),
      dezurnoVoziloID: (json['dezurnoVoziloID'] as num?)?.toInt(),
      turistickiVodicID: (json['turistickiVodicID'] as num?)?.toInt(),
      poslovnicaID: (json['poslovnicaID'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PoziviDezurnomVoziluToJson(
        PoziviDezurnomVozilu instance) =>
    <String, dynamic>{
      'viseDetalja': instance.viseDetalja,
      'nesreca': instance.nesreca,
      'zahtjevKlijenta': instance.zahtjevKlijenta,
      'kvar': instance.kvar,
      'losiVremenskiUslovi': instance.losiVremenskiUslovi,
      'datumPoziva': instance.datumPoziva?.toIso8601String(),
      'vrijemePoziva': instance.vrijemePoziva?.toIso8601String(),
      'dezurnoVoziloID': instance.dezurnoVoziloID,
      'turistickiVodicID': instance.turistickiVodicID,
      'poslovnicaID': instance.poslovnicaID,
    };
