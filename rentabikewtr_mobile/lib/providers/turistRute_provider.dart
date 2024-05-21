import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/turistRute.dart';

class TuristRuteProvider extends BaseProvider<TuristRute> {
  TuristRuteProvider() : super("TuristRute"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u rezervacija_korak2_screen.dart
  @override
  TuristRute fromJson(data) {
    return TuristRute.fromJson(data);
  }
}
