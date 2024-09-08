import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/model/modeliBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/poruke.dart';
import 'package:rentabikewtr_desktop/model/poslovnice.dart';
import 'package:rentabikewtr_desktop/model/poslovniceDetalji.dart';
import 'package:rentabikewtr_desktop/model/poslovnicePregled.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class PorukeProvider extends BaseProvider<Poruke> {
  PorukeProvider() : super("Poruke"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u bicikli_list_screen.dart
  @override
  Poruke fromJson(data) {
    return Poruke.fromJson(data);
  }
}
