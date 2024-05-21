import 'dart:ffi';
//import 'dart:html';

import 'package:json_annotation/json_annotation.dart';

part 'rezervacije.g.dart';

@JsonSerializable(explicitToJson: true)
class Rezervacije {
  int? rezervacijaId;
  DateTime? datumIzdavanja;
  DateTime? vrijemePreuzimanja;
  DateTime? vrijemeVracanja;
  bool statusPlacanja = true;
  @JsonKey(name: 'cijenaUsluge')
  num? cijenaUsluge;
  int? biciklId;
  int? turistickiVodicID;
  int? turistRutaID;
  int? kupacID;
  int? korisnikID;

  Rezervacije(
      {this.rezervacijaId,
      required datumIzdavanja,
      required vrijemePreuzimanja,
      required vrijemeVracanja,
      required this.statusPlacanja,
      this.cijenaUsluge,
      this.biciklId,
      this.turistickiVodicID,
      this.turistRutaID,
      this.kupacID,
      this.korisnikID}) {}

  factory Rezervacije.fromJson(Map<String, dynamic> json) =>
      _$RezervacijeFromJson(json);

  /// Connect the generated [_$RezervacijeToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RezervacijeToJson(this);
}
