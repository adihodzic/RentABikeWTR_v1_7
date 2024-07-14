import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'tipoviBiciklaDetalji.g.dart';

@JsonSerializable()
class TipoviBiciklaDetalji {
  int? tipBiciklaId;
  String? nazivTipa;

  TipoviBiciklaDetalji({this.tipBiciklaId, this.nazivTipa}) {}

  factory TipoviBiciklaDetalji.fromJson(Map<String, dynamic> json) =>
      _$TipoviBiciklaDetaljiFromJson(json);

  /// Connect the generated [_$TipoviBiciklaDetaljiToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TipoviBiciklaDetaljiToJson(this);
}
