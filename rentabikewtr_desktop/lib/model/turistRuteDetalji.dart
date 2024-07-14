import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'turistRuteDetalji.g.dart';

@JsonSerializable()
class TuristRuteDetalji {
  int? turistRutaId;
  String? naziv;
  String? opisRute;
  num? cijenaRute;
  String? slikaRute;

  TuristRuteDetalji(
      {this.turistRutaId,
      this.naziv,
      this.opisRute,
      this.cijenaRute,
      this.slikaRute}) {}

  factory TuristRuteDetalji.fromJson(Map<String, dynamic> json) =>
      _$TuristRuteDetaljiFromJson(json);

  /// Connect the generated [_$BicikliDetaljiToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TuristRuteDetaljiToJson(this);
}
