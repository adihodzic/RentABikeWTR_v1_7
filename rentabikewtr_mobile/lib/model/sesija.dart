//import 'dart:ffi';

import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sesija.g.dart';

@JsonSerializable()
class Sesija {
  String? sessionId;

  Sesija({required this.sessionId});
  //ovo je konstruktor iz primjera Albumi
//const Album({required this.id, required this.title});
  factory Sesija.fromJson(Map<String, dynamic> json) => _$SesijaFromJson(json);

  /// Connect the generated [_$SesijaToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SesijaToJson(this);
}
