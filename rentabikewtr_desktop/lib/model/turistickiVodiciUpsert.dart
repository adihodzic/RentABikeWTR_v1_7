import 'dart:ffi';
//import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'turistickiVodiciUpsert.g.dart';

@JsonSerializable()
class TuristickiVodiciUpsert {
  int? turistickiVodicId;
  String? naziv;
  String? jezik;
  num? cijenaVodica;

  TuristickiVodiciUpsert(
      {this.turistickiVodicId, this.naziv, this.jezik, this.cijenaVodica}) {}

  factory TuristickiVodiciUpsert.fromJson(Map<String, dynamic> json) =>
      _$TuristickiVodiciUpsertFromJson(json);

  /// Connect the generated [_$TuristickiVodiciUpsertToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TuristickiVodiciUpsertToJson(this);
}
