// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisniciPregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisniciPregled _$KorisniciPregledFromJson(Map<String, dynamic> json) =>
    KorisniciPregled()
      ..korisnickoIme = json['korisnickoIme'] as String?
      ..email = json['email'] as String?
      ..ime = json['ime'] as String?
      ..prezime = json['prezime'] as String?;

Map<String, dynamic> _$KorisniciPregledToJson(KorisniciPregled instance) =>
    <String, dynamic>{
      'korisnickoIme': instance.korisnickoIme,
      'email': instance.email,
      'ime': instance.ime,
      'prezime': instance.prezime,
    };
