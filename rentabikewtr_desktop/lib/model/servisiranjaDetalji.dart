import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:rentabikewtr_desktop/model/rezervniDijeloviPregled.dart';

part 'servisiranjaDetalji.g.dart';

@JsonSerializable()
class ServisiranjaDetalji {
  int? servisiranjeId;
  String? opisKvara;
  //DateTime? datumServisiranja;
  String? preduzetaAkcija;
  String? komentarServisera;
  //String? nazivBicikla;
  int? biciklID;
  List<RezervniDijeloviPregled>? rezervniDijelovi;

  ServisiranjaDetalji(
      {this.servisiranjeId,
      this.opisKvara,
      //this.datumServisiranja,
      this.preduzetaAkcija,
      this.komentarServisera,
      //this.nazivBicikla,
      this.biciklID,
      this.rezervniDijelovi}) {}

  factory ServisiranjaDetalji.fromJson(Map<String, dynamic> json) =>
      _$ServisiranjaDetaljiFromJson(json);

  /// Connect the generated [_$ServisiranjaDetaljiToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ServisiranjaDetaljiToJson(this);
}
