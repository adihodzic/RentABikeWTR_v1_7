// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervacije _$RezervacijeFromJson(Map<String, dynamic> json) => Rezervacije(
      rezervacijaId: json['rezervacijaId'] as int?,
      datumIzdavanja: json['datumIzdavanja'],
      vrijemePreuzimanja: json['vrijemePreuzimanja'],
      vrijemeVracanja: json['vrijemeVracanja'],
      statusPlacanja: json['statusPlacanja'] as bool,
      cijenaUsluge: json['cijenaUsluge'] as num?,
      biciklId: json['biciklId'] as int?,
      turistickiVodicID: json['turistickiVodicID'] as int?,
      turistRutaID: json['turistRutaID'] as int?,
      kupacID: json['kupacID'] as int?,
      korisnikID: json['korisnikID'] as int?,
    );

Map<String, dynamic> _$RezervacijeToJson(Rezervacije instance) =>
    <String, dynamic>{
      'rezervacijaId': instance.rezervacijaId,
      'datumIzdavanja': instance.datumIzdavanja?.toIso8601String(),
      'vrijemePreuzimanja': instance.vrijemePreuzimanja?.toIso8601String(),
      'vrijemeVracanja': instance.vrijemeVracanja?.toIso8601String(),
      'statusPlacanja': instance.statusPlacanja,
      'cijenaUsluge': instance.cijenaUsluge,
      'biciklId': instance.biciklId,
      'turistickiVodicID': instance.turistickiVodicID,
      'turistRutaID': instance.turistRutaID,
      'kupacID': instance.kupacID,
      'korisnikID': instance.korisnikID,
    };
