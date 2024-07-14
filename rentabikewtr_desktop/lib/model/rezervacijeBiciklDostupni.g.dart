// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervacijeBiciklDostupni.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RezervacijeBiciklDostupni _$RezervacijeBiciklDostupniFromJson(
        Map<String, dynamic> json) =>
    RezervacijeBiciklDostupni()
      ..biciklID = (json['biciklID'] as num?)?.toInt()
      ..poslovnicaID = (json['poslovnicaID'] as num?)?.toInt()
      ..nazivBicikla = json['nazivBicikla'] as String?
      ..cijenaBicikla = json['cijenaBicikla'] as num?
      ..boja = json['boja'] as String?
      ..slika = json['slika'] as String?
      ..nazivPoslovnice = json['nazivPoslovnice'] as String?
      ..modelBiciklaID = (json['modelBiciklaID'] as num?)?.toInt()
      ..nazivModela = json['nazivModela'] as String?
      ..tipBiciklaID = (json['tipBiciklaID'] as num?)?.toInt()
      ..nazivTipa = json['nazivTipa'] as String?
      ..proizvodjacBiciklaID = (json['proizvodjacBiciklaID'] as num?)?.toInt()
      ..nazivProizvodjaca = json['nazivProizvodjaca'] as String?
      ..drzavaID = (json['drzavaID'] as num?)?.toInt()
      ..nazivDrzave = json['nazivDrzave'] as String?;

Map<String, dynamic> _$RezervacijeBiciklDostupniToJson(
        RezervacijeBiciklDostupni instance) =>
    <String, dynamic>{
      'biciklID': instance.biciklID,
      'poslovnicaID': instance.poslovnicaID,
      'nazivBicikla': instance.nazivBicikla,
      'cijenaBicikla': instance.cijenaBicikla,
      'boja': instance.boja,
      'slika': instance.slika,
      'nazivPoslovnice': instance.nazivPoslovnice,
      'modelBiciklaID': instance.modelBiciklaID,
      'nazivModela': instance.nazivModela,
      'tipBiciklaID': instance.tipBiciklaID,
      'nazivTipa': instance.nazivTipa,
      'proizvodjacBiciklaID': instance.proizvodjacBiciklaID,
      'nazivProizvodjaca': instance.nazivProizvodjaca,
      'drzavaID': instance.drzavaID,
      'nazivDrzave': instance.nazivDrzave,
    };
