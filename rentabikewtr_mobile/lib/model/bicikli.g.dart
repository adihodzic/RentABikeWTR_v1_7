// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bicikli.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bicikli _$BicikliFromJson(Map<String, dynamic> json) => Bicikli()
  ..biciklId = json['biciklId'] as int?
  ..nazivBicikla = json['nazivBicikla'] as String?
  ..model = json['model'] as String?
  ..tipBicikla = json['tipBicikla'] as String?
  ..slika = json['slika'] as String?;

Map<String, dynamic> _$BicikliToJson(Bicikli instance) => <String, dynamic>{
      'biciklId': instance.biciklId,
      'nazivBicikla': instance.nazivBicikla,
      'model': instance.model,
      'tipBicikla': instance.tipBicikla,
      'slika': instance.slika,
    };
