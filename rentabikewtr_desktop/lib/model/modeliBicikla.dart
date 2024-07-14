import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'modeliBicikla.g.dart';

@JsonSerializable()
class ModeliBicikla {
  String? nazivModela;

  ModeliBicikla({this.nazivModela}) {}

  factory ModeliBicikla.fromJson(Map<String, dynamic> json) =>
      _$ModeliBiciklaFromJson(json);

  /// Connect the generated [_$ModeliBiciklaToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ModeliBiciklaToJson(this);
}
