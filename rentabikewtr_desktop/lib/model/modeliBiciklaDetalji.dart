import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'modeliBiciklaDetalji.g.dart';

@JsonSerializable()
class ModeliBiciklaDetalji {
  int? modelBiciklaId;
  String? nazivModela;

  ModeliBiciklaDetalji({this.modelBiciklaId, this.nazivModela}) {}

  factory ModeliBiciklaDetalji.fromJson(Map<String, dynamic> json) =>
      _$ModeliBiciklaDetaljiFromJson(json);

  /// Connect the generated [_$ModeliBiciklaDetaljiToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ModeliBiciklaDetaljiToJson(this);
}
