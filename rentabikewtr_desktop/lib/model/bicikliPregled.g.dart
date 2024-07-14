// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bicikliPregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BicikliPregled _$BicikliPregledFromJson(Map<String, dynamic> json) =>
    BicikliPregled()
      ..biciklId = (json['biciklId'] as num?)?.toInt()
      ..nazivBicikla = json['nazivBicikla'] as String?
      ..nazivModela = json['nazivModela'] as String?
      ..nazivTipa = json['nazivTipa'] as String?
      ..slika = json['slika'] as String?;

Map<String, dynamic> _$BicikliPregledToJson(BicikliPregled instance) =>
    <String, dynamic>{
      'biciklId': instance.biciklId,
      'nazivBicikla': instance.nazivBicikla,
      'nazivModela': instance.nazivModela,
      'nazivTipa': instance.nazivTipa,
      'slika': instance.slika,
    };
