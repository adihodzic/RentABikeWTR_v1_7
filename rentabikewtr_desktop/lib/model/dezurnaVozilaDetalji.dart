import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'dezurnaVozilaDetalji.g.dart';

@JsonSerializable()
class DezurnaVozilaDetalji {
  int? dezurnoVoziloId;
  String? nazivDezurnogVozila;
  String? tipVozila;

  DezurnaVozilaDetalji(
      this.dezurnoVoziloId, this.nazivDezurnogVozila, this.tipVozila) {}

  factory DezurnaVozilaDetalji.fromJson(Map<String, dynamic> json) =>
      _$DezurnaVozilaDetaljiFromJson(json);

  /// Connect the generated [_$DezurnaVozilaDetaljiToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DezurnaVozilaDetaljiToJson(this);
}
