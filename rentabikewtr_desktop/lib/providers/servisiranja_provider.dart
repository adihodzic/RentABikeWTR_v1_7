import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/model/dezurnaVozilaDetalji.dart';
import 'package:rentabikewtr_desktop/model/dezurnaVozilaPregled.dart';
import 'package:rentabikewtr_desktop/model/modeliBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/poslovnicePregled.dart';
import 'package:rentabikewtr_desktop/model/servisiranja.dart';
import 'package:rentabikewtr_desktop/model/servisiranjaDetalji.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class ServisiranjaProvider extends BaseProvider<Servisiranja> {
  ServisiranjaProvider() : super("Servisiranja"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u bicikli_list_screen.dart
  @override
  Servisiranja fromJson(data) {
    return Servisiranja.fromJson(data);
  }
}
