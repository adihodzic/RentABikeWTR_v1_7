// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proizvodjaciBiciklaPregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProizvodjaciBiciklaPregled _$ProizvodjaciBiciklaPregledFromJson(
        Map<String, dynamic> json) =>
    ProizvodjaciBiciklaPregled()
      ..proizvodjacBiciklaId = (json['proizvodjacBiciklaId'] as num?)?.toInt()
      ..nazivProizvodjaca = json['nazivProizvodjaca'] as String?;

Map<String, dynamic> _$ProizvodjaciBiciklaPregledToJson(
        ProizvodjaciBiciklaPregled instance) =>
    <String, dynamic>{
      'proizvodjacBiciklaId': instance.proizvodjacBiciklaId,
      'nazivProizvodjaca': instance.nazivProizvodjaca,
    };
