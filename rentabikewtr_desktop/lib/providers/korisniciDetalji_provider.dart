import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_desktop/model/korisniciDetalji.dart';
import 'package:rentabikewtr_desktop/model/korisniciUpsert.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class KorisniciDetaljiProvider extends BaseProvider<KorisniciDetalji> {
  KorisniciDetaljiProvider() : super("Korisnici/Profil");

  @override
  KorisniciDetalji fromJson(data) {
    // TODO: implement fromJson
    return KorisniciDetalji.fromJson(data);
  }
}
