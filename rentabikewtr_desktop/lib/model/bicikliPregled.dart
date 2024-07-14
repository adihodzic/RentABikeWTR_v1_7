import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'bicikliPregled.g.dart';

@JsonSerializable()
class BicikliPregled {
  int? biciklId;
  String? nazivBicikla;
  String? nazivModela;
  String? nazivTipa;
  String? slika;

  BicikliPregled() {}

  factory BicikliPregled.fromJson(Map<String, dynamic> json) =>
      _$BicikliPregledFromJson(json);

  /// Connect the generated [_$BicikliPregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BicikliPregledToJson(this);
}
