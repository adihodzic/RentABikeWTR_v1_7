import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:rentabikewtr_desktop/model/rezervniDijeloviPregled.dart';

part 'servisiranjaPregled.g.dart';

@JsonSerializable()
class ServisiranjaPregled {
  int? servisiranjeId;
  String? opisKvara;
  DateTime? datumServisiranja;
  String? preduzetaAkcija;
  String? komentarServisera;
  String? nazivBicikla;
  int? biciklID;
  List<RezervniDijeloviPregled>? rezervniDijelovi;

  ServisiranjaPregled() {}

  factory ServisiranjaPregled.fromJson(Map<String, dynamic> json) =>
      _$ServisiranjaPregledFromJson(json);

  /// Connect the generated [_$ServisiranjaPregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ServisiranjaPregledToJson(this);
}
