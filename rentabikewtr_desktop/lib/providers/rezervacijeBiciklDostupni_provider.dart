import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/model/rezervacijeBiciklDostupni.dart';
import 'package:rentabikewtr_desktop/model/rezervacijePregled.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';

class RezervacijeBiciklDostupniProvider
    extends BaseProvider<RezervacijeBiciklDostupni> {
  RezervacijeBiciklDostupniProvider()
      : super("Rezervacije/Dostupni"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u bicikli_list_screen.dart
  @override
  RezervacijeBiciklDostupni fromJson(data) {
    return RezervacijeBiciklDostupni.fromJson(data);
  }
}
