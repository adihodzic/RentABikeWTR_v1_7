import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_desktop/model/korisniciUpsert.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class KorisniciProvider extends BaseProvider<KorisniciUpsert> {
  KorisniciProvider() : super("Korisnici");

  @override
  KorisniciUpsert fromJson(data) {
    // TODO: implement fromJson
    return KorisniciUpsert.fromJson(data);
  }
}
