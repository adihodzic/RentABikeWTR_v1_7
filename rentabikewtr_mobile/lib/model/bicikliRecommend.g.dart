// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bicikliRecommend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BicikliRecommend _$BicikliRecommendFromJson(Map<String, dynamic> json) =>
    BicikliRecommend()
      ..biciklId = json['biciklId'] as int?
      ..nazivBicikla = json['nazivBicikla'] as String?
      ..cijenaBicikla = json['cijenaBicikla'] as num?
      ..nazivProizvodjaca = json['nazivProizvodjaca'] as String?
      ..nazivModela = json['nazivModela'] as String?
      ..nazivTipa = json['nazivTipa'] as String?
      ..boja = json['boja'] as String?
      ..nazivPoslovnice = json['nazivPoslovnice'] as String?
      ..slika = json['slika'] as String?;

Map<String, dynamic> _$BicikliRecommendToJson(BicikliRecommend instance) =>
    <String, dynamic>{
      'biciklId': instance.biciklId,
      'nazivBicikla': instance.nazivBicikla,
      'cijenaBicikla': instance.cijenaBicikla,
      'nazivProizvodjaca': instance.nazivProizvodjaca,
      'nazivModela': instance.nazivModela,
      'nazivTipa': instance.nazivTipa,
      'boja': instance.boja,
      'nazivPoslovnice': instance.nazivPoslovnice,
      'slika': instance.slika,
    };
