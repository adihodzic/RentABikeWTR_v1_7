import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'velicineBiciklaPregled.g.dart';

@JsonSerializable()
class VelicineBiciklaPregled {
  int? velicinaBiciklaId;
  String? nazivVelicine;

  VelicineBiciklaPregled() {}

  factory VelicineBiciklaPregled.fromJson(Map<String, dynamic> json) =>
      _$VelicineBiciklaPregledFromJson(json);

  /// Connect the generated [_$VelicineBiciklaPregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$VelicineBiciklaPregledToJson(this);
}
