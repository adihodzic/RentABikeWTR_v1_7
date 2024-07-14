import 'dart:ffi';
//import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'korisniciDetalji.g.dart';

@JsonSerializable()
class KorisniciDetalji {
  int? korisnikId;
  String? korisnickoIme;
  // String? password;
  // String? passwordPotvrda;
  String? ime;
  String? prezime;
  bool aktivan = true;
  String? telefon;
  String? email;
  int? drzavaID;
  //String? nazivDrzave;
  DateTime? datumRegistracije;
  int? ulogaID = 2;

  KorisniciDetalji(
      {this.korisnikId,
      this.korisnickoIme,
      // this.password,
      // this.passwordPotvrda,
      this.ime,
      this.prezime,
      this.aktivan = true,
      this.telefon,
      this.email,
      this.drzavaID,
      //this.nazivDrzave,
      this.datumRegistracije,
      this.ulogaID}) {}

  factory KorisniciDetalji.fromJson(Map<String, dynamic> json) =>
      _$KorisniciDetaljiFromJson(json);

  /// Connect the generated [_$KorisniciUpsertToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KorisniciDetaljiToJson(this);
}
