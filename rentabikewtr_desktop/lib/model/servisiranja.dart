import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:rentabikewtr_desktop/model/rezervniDijeloviPregled.dart';

part 'servisiranja.g.dart';

@JsonSerializable()
class Servisiranja {
  String? opisKvara;
  DateTime? datumServisiranja;
  String? preduzetaAkcija;
  String? komentarServisera;
  //String? nazivBicikla;
  int? biciklID;
  List<RezervniDijeloviPregled>? rezervniDijelovi;

  Servisiranja(
      {this.opisKvara,
      this.datumServisiranja,
      this.preduzetaAkcija,
      this.komentarServisera,
      //this.nazivBicikla,
      this.biciklID,
      this.rezervniDijelovi}) {}

  factory Servisiranja.fromJson(Map<String, dynamic> json) =>
      _$ServisiranjaFromJson(json);

  /// Connect the generated [_$ServisiranjaToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ServisiranjaToJson(this);
}
