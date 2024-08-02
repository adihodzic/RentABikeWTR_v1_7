// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervniDijeloviDetalji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervniDijeloviDetalji _$RezervniDijeloviDetaljiFromJson(
        Map<String, dynamic> json) =>
    RezervniDijeloviDetalji(
      rezervniDijeloviId: (json['rezervniDijeloviId'] as num?)?.toInt(),
      nazivRezervnogDijela: json['nazivRezervnogDijela'] as String?,
      sifraArtikla: json['sifraArtikla'] as String?,
      naStanju: (json['naStanju'] as num?)?.toInt(),
      kategorijaDijelovaID: (json['kategorijaDijelovaID'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RezervniDijeloviDetaljiToJson(
        RezervniDijeloviDetalji instance) =>
    <String, dynamic>{
      'rezervniDijeloviId': instance.rezervniDijeloviId,
      'nazivRezervnogDijela': instance.nazivRezervnogDijela,
      'sifraArtikla': instance.sifraArtikla,
      'naStanju': instance.naStanju,
      'kategorijaDijelovaID': instance.kategorijaDijelovaID,
    };
