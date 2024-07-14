import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'turistRutePregled.g.dart';

@JsonSerializable()
class TuristRutePregled {
  int? turistRutaId;
  String? naziv;
  String? opisRute;
  num? cijenaRute;
  String? slikaRute;

  TuristRutePregled() {}

  factory TuristRutePregled.fromJson(Map<String, dynamic> json) =>
      _$TuristRutePregledFromJson(json);

  /// Connect the generated [_$TuristRuteToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TuristRutePregledToJson(this);
}
