// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervniDijeloviPregled.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervniDijeloviPregled _$RezervniDijeloviPregledFromJson(
        Map<String, dynamic> json) =>
    RezervniDijeloviPregled(
      rezervniDijeloviId: (json['rezervniDijeloviId'] as num?)?.toInt(),
      nazivRezervnogDijela: json['nazivRezervnogDijela'] as String?,
      sifraArtikla: json['sifraArtikla'] as String?,
      naStanju: (json['naStanju'] as num?)?.toInt(),
      nazivKategorije: json['nazivKategorije'] as String?,
    );

Map<String, dynamic> _$RezervniDijeloviPregledToJson(
        RezervniDijeloviPregled instance) =>
    <String, dynamic>{
      'rezervniDijeloviId': instance.rezervniDijeloviId,
      'nazivRezervnogDijela': instance.nazivRezervnogDijela,
      'sifraArtikla': instance.sifraArtikla,
      'naStanju': instance.naStanju,
      'nazivKategorije': instance.nazivKategorije,
    };
