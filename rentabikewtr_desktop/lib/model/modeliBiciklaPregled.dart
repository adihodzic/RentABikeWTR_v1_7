import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'modeliBiciklaPregled.g.dart';

@JsonSerializable()
class ModeliBiciklaPregled {
  int? modelBiciklaId;
  String? nazivModela;

  ModeliBiciklaPregled() {}

  factory ModeliBiciklaPregled.fromJson(Map<String, dynamic> json) =>
      _$ModeliBiciklaPregledFromJson(json);

  /// Connect the generated [_$ModeliBiciklaPregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ModeliBiciklaPregledToJson(this);
}
