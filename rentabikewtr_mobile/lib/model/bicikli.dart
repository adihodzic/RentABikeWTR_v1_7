import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'bicikli.g.dart';

@JsonSerializable()
class Bicikli {
  int? biciklID;
  String? nazivBicikla;
  num? cijenaBicikla;
  String? nazivProizvodjaca;
  String? nazivModela;
  String? nazivTipa;
  String? boja;
  String? nazivPoslovnice;
  String? slika;

  Bicikli() {}

  factory Bicikli.fromJson(Map<String, dynamic> json) =>
      _$BicikliFromJson(json);

  /// Connect the generated [_$BicikliToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BicikliToJson(this);
}
