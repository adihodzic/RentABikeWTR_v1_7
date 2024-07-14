import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'dezurnaVozila.g.dart';

@JsonSerializable()
class DezurnaVozila {
  String? nazivDezurnogVozila;
  String? tipVozila;

  DezurnaVozila({this.nazivDezurnogVozila, this.tipVozila}) {}

  factory DezurnaVozila.fromJson(Map<String, dynamic> json) =>
      _$DezurnaVozilaFromJson(json);

  /// Connect the generated [_$DezurnaVozilaToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DezurnaVozilaToJson(this);
}
