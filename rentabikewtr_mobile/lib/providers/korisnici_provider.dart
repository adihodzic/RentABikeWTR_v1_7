import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_mobile/model/korisnici.dart';
import 'package:rentabikewtr_mobile/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class KorisniciProvider extends BaseProvider<Korisnici> {
  KorisniciProvider() : super("Korisnici");

  @override
  Korisnici fromJson(data) {
    // TODO: implement fromJson
    return Korisnici.fromJson(data);
  }
}
