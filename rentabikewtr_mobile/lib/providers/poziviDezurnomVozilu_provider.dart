import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/lokacijeOdmora.dart';
import '../model/poziviDezurnomVozilu.dart';

class PoziviDezurnomVoziluProvider extends BaseProvider<PoziviDezurnomVozilu> {
  PoziviDezurnomVoziluProvider()
      : super("PoziviDezurnomVozilu"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u rezervacija_korak2_screen.dart
  @override
  PoziviDezurnomVozilu fromJson(data) {
    return PoziviDezurnomVozilu.fromJson(data);
  }
}
