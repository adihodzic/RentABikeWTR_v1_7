import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/model/modeliBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/proizvodjaciBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class ProizvodjaciBiciklaPregledProvider
    extends BaseProvider<ProizvodjaciBiciklaPregled> {
  ProizvodjaciBiciklaPregledProvider()
      : super("ProizvodjaciBicikla"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u bicikli_list_screen.dart
  @override
  ProizvodjaciBiciklaPregled fromJson(data) {
    return ProizvodjaciBiciklaPregled.fromJson(data);
  }
}
