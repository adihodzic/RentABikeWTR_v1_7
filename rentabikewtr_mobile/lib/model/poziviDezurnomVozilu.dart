//import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'poziviDezurnomVozilu.g.dart';

@JsonSerializable()
class PoziviDezurnomVozilu {
  String? viseDetalja = "";
  bool? nesreca;
  bool? zahtjevKlijenta;
  bool? kvar;
  bool? losiVremenskiUslovi;
  DateTime? datumPoziva = DateTime.now();
  DateTime? vrijemePoziva;
  int? dezurnoVoziloID;
  int? turistickiVodicID;
  int? poslovnicaID;

  PoziviDezurnomVozilu(
      {this.viseDetalja,
      this.nesreca,
      this.zahtjevKlijenta,
      this.kvar,
      this.losiVremenskiUslovi,
      this.datumPoziva,
      this.vrijemePoziva,
      this.dezurnoVoziloID,
      this.turistickiVodicID,
      this.poslovnicaID}) {}

  factory PoziviDezurnomVozilu.fromJson(Map<String, dynamic> json) =>
      _$PoziviDezurnomVoziluFromJson(json);

  /// Connect the generated [_$PoziviDezurnomVoziluToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PoziviDezurnomVoziluToJson(this);
}
