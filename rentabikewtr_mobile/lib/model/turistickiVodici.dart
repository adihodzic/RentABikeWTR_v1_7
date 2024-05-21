import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'turistickiVodici.g.dart';

@JsonSerializable()
class TuristickiVodici {
  int? turistickiVodicId;
  // String? korisnickoIme;
  String? naziv;
  String? jezik;
  num? cijenaVodica;

  TuristickiVodici() {}

  factory TuristickiVodici.fromJson(Map<String, dynamic> json) =>
      _$TuristickiVodiciFromJson(json);

  /// Connect the generated [_$TuristickiVodiciToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TuristickiVodiciToJson(this);
}
