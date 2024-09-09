import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_desktop/model/bicikliDesktopPregled.dart';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class BicikliDesktopPregledProvider
    extends BaseProvider<BicikliDesktopPregled> {
  BicikliDesktopPregledProvider()
      : super("BicikliMobilna/PretragaBicikli"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u bicikli_list_screen.dart
  @override
  BicikliDesktopPregled fromJson(data) {
    return BicikliDesktopPregled.fromJson(data);
  }
}
