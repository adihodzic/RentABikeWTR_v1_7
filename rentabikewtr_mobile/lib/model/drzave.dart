import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'drzave.g.dart';

@JsonSerializable()
class Drzave {
  int? drzavaID;
  String? nazivDrzave;

  Drzave() {}

  factory Drzave.fromJson(Map<String, dynamic> json) => _$DrzaveFromJson(json);

  /// Connect the generated [_$DrzaveToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DrzaveToJson(this);
}
