// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocjene.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ocjene _$OcjeneFromJson(Map<String, dynamic> json) => Ocjene(
      ocjena: json['ocjena'] as int?,
      datumOcjene: json['datumOcjene'] == null
          ? null
          : DateTime.parse(json['datumOcjene'] as String),
      biciklID: json['biciklID'] as int?,
      kupacID: json['kupacID'] as int?,
    );

Map<String, dynamic> _$OcjeneToJson(Ocjene instance) => <String, dynamic>{
      'ocjena': instance.ocjena,
      'datumOcjene': instance.datumOcjene?.toIso8601String(),
      'biciklID': instance.biciklID,
      'kupacID': instance.kupacID,
    };
