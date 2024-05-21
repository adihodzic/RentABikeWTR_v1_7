import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/lokacijeOdmora.dart';
import '../model/poslovnice.dart';

class PoslovniceProvider extends BaseProvider<Poslovnice> {
  PoslovniceProvider() : super("Poslovnice"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u rezervacija_korak2_screen.dart
  @override
  Poslovnice fromJson(data) {
    return Poslovnice.fromJson(data);
  }
}
