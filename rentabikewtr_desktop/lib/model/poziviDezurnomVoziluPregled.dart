import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'poziviDezurnomVoziluPregled.g.dart';

@JsonSerializable()
class PoziviDezurnomVoziluPregled {
  int? pozivDezurnomVoziluId;
  String? viseDetalja;
  bool? nesreca = false;
  bool? zahtjevKlijenta = false;
  bool? kvar = false;
  bool? losiVremenskiUslovi = false;
  DateTime? datumPoziva;
  DateTime? vrijemePoziva;
  String? nazivDezurnogVozila;
  String? naziv; // Naziv turistickog vodica
  String? nazivPoslovnice;

  PoziviDezurnomVoziluPregled() {}

  factory PoziviDezurnomVoziluPregled.fromJson(Map<String, dynamic> json) =>
      _$PoziviDezurnomVoziluPregledFromJson(json);

  /// Connect the generated [_$PoziviDezurnomVoziluPregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PoziviDezurnomVoziluPregledToJson(this);
}
