import 'dart:convert';
import 'dart:io';
import 'dart:async';
//import 'package:rentabikewtr_mobile/model/korisnici.dart';
//import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_desktop/model/xRezervacije.dart';
import 'package:rentabikewtr_desktop/model/xRezervacijeResult.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/rezervacije.dart';
import '../model/rezervacijePregled.dart';

class XRezervacijeResultProvider extends BaseProvider<XRezervacijeResult> {
  XRezervacijeResultProvider() : super("Rezervacije/XRezervacije");

  @override
  XRezervacijeResult fromJson(data) {
    // TODO: implement fromJson
    return XRezervacijeResult.fromJson(data);
  }
}
