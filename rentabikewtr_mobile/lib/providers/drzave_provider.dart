import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

import '../model/drzave.dart';

class DrzaveProvider extends BaseProvider<Drzave> {
  DrzaveProvider() : super("DrzaveMobilna"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u bicikli_list_screen.dart
  @override
  Drzave fromJson(data) {
    return Drzave.fromJson(data);
  }
}
