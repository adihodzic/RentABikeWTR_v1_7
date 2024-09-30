// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kupci.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kupci _$KupciFromJson(Map<String, dynamic> json) => Kupci(
      kupacId: json['kupacId'] as int?,
      adresa: json['adresa'] as String?,
      grad: json['grad'] as String?,
      brojLKPasosa: json['brojLKPasosa'] as String?,
      spol: json['spol'] as String?,
      godineKupacID: json['godineKupacID'] as int?,
    );

Map<String, dynamic> _$KupciToJson(Kupci instance) => <String, dynamic>{
      'kupacId': instance.kupacId,
      'adresa': instance.adresa,
      'grad': instance.grad,
      'brojLKPasosa': instance.brojLKPasosa,
      'spol': instance.spol,
      'godineKupacID': instance.godineKupacID,
    };
