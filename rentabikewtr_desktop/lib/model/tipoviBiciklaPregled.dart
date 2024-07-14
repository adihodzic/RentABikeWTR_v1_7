import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'tipoviBiciklaPregled.g.dart';

@JsonSerializable()
class TipoviBiciklaPregled {
  int? tipBiciklaId;
  String? nazivTipa;

  TipoviBiciklaPregled() {}

  factory TipoviBiciklaPregled.fromJson(Map<String, dynamic> json) =>
      _$TipoviBiciklaPregledFromJson(json);

  /// Connect the generated [_$TipoviBiciklaPregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TipoviBiciklaPregledToJson(this);
}
