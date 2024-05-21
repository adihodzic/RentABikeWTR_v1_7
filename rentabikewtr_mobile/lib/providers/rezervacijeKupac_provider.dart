import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_mobile/model/korisnici.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/rezervacije.dart';
import '../model/rezervacijePregled.dart';

class RezervacijeKupacProvider extends BaseProvider<RezervacijePregled> {
  RezervacijeKupacProvider() : super("Rezervacije/XKupac");

  @override
  RezervacijePregled fromJson(data) {
    // TODO: implement fromJson
    return RezervacijePregled.fromJson(data);
  }
}
