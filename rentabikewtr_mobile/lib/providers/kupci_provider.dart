import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_mobile/model/korisnici.dart';
import 'package:rentabikewtr_mobile/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/kupci.dart';

class KupciProvider extends BaseProvider<Kupci> {
  KupciProvider() : super("Kupci");

  @override
  Kupci fromJson(data) {
    // TODO: implement fromJson
    return Kupci.fromJson(data);
  }
}
