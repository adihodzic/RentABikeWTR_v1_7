import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:rentabikewtr_desktop/model/xRezervacije.dart';

part 'xRezervacijeResult.g.dart';

@JsonSerializable()
class XRezervacijeResult {
  num? ukupnaSuma;
  List<XRezervacije>? xRezervacijeLista;

  // int? turistickiVodicID;
  // int? turistRutaID;

  XRezervacijeResult() {}

  factory XRezervacijeResult.fromJson(Map<String, dynamic> json) =>
      _$XRezervacijeResultFromJson(json);

  /// Connect the generated [_$XRezervacijeResultToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$XRezervacijeResultToJson(this);
}
