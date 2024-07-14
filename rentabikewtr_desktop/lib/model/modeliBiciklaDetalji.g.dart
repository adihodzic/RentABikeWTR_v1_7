// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modeliBiciklaDetalji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModeliBiciklaDetalji _$ModeliBiciklaDetaljiFromJson(
        Map<String, dynamic> json) =>
    ModeliBiciklaDetalji(
      modelBiciklaId: (json['modelBiciklaId'] as num?)?.toInt(),
      nazivModela: json['nazivModela'] as String?,
    );

Map<String, dynamic> _$ModeliBiciklaDetaljiToJson(
        ModeliBiciklaDetalji instance) =>
    <String, dynamic>{
      'modelBiciklaId': instance.modelBiciklaId,
      'nazivModela': instance.nazivModela,
    };
