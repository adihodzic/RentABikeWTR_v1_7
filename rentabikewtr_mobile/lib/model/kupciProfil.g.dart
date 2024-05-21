// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kupciProfil.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KupciProfil _$KupciProfilFromJson(Map<String, dynamic> json) => KupciProfil(
      kupacId: json['kupacId'] as int,
      adresa: json['adresa'] as String?,
      grad: json['grad'] as String?,
      brojLKPasosa: json['brojLKPasosa'] as String?,
    );

Map<String, dynamic> _$KupciProfilToJson(KupciProfil instance) =>
    <String, dynamic>{
      'kupacId': instance.kupacId,
      'adresa': instance.adresa,
      'grad': instance.grad,
      'brojLKPasosa': instance.brojLKPasosa,
    };
