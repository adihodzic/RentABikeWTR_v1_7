import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'rezervacijeBiciklDostupni.g.dart';

@JsonSerializable()
class RezervacijeBiciklDostupni {
  int? biciklID;
  int? poslovnicaID;
  String? nazivBicikla;

  num? cijenaBicikla;
  String? boja;
  String? slika;
  String? nazivPoslovnice;
  int? modelBiciklaID;
  String? nazivModela;
  int? tipBiciklaID;
  String? nazivTipa;
  int? proizvodjacBiciklaID;
  String? nazivProizvodjaca;
  int? drzavaID;
  String? nazivDrzave;

  RezervacijeBiciklDostupni() {}

  factory RezervacijeBiciklDostupni.fromJson(Map<String, dynamic> json) =>
      _$RezervacijeBiciklDostupniFromJson(json);

  /// Connect the generated [_$BicikliToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RezervacijeBiciklDostupniToJson(this);
}
