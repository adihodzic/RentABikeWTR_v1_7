import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'dezurnaVozilaPregled.g.dart';

@JsonSerializable()
class DezurnaVozilaPregled {
  int? dezurnoVoziloId;
  String? nazivDezurnogVozila;
  String? tipVozila;

  DezurnaVozilaPregled() {}

  factory DezurnaVozilaPregled.fromJson(Map<String, dynamic> json) =>
      _$DezurnaVozilaPregledFromJson(json);

  /// Connect the generated [_$DezurnaVozilaPregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DezurnaVozilaPregledToJson(this);
}
