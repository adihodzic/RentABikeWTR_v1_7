import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'rezervacijePregled.g.dart';

@JsonSerializable()
class RezervacijePregled {
  int? rezervacijaId;
  int? biciklID;
  int? kupacID;
  DateTime? datumIzdavanja;
  String? nazivBicikla;
  String? korisnickoIme;
  String? ime;
  String? prezime;

  // int? turistickiVodicID;
  // int? turistRutaID;

  RezervacijePregled() {}

  factory RezervacijePregled.fromJson(Map<String, dynamic> json) =>
      _$RezervacijePregledFromJson(json);

  /// Connect the generated [_$BicikliToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RezervacijePregledToJson(this);
}
