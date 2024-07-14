import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_desktop/model/korisniciUpsert.dart';
import 'package:rentabikewtr_desktop/model/korisniciPregled.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class KorisniciPregledProvider extends BaseProvider<KorisniciPregled> {
  KorisniciPregledProvider() : super("Korisnici");

  @override
  KorisniciPregled fromJson(data) {
    // TODO: implement fromJson
    return KorisniciPregled.fromJson(data);
  }
}
