import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/turistRutePregled.dart';

class TuristRutePregledProvider extends BaseProvider<TuristRutePregled> {
  TuristRutePregledProvider() : super("TuristRute"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u rezervacija_korak2_screen.dart
  @override
  TuristRutePregled fromJson(data) {
    return TuristRutePregled.fromJson(data);
  }
}
