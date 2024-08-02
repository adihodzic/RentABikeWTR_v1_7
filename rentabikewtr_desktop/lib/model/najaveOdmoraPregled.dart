import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'najaveOdmoraPregled.g.dart';

@JsonSerializable()
class NajaveOdmoraPregled {
  int? najavaOdmoraId;
  DateTime? datumOdmora;
  DateTime? pocetakOdmora;
  DateTime? zavrsetakOdmora;
  int? napitakKolicina;
  int? launchPaketKolicina;
  int? lokacijaOdmoraID;
  String? nazivLokacije; //naziv lokacije
  int? turistickiVodicID;
  String? nazivVodica;

  NajaveOdmoraPregled() {}

  factory NajaveOdmoraPregled.fromJson(Map<String, dynamic> json) =>
      _$NajaveOdmoraPregledFromJson(json);

  /// Connect the generated [_$NajaveOdmoraPregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NajaveOdmoraPregledToJson(this);
}
