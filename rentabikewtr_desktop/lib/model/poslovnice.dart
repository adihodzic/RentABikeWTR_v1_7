import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'poslovnice.g.dart';

@JsonSerializable()
class Poslovnice {
  String? nazivPoslovnice;
  String? emailKontakt;
  String? adresa;
  String? brojTelefona;

  Poslovnice(
      {this.nazivPoslovnice,
      this.emailKontakt,
      this.adresa,
      this.brojTelefona}) {}

  factory Poslovnice.fromJson(Map<String, dynamic> json) =>
      _$PoslovniceFromJson(json);

  /// Connect the generated [_$PoslovniceToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PoslovniceToJson(this);
}
