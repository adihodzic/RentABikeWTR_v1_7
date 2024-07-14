import 'dart:ffi';
//import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'korisniciUpsert.g.dart';

@JsonSerializable()
class KorisniciUpsert {
  String? korisnickoIme;
  String? password;
  String? passwordPotvrda;
  String? ime;
  String? prezime;
  bool aktivan = true;
  String? telefon;
  String? email;
  int? drzavaID;
  //String? nazivDrzave;
  DateTime? datumRegistracije = DateTime.now();
  int? ulogaID = 2;

  KorisniciUpsert(
      {this.korisnickoIme,
      this.password,
      this.passwordPotvrda,
      this.ime,
      this.prezime,
      this.aktivan = true,
      this.telefon,
      this.email,
      this.drzavaID,
      //this.nazivDrzave,
      DateTime? datumRegistracije,
      this.ulogaID}) {}

  factory KorisniciUpsert.fromJson(Map<String, dynamic> json) =>
      _$KorisniciUpsertFromJson(json);

  /// Connect the generated [_$KorisniciUpsertToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KorisniciUpsertToJson(this);
}
