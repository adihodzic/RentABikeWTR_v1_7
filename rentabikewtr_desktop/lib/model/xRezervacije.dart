import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'xRezervacije.g.dart';

@JsonSerializable()
class XRezervacije {
  int? rezervacijaId;
  DateTime? datum;
  num? cijenaUsluge;
  int? kupacID;
  String? korisnickoIme;
  int? biciklID;
  String? nazivBicikla;
  int? turistRutaID;
  String? naziv;

  // int? turistickiVodicID;
  // int? turistRutaID;

  XRezervacije() {}

  factory XRezervacije.fromJson(Map<String, dynamic> json) =>
      _$XRezervacijeFromJson(json);

  /// Connect the generated [_$XRezervacijeToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$XRezervacijeToJson(this);
}
