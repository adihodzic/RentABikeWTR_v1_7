// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poslovniceDetalji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoslovniceDetalji _$PoslovniceDetaljiFromJson(Map<String, dynamic> json) =>
    PoslovniceDetalji(
      poslovnicaId: (json['poslovnicaId'] as num?)?.toInt(),
      nazivPoslovnice: json['nazivPoslovnice'] as String?,
      emailKontakt: json['emailKontakt'] as String?,
      adresa: json['adresa'] as String?,
      brojTelefona: json['brojTelefona'] as String?,
    );

Map<String, dynamic> _$PoslovniceDetaljiToJson(PoslovniceDetalji instance) =>
    <String, dynamic>{
      'poslovnicaId': instance.poslovnicaId,
      'nazivPoslovnice': instance.nazivPoslovnice,
      'emailKontakt': instance.emailKontakt,
      'adresa': instance.adresa,
      'brojTelefona': instance.brojTelefona,
    };
