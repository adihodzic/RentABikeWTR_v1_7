import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'statusiPregled.g.dart';

@JsonSerializable()
class StatusiPregled {
  int? statusId;
  String? nazivStatusa;

  StatusiPregled() {}

  factory StatusiPregled.fromJson(Map<String, dynamic> json) =>
      _$StatusiPregledFromJson(json);

  /// Connect the generated [_$StatusiPregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$StatusiPregledToJson(this);
}
