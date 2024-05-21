import 'dart:ffi';
//import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'korisnici.g.dart';

@JsonSerializable()
class Korisnici {
  //int? korisnikId;
  String? korisnickoIme;
  //String? password;
  // String? email;
  // String? ime;
  // String? prezime;
  // String? telefon;
  //DateTime datumRegistracija = DateTime.now();
  //bool? aktivan = true;
  // int? ulogaID;
  // int? drzavaID;

  Korisnici() {}

  factory Korisnici.fromJson(Map<String, dynamic> json) =>
      _$KorisniciFromJson(json);

  /// Connect the generated [_$KorisniciToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KorisniciToJson(this);
}
