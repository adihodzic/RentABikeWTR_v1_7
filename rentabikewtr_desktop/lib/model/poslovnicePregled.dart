import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'poslovnicePregled.g.dart';

@JsonSerializable()
class PoslovnicePregled {
  int? poslovnicaId;
  String? nazivPoslovnice;
  String? emailKontakt;
  String? adresa;
  String? brojTelefona;

  PoslovnicePregled() {}

  factory PoslovnicePregled.fromJson(Map<String, dynamic> json) =>
      _$PoslovnicePregledFromJson(json);

  /// Connect the generated [_$PoslovnicePregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PoslovnicePregledToJson(this);
}
