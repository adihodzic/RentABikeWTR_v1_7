import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'lokacijeOdmora.g.dart';

@JsonSerializable()
class LokacijeOdmora {
  int? lokacijaOdmoraId;
  String? naziv;
  String? opis;

  LokacijeOdmora() {}

  factory LokacijeOdmora.fromJson(Map<String, dynamic> json) =>
      _$LokacijeOdmoraFromJson(json);

  /// Connect the generated [_$LokacijeOdmoraToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LokacijeOdmoraToJson(this);
}
