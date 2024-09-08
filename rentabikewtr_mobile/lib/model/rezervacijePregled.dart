import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'rezervacijePregled.g.dart';

@JsonSerializable()
class RezervacijePregled {
  int? rezervacijaId;
  DateTime? datumIzdavanja;
  int? biciklID;
  int? kupacID;
  int? turistickiVodicID;
  int? turistRutaID;
  num? cijenaUsluge;

  RezervacijePregled() {}

  factory RezervacijePregled.fromJson(Map<String, dynamic> json) =>
      _$RezervacijePregledFromJson(json);

  /// Connect the generated [_$BicikliToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RezervacijePregledToJson(this);
}
