import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_mobile/model/korisnici.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/kupciProfil.dart';

class KupciProfilProvider extends BaseProvider<KupciProfil> {
  KupciProfilProvider() : super("KupciMobilna");

  @override
  KupciProfil fromJson(data) {
    // TODO: implement fromJson
    return KupciProfil.fromJson(data);
  }
}
