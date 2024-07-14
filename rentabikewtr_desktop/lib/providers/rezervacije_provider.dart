import 'dart:convert';
import 'dart:io';
import 'dart:async';
//import 'package:rentabikewtr_mobile/model/korisnici.dart';
//import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/rezervacije.dart';
import '../model/rezervacijePregled.dart';

class RezervacijeProvider extends BaseProvider<Rezervacije> {
  RezervacijeProvider() : super("Rezervacije/Mobilna");

  @override
  Rezervacije fromJson(data) {
    // TODO: implement fromJson
    return Rezervacije.fromJson(data);
  }
}
