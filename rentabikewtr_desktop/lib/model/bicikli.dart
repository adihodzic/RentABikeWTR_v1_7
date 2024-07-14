import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'bicikli.g.dart';

@JsonSerializable()
class Bicikli {
  int? poslovnicaID;
  String? nazivBicikla;
  num? cijenaBicikla;
  String? boja;
  String? slika;
  int? modelBiciklaID;
  int? tipBiciklaID;
  int? proizvodjacBiciklaID;
  int? drzavaID;
  num? nabavnaCijena;
  String? vrstaRama;
  DateTime? godinaProizvodnje;
  int? statusID;
  int? velicinaBiciklaID;
  DateTime? datumOtpisa;

  Bicikli(
      {this.poslovnicaID,
      this.nazivBicikla,
      this.cijenaBicikla,
      this.boja,
      this.slika,
      this.modelBiciklaID,
      this.tipBiciklaID,
      this.proizvodjacBiciklaID,
      this.drzavaID,
      this.nabavnaCijena,
      this.vrstaRama,
      this.godinaProizvodnje,
      this.statusID,
      this.velicinaBiciklaID,
      this.datumOtpisa}) {}

  factory Bicikli.fromJson(Map<String, dynamic> json) =>
      _$BicikliFromJson(json);

  /// Connect the generated [_$BicikliToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BicikliToJson(this);
}
