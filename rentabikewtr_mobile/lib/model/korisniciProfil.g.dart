// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisniciProfil.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisniciProfil _$KorisniciProfilFromJson(Map<String, dynamic> json) =>
    KorisniciProfil(
      korisnikId: json['korisnikId'] as int?,
      korisnickoIme: json['korisnickoIme'] as String?,
      password: json['password'] as String?,
      passwordPotvrda: json['passwordPotvrda'] as String?,
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      aktivan: json['aktivan'] as bool? ?? true,
      telefon: json['telefon'] as String?,
      email: json['email'] as String?,
      drzavaID: json['drzavaID'] as int?,
      datumRegistracije: json['datumRegistracije'] == null
          ? null
          : DateTime.parse(json['datumRegistracije'] as String),
      ulogaID: json['ulogaID'] as int?,
    );

Map<String, dynamic> _$KorisniciProfilToJson(KorisniciProfil instance) =>
    <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'korisnickoIme': instance.korisnickoIme,
      'password': instance.password,
      'passwordPotvrda': instance.passwordPotvrda,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'aktivan': instance.aktivan,
      'telefon': instance.telefon,
      'email': instance.email,
      'drzavaID': instance.drzavaID,
      'datumRegistracije': instance.datumRegistracije?.toIso8601String(),
      'ulogaID': instance.ulogaID,
    };
