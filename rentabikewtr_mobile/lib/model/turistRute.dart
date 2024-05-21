import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'turistRute.g.dart';

@JsonSerializable()
class TuristRute {
  int? turistRutaId;
  String? naziv;
  String? opisRute;
  num? cijenaRute;
  String? slikaRute;

  TuristRute() {}

  factory TuristRute.fromJson(Map<String, dynamic> json) =>
      _$TuristRuteFromJson(json);

  /// Connect the generated [_$TuristRuteToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TuristRuteToJson(this);
}
