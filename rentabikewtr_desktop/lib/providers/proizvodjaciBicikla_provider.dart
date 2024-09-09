import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/model/modeliBicikla.dart';
import 'package:rentabikewtr_desktop/model/proizvodjaciBicikla.dart';
import 'package:rentabikewtr_desktop/model/tipoviBicikla.dart';
import 'package:rentabikewtr_desktop/model/tipoviBiciklaDetalji.dart';
import 'package:rentabikewtr_desktop/model/turistRuteDetalji.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/turistRutePregled.dart';

class ProizvodjaciBiciklaProvider extends BaseProvider<ProizvodjaciBicikla> {
  ProizvodjaciBiciklaProvider() : super("ProizvodjaciBicikla"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u rezervacija_korak2_screen.dart
  @override
  ProizvodjaciBicikla fromJson(data) {
    return ProizvodjaciBicikla.fromJson(data);
  }
}
