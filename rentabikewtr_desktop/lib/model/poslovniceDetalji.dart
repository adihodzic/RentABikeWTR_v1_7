import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'poslovniceDetalji.g.dart';

@JsonSerializable()
class PoslovniceDetalji {
  int? poslovnicaId;
  String? nazivPoslovnice;
  String? emailKontakt;
  String? adresa;
  String? brojTelefona;

  PoslovniceDetalji(
      {this.poslovnicaId,
      this.nazivPoslovnice,
      this.emailKontakt,
      this.adresa,
      this.brojTelefona}) {}

  factory PoslovniceDetalji.fromJson(Map<String, dynamic> json) =>
      _$PoslovniceDetaljiFromJson(json);

  /// Connect the generated [_$PoslovniceDetaljiToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PoslovniceDetaljiToJson(this);
}
