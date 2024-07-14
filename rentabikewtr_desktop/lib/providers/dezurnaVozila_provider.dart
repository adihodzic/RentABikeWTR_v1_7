import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/model/dezurnaVozila.dart';
import 'package:rentabikewtr_desktop/model/dezurnaVozilaDetalji.dart';
import 'package:rentabikewtr_desktop/model/dezurnaVozilaPregled.dart';
import 'package:rentabikewtr_desktop/model/modeliBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/poslovnicePregled.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class DezurnaVozilaProvider extends BaseProvider<DezurnaVozila> {
  DezurnaVozilaProvider() : super("DezurnaVozila"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u bicikli_list_screen.dart
  @override
  DezurnaVozila fromJson(data) {
    return DezurnaVozila.fromJson(data);
  }
}
