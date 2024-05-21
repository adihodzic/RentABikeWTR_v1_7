import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/model/dezurnaVozila.dart';
import 'package:rentabikewtr_mobile/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/lokacijeOdmora.dart';

class DezurnaVozilaProvider extends BaseProvider<DezurnaVozila> {
  DezurnaVozilaProvider() : super("DezurnaVozila"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u rezervacija_korak2_screen.dart
  @override
  DezurnaVozila fromJson(data) {
    return DezurnaVozila.fromJson(data);
  }
}
