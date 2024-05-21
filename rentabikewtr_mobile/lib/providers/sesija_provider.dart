import 'dart:convert';
import 'dart:io';
import 'dart:async';
//import 'package:rentabikewtr_app/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/sesija.dart';
import 'base_provider.dart';

class SesijaProvider extends BaseProvider<dynamic> {
  SesijaProvider() : super("Sesija");

  @override
  Sesija fromJson(data) {
    return Sesija.fromJson(data);
  }
}
