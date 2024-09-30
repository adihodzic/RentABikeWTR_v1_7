import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'godineKupci.g.dart';

@JsonSerializable()
class GodineKupci {
  int? godineKupacId;
  String? godinePoGrupama;

  GodineKupci() {}

  factory GodineKupci.fromJson(Map<String, dynamic> json) =>
      _$GodineKupciFromJson(json);

  /// Connect the generated [_$GodineKupciToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GodineKupciToJson(this);
}
