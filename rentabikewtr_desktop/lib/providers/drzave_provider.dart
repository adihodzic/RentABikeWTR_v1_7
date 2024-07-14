import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_desktop/model/drzave.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class DrzaveProvider extends BaseProvider<Drzave> {
  DrzaveProvider() : super("DrzaveMobilna");

  @override
  Drzave fromJson(data) {
    // TODO: implement fromJson
    return Drzave.fromJson(data);
  }
}
