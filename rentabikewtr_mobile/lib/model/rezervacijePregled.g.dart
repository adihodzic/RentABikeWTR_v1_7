// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacijePregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijePregled _$RezervacijePregledFromJson(Map<String, dynamic> json) =>
    RezervacijePregled()
      ..rezervacijaId = json['rezervacijaId'] as int?
      ..datumIzdavanja = json['datumIzdavanja'] == null
          ? null
          : DateTime.parse(json['datumIzdavanja'] as String)
      ..biciklID = json['biciklID'] as int?
      ..kupacID = json['kupacID'] as int?
      ..turistickiVodicID = json['turistickiVodicID'] as int?
      ..turistRutaID = json['turistRutaID'] as int?
      ..cijenaUsluge = json['cijenaUsluge'] as num?;

Map<String, dynamic> _$RezervacijePregledToJson(RezervacijePregled instance) =>
    <String, dynamic>{
      'rezervacijaId': instance.rezervacijaId,
      'datumIzdavanja': instance.datumIzdavanja?.toIso8601String(),
      'biciklID': instance.biciklID,
      'kupacID': instance.kupacID,
      'turistickiVodicID': instance.turistickiVodicID,
      'turistRutaID': instance.turistRutaID,
      'cijenaUsluge': instance.cijenaUsluge,
    };
