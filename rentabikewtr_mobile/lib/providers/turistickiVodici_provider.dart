import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/turistickiVodici.dart';

class TuristickiVodiciProvider extends BaseProvider<TuristickiVodici> {
  TuristickiVodiciProvider() : super("TuristickiVodici"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u rezervacija_korak2_screen.dart
  @override
  TuristickiVodici fromJson(data) {
    return TuristickiVodici.fromJson(data);
  }
}
