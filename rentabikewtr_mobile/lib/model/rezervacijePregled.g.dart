// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacijePregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijePregled _$RezervacijePregledFromJson(Map<String, dynamic> json) =>
    RezervacijePregled()
      ..rezervacijaId = json['rezervacijaId'] as int?
      ..biciklID = json['biciklID'] as int?
      ..kupacID = json['kupacID'] as int?;

Map<String, dynamic> _$RezervacijePregledToJson(RezervacijePregled instance) =>
    <String, dynamic>{
      'rezervacijaId': instance.rezervacijaId,
      'biciklID': instance.biciklID,
      'kupacID': instance.kupacID,
    };
