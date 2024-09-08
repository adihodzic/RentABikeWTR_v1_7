import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'najaveOdmora.g.dart';

@JsonSerializable()
class NajaveOdmora {
  DateTime? datumOdmora = DateTime.now();
  DateTime? pocetakOdmora;
  DateTime? zavrsetakOdmora;
  int? napitakKolicina;
  int? launchPaketKolicina;
  int? lokacijaOdmoraID;
  int? turistickiVodicID;

  NajaveOdmora(
      {this.datumOdmora,
      this.pocetakOdmora,
      this.zavrsetakOdmora,
      this.napitakKolicina,
      this.launchPaketKolicina,
      this.lokacijaOdmoraID,
      this.turistickiVodicID}) {}

  factory NajaveOdmora.fromJson(Map<String, dynamic> json) =>
      _$NajaveOdmoraFromJson(json);

  /// Connect the generated [_$NajaveOdmoraToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NajaveOdmoraToJson(this);
}
