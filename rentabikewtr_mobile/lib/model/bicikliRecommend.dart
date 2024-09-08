import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'bicikliRecommend.g.dart';

@JsonSerializable()
class BicikliRecommend {
  int? biciklId;
  String? nazivBicikla;
  num? cijenaBicikla;
  String? nazivProizvodjaca;
  String? nazivModela;
  String? nazivTipa;
  String? boja;
  String? nazivPoslovnice;
  String? slika;

  BicikliRecommend() {}

  factory BicikliRecommend.fromJson(Map<String, dynamic> json) =>
      _$BicikliRecommendFromJson(json);

  /// Connect the generated [_$BicikliRecommendToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BicikliRecommendToJson(this);
}
