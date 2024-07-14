// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bicikliDetalji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BicikliDetalji _$BicikliDetaljiFromJson(Map<String, dynamic> json) =>
    BicikliDetalji(
      (json['biciklId'] as num?)?.toInt(),
      (json['poslovnicaID'] as num?)?.toInt(),
      json['nazivBicikla'] as String?,
      json['cijenaBicikla'] as num?,
      json['boja'] as String?,
      json['slika'] as String?,
      (json['modelBiciklaID'] as num?)?.toInt(),
      (json['tipBiciklaID'] as num?)?.toInt(),
      (json['proizvodjacBiciklaID'] as num?)?.toInt(),
      (json['drzavaID'] as num?)?.toInt(),
      json['nabavnaCijena'] as num?,
      json['vrstaRama'] as String?,
      json['godinaProizvodnje'] == null
          ? null
          : DateTime.parse(json['godinaProizvodnje'] as String),
      (json['statusID'] as num?)?.toInt(),
    )..velicinaBiciklaID = (json['velicinaBiciklaID'] as num?)?.toInt();

Map<String, dynamic> _$BicikliDetaljiToJson(BicikliDetalji instance) =>
    <String, dynamic>{
      'biciklId': instance.biciklId,
      'poslovnicaID': instance.poslovnicaID,
      'nazivBicikla': instance.nazivBicikla,
      'cijenaBicikla': instance.cijenaBicikla,
      'boja': instance.boja,
      'slika': instance.slika,
      'modelBiciklaID': instance.modelBiciklaID,
      'tipBiciklaID': instance.tipBiciklaID,
      'proizvodjacBiciklaID': instance.proizvodjacBiciklaID,
      'drzavaID': instance.drzavaID,
      'nabavnaCijena': instance.nabavnaCijena,
      'vrstaRama': instance.vrstaRama,
      'godinaProizvodnje': instance.godinaProizvodnje?.toIso8601String(),
      'statusID': instance.statusID,
      'velicinaBiciklaID': instance.velicinaBiciklaID,
    };
