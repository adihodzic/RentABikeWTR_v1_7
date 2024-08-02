// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategorijeDijelovaPregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KategorijeDijelovaPregled _$KategorijeDijelovaPregledFromJson(
        Map<String, dynamic> json) =>
    KategorijeDijelovaPregled()
      ..kategorijaDijelovaId = (json['kategorijaDijelovaId'] as num?)?.toInt()
      ..nazivKategorije = json['nazivKategorije'] as String?;

Map<String, dynamic> _$KategorijeDijelovaPregledToJson(
        KategorijeDijelovaPregled instance) =>
    <String, dynamic>{
      'kategorijaDijelovaId': instance.kategorijaDijelovaId,
      'nazivKategorije': instance.nazivKategorije,
    };
