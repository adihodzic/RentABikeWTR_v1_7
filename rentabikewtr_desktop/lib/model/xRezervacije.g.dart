// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xRezervacije.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XRezervacije _$XRezervacijeFromJson(Map<String, dynamic> json) => XRezervacije()
  ..rezervacijaId = (json['rezervacijaId'] as num?)?.toInt()
  ..datum =
      json['datum'] == null ? null : DateTime.parse(json['datum'] as String)
  ..cijenaUsluge = json['cijenaUsluge'] as num?
  ..kupacID = (json['kupacID'] as num?)?.toInt()
  ..korisnickoIme = json['korisnickoIme'] as String?
  ..biciklID = (json['biciklID'] as num?)?.toInt()
  ..nazivBicikla = json['nazivBicikla'] as String?
  ..turistRutaID = (json['turistRutaID'] as num?)?.toInt()
  ..naziv = json['naziv'] as String?;

Map<String, dynamic> _$XRezervacijeToJson(XRezervacije instance) =>
    <String, dynamic>{
      'rezervacijaId': instance.rezervacijaId,
      'datum': instance.datum?.toIso8601String(),
      'cijenaUsluge': instance.cijenaUsluge,
      'kupacID': instance.kupacID,
      'korisnickoIme': instance.korisnickoIme,
      'biciklID': instance.biciklID,
      'nazivBicikla': instance.nazivBicikla,
      'turistRutaID': instance.turistRutaID,
      'naziv': instance.naziv,
    };
