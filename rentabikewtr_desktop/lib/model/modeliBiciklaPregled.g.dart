// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modeliBiciklaPregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModeliBiciklaPregled _$ModeliBiciklaPregledFromJson(
        Map<String, dynamic> json) =>
    ModeliBiciklaPregled()
      ..modelBiciklaId = (json['modelBiciklaId'] as num?)?.toInt()
      ..nazivModela = json['nazivModela'] as String?;

Map<String, dynamic> _$ModeliBiciklaPregledToJson(
        ModeliBiciklaPregled instance) =>
    <String, dynamic>{
      'modelBiciklaId': instance.modelBiciklaId,
      'nazivModela': instance.nazivModela,
    };
