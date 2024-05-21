import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_mobile/model/korisnici.dart';
import 'package:rentabikewtr_mobile/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/korisniciUpsert.dart';

class KorisniciRegistracijaProvider extends BaseProvider<KorisniciUpsert> {
  KorisniciRegistracijaProvider() : super("Korisnici/Registracija");

  @override
  KorisniciUpsert fromJson(data) {
    // TODO: implement fromJson
    return KorisniciUpsert.fromJson(data);
  }
}
