import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'tipoviBicikla.g.dart';

@JsonSerializable()
class TipoviBicikla {
  String? nazivTipa;

  TipoviBicikla({this.nazivTipa}) {}

  factory TipoviBicikla.fromJson(Map<String, dynamic> json) =>
      _$TipoviBiciklaFromJson(json);

  /// Connect the generated [_$TipoviBiciklaToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TipoviBiciklaToJson(this);
}
