import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'bicikliDetalji.g.dart';

@JsonSerializable()
class BicikliDetalji {
  int? biciklId;
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

  BicikliDetalji(
      this.biciklId,
      this.poslovnicaID,
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
      this.statusID) {}

  factory BicikliDetalji.fromJson(Map<String, dynamic> json) =>
      _$BicikliDetaljiFromJson(json);

  /// Connect the generated [_$BicikliDetaljiToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BicikliDetaljiToJson(this);
}
