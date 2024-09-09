// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bicikliDesktopPregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BicikliDesktopPregled _$BicikliDesktopPregledFromJson(
        Map<String, dynamic> json) =>
    BicikliDesktopPregled()
      ..biciklID = (json['biciklID'] as num?)?.toInt()
      ..nazivBicikla = json['nazivBicikla'] as String?
      ..nazivModela = json['nazivModela'] as String?
      ..nazivTipa = json['nazivTipa'] as String?
      ..slika = json['slika'] as String?;

Map<String, dynamic> _$BicikliDesktopPregledToJson(
        BicikliDesktopPregled instance) =>
    <String, dynamic>{
      'biciklID': instance.biciklID,
      'nazivBicikla': instance.nazivBicikla,
      'nazivModela': instance.nazivModela,
      'nazivTipa': instance.nazivTipa,
      'slika': instance.slika,
    };
