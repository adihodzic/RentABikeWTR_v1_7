// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'velicineBiciklaPregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VelicineBiciklaPregled _$VelicineBiciklaPregledFromJson(
        Map<String, dynamic> json) =>
    VelicineBiciklaPregled()
      ..velicinaBiciklaId = (json['velicinaBiciklaId'] as num?)?.toInt()
      ..nazivVelicine = json['nazivVelicine'] as String?;

Map<String, dynamic> _$VelicineBiciklaPregledToJson(
        VelicineBiciklaPregled instance) =>
    <String, dynamic>{
      'velicinaBiciklaId': instance.velicinaBiciklaId,
      'nazivVelicine': instance.nazivVelicine,
    };
