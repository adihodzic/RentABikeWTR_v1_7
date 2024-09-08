// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'najaveOdmora.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NajaveOdmora _$NajaveOdmoraFromJson(Map<String, dynamic> json) => NajaveOdmora(
      datumOdmora: json['datumOdmora'] == null
          ? null
          : DateTime.parse(json['datumOdmora'] as String),
      pocetakOdmora: json['pocetakOdmora'] == null
          ? null
          : DateTime.parse(json['pocetakOdmora'] as String),
      zavrsetakOdmora: json['zavrsetakOdmora'] == null
          ? null
          : DateTime.parse(json['zavrsetakOdmora'] as String),
      napitakKolicina: json['napitakKolicina'] as int?,
      launchPaketKolicina: json['launchPaketKolicina'] as int?,
      lokacijaOdmoraID: json['lokacijaOdmoraID'] as int?,
      turistickiVodicID: json['turistickiVodicID'] as int?,
    );

Map<String, dynamic> _$NajaveOdmoraToJson(NajaveOdmora instance) =>
    <String, dynamic>{
      'datumOdmora': instance.datumOdmora?.toIso8601String(),
      'pocetakOdmora': instance.pocetakOdmora?.toIso8601String(),
      'zavrsetakOdmora': instance.zavrsetakOdmora?.toIso8601String(),
      'napitakKolicina': instance.napitakKolicina,
      'launchPaketKolicina': instance.launchPaketKolicina,
      'lokacijaOdmoraID': instance.lokacijaOdmoraID,
      'turistickiVodicID': instance.turistickiVodicID,
    };
