// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacijePregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijePregled _$RezervacijePregledFromJson(Map<String, dynamic> json) =>
    RezervacijePregled()
      ..rezervacijaId = (json['rezervacijaId'] as num?)?.toInt()
      ..biciklID = (json['biciklID'] as num?)?.toInt()
      ..kupacID = (json['kupacID'] as num?)?.toInt()
      ..datumIzdavanja = json['datumIzdavanja'] == null
          ? null
          : DateTime.parse(json['datumIzdavanja'] as String)
      ..nazivBicikla = json['nazivBicikla'] as String?
      ..korisnickoIme = json['korisnickoIme'] as String?
      ..ime = json['ime'] as String?
      ..prezime = json['prezime'] as String?;

Map<String, dynamic> _$RezervacijePregledToJson(RezervacijePregled instance) =>
    <String, dynamic>{
      'rezervacijaId': instance.rezervacijaId,
      'biciklID': instance.biciklID,
      'kupacID': instance.kupacID,
      'datumIzdavanja': instance.datumIzdavanja?.toIso8601String(),
      'nazivBicikla': instance.nazivBicikla,
      'korisnickoIme': instance.korisnickoIme,
      'ime': instance.ime,
      'prezime': instance.prezime,
    };
