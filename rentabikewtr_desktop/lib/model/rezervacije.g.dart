// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacije _$RezervacijeFromJson(Map<String, dynamic> json) => Rezervacije(
      datumIzdavanja: json['datumIzdavanja'],
      vrijemePreuzimanja: json['vrijemePreuzimanja'],
      vrijemeVracanja: json['vrijemeVracanja'],
      statusPlacanja: json['statusPlacanja'] as bool,
      cijenaUsluge: json['cijenaUsluge'] as num?,
      biciklID: (json['biciklID'] as num?)?.toInt(),
      turistickiVodicID: (json['turistickiVodicID'] as num?)?.toInt(),
      turistRutaID: (json['turistRutaID'] as num?)?.toInt(),
      kupacID: (json['kupacID'] as num?)?.toInt(),
      korisnikID: (json['korisnikID'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RezervacijeToJson(Rezervacije instance) =>
    <String, dynamic>{
      'datumIzdavanja': instance.datumIzdavanja?.toIso8601String(),
      'vrijemePreuzimanja': instance.vrijemePreuzimanja?.toIso8601String(),
      'vrijemeVracanja': instance.vrijemeVracanja?.toIso8601String(),
      'statusPlacanja': instance.statusPlacanja,
      'cijenaUsluge': instance.cijenaUsluge,
      'biciklID': instance.biciklID,
      'turistickiVodicID': instance.turistickiVodicID,
      'turistRutaID': instance.turistRutaID,
      'kupacID': instance.kupacID,
      'korisnikID': instance.korisnikID,
    };
