// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poslovnicePregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoslovnicePregled _$PoslovnicePregledFromJson(Map<String, dynamic> json) =>
    PoslovnicePregled()
      ..poslovnicaId = (json['poslovnicaId'] as num?)?.toInt()
      ..nazivPoslovnice = json['nazivPoslovnice'] as String?
      ..emailKontakt = json['emailKontakt'] as String?
      ..adresa = json['adresa'] as String?
      ..brojTelefona = json['brojTelefona'] as String?;

Map<String, dynamic> _$PoslovnicePregledToJson(PoslovnicePregled instance) =>
    <String, dynamic>{
      'poslovnicaId': instance.poslovnicaId,
      'nazivPoslovnice': instance.nazivPoslovnice,
      'emailKontakt': instance.emailKontakt,
      'adresa': instance.adresa,
      'brojTelefona': instance.brojTelefona,
    };
