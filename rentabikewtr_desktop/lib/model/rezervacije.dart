import 'dart:ffi';
//import 'dart:html';

import 'package:json_annotation/json_annotation.dart';

part 'rezervacije.g.dart';

@JsonSerializable(explicitToJson: true)
class Rezervacije {
  DateTime? datumIzdavanja;
  DateTime? vrijemePreuzimanja;
  DateTime? vrijemeVracanja;
  bool statusPlacanja = true;
  @JsonKey(name: 'cijenaUsluge')
  num? cijenaUsluge;
  int? biciklID;
  int? turistickiVodicID;
  int? turistRutaID;
  int? kupacID;
  int? korisnikID;

  Rezervacije(
      {required datumIzdavanja,
      required vrijemePreuzimanja,
      required vrijemeVracanja,
      required this.statusPlacanja,
      this.cijenaUsluge,
      this.biciklID,
      this.turistickiVodicID,
      this.turistRutaID,
      this.kupacID,
      this.korisnikID}) {}

  factory Rezervacije.fromJson(Map<String, dynamic> json) =>
      _$RezervacijeFromJson(json);

  /// Connect the generated [_$RezervacijeToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RezervacijeToJson(this);
}
