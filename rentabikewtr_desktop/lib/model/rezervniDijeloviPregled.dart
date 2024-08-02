import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'rezervniDijeloviPregled.g.dart';

@JsonSerializable()
class RezervniDijeloviPregled {
  int? rezervniDijeloviId;
  String? nazivRezervnogDijela;
  String? sifraArtikla;
  int? naStanju; // Naziv turistickog vodica
  String? nazivKategorije;

  //radjeno na ovaj nacin zbog konverzija u servisiranjima
  RezervniDijeloviPregled({
    this.rezervniDijeloviId,
    this.nazivRezervnogDijela,
    this.sifraArtikla,
    this.naStanju, // Naziv turistickog vodica
    this.nazivKategorije,
  }) {}

  factory RezervniDijeloviPregled.fromJson(Map<String, dynamic> json) =>
      _$RezervniDijeloviPregledFromJson(json);

  /// Connect the generated [_$RezervniDijeloviPregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RezervniDijeloviPregledToJson(this);
}
