import 'dart:ffi';
//import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'korisniciPregled.g.dart';

@JsonSerializable()
class KorisniciPregled {
  //int? korisnikId;
  String? korisnickoIme;
  //String? password;
  String? email;
  String? ime;
  String? prezime;
  // String? telefon;
  //DateTime datumRegistracija = DateTime.now();
  //bool? aktivan = true;
  // int? ulogaID;
  // int? drzavaID;

  KorisniciPregled() {}

  factory KorisniciPregled.fromJson(Map<String, dynamic> json) =>
      _$KorisniciPregledFromJson(json);

  /// Connect the generated [_$KorisniciPregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KorisniciPregledToJson(this);
}
