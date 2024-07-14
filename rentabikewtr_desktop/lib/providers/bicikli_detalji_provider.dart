import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_desktop/model/bicikliDetalji.dart';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class BicikliDetaljiProvider extends BaseProvider<BicikliDetalji> {
  BicikliDetaljiProvider() : super("Bicikli"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u bicikli_list_screen.dart
  @override
  BicikliDetalji fromJson(data) {
    return BicikliDetalji.fromJson(data);
  }
}
