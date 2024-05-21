import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'najavaOdmora.g.dart';

@JsonSerializable()
class NajavaOdmora {
  DateTime? datumOdmora = DateTime.now();
  DateTime? pocetakOdmora;
  DateTime? zavrsetakOdmora;
  int? napitakKolicina;
  int? launchPaketKolicina;
  int? lokacijaOdmoraID;
  int? turistickiVodicID;

  NajavaOdmora(
      {this.datumOdmora,
      this.pocetakOdmora,
      this.zavrsetakOdmora,
      this.napitakKolicina,
      this.launchPaketKolicina,
      this.lokacijaOdmoraID,
      this.turistickiVodicID}) {}

  factory NajavaOdmora.fromJson(Map<String, dynamic> json) =>
      _$NajavaOdmoraFromJson(json);

  /// Connect the generated [_$NajavaOdmoraToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NajavaOdmoraToJson(this);
}
