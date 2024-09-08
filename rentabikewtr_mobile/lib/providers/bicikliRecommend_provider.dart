import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/model/bicikliRecommend.dart';
import 'package:rentabikewtr_mobile/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class BicikliRecommendProvider extends BaseProvider<BicikliRecommend> {
  BicikliRecommendProvider() : super("BicikliMobilna"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u bicikli_list_screen.dart
  @override
  BicikliRecommend fromJson(data) {
    return BicikliRecommend.fromJson(data);
  }
}
