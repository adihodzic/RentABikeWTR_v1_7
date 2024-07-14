// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bicikli.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bicikli _$BicikliFromJson(Map<String, dynamic> json) => Bicikli(
      poslovnicaID: (json['poslovnicaID'] as num?)?.toInt(),
      nazivBicikla: json['nazivBicikla'] as String?,
      cijenaBicikla: json['cijenaBicikla'] as num?,
      boja: json['boja'] as String?,
      slika: json['slika'] as String?,
      modelBiciklaID: (json['modelBiciklaID'] as num?)?.toInt(),
      tipBiciklaID: (json['tipBiciklaID'] as num?)?.toInt(),
      proizvodjacBiciklaID: (json['proizvodjacBiciklaID'] as num?)?.toInt(),
      drzavaID: (json['drzavaID'] as num?)?.toInt(),
      nabavnaCijena: json['nabavnaCijena'] as num?,
      vrstaRama: json['vrstaRama'] as String?,
      godinaProizvodnje: json['godinaProizvodnje'] == null
          ? null
          : DateTime.parse(json['godinaProizvodnje'] as String),
      statusID: (json['statusID'] as num?)?.toInt(),
      velicinaBiciklaID: (json['velicinaBiciklaID'] as num?)?.toInt(),
      datumOtpisa: json['datumOtpisa'] == null
          ? null
          : DateTime.parse(json['datumOtpisa'] as String),
    );

Map<String, dynamic> _$BicikliToJson(Bicikli instance) => <String, dynamic>{
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
      'datumOtpisa': instance.datumOtpisa?.toIso8601String(),
    };
