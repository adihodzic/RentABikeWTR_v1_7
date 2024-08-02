import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'rezervniDijeloviDetalji.g.dart';

@JsonSerializable()
class RezervniDijeloviDetalji {
  int? rezervniDijeloviId;
  String? nazivRezervnogDijela;
  String? sifraArtikla;
  int? naStanju;
  int? kategorijaDijelovaID;

  RezervniDijeloviDetalji(
      {this.rezervniDijeloviId,
      this.nazivRezervnogDijela,
      this.sifraArtikla,
      this.naStanju,
      this.kategorijaDijelovaID}) {}

  factory RezervniDijeloviDetalji.fromJson(Map<String, dynamic> json) =>
      _$RezervniDijeloviDetaljiFromJson(json);

  /// Connect the generated [_$RezervniDijeloviDetaljiToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RezervniDijeloviDetaljiToJson(this);
}
