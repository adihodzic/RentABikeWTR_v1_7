import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'kategorijeDijelovaPregled.g.dart';

@JsonSerializable()
class KategorijeDijelovaPregled {
  int? kategorijaDijelovaId;
  String? nazivKategorije;

  KategorijeDijelovaPregled() {}

  factory KategorijeDijelovaPregled.fromJson(Map<String, dynamic> json) =>
      _$KategorijeDijelovaPregledFromJson(json);

  /// Connect the generated [_$KategorijeDijelovaPregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KategorijeDijelovaPregledToJson(this);
}
