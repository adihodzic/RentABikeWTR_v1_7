import 'dart:convert';
import 'dart:io';
import 'dart:async';
//import 'package:rentabikewtr_desktop/model/korisnici.dart';
import 'package:rentabikewtr_desktop/model/korisniciProfil.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class KorisniciProfilProvider extends BaseProvider<KorisniciProfil> {
  KorisniciProfilProvider() : super("Korisnici/Profil");

  @override
  KorisniciProfil fromJson(data) {
    // TODO: implement fromJson
    return KorisniciProfil.fromJson(data);
  }
}
