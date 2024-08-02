// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poslovnice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Poslovnice _$PoslovniceFromJson(Map<String, dynamic> json) => Poslovnice(
      nazivPoslovnice: json['nazivPoslovnice'] as String?,
      emailKontakt: json['emailKontakt'] as String?,
      adresa: json['adresa'] as String?,
      brojTelefona: json['brojTelefona'] as String?,
    );

Map<String, dynamic> _$PoslovniceToJson(Poslovnice instance) =>
    <String, dynamic>{
      'nazivPoslovnice': instance.nazivPoslovnice,
      'emailKontakt': instance.emailKontakt,
      'adresa': instance.adresa,
      'brojTelefona': instance.brojTelefona,
    };
