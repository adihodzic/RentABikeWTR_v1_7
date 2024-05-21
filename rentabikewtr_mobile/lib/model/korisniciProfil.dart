import 'dart:ffi';
//import 'dart:html';

import 'package:json_annotation/json_annotation.dart';

part 'korisniciProfil.g.dart';

@JsonSerializable(explicitToJson: true)
class KorisniciProfil {
  int? korisnikId;
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
  int? ulogaID = 4;

  KorisniciProfil(
      {this.korisnikId,
      this.korisnickoIme,
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

  factory KorisniciProfil.fromJson(Map<String, dynamic> json) =>
      _$KorisniciProfilFromJson(json);

  /// Connect the generated [_$KorisniciProfilToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KorisniciProfilToJson(this);
}
