import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'proizvodjaciBiciklaPregled.g.dart';

@JsonSerializable()
class ProizvodjaciBiciklaPregled {
  int? proizvodjacBiciklaId;
  String? nazivProizvodjaca;

  ProizvodjaciBiciklaPregled() {}

  factory ProizvodjaciBiciklaPregled.fromJson(Map<String, dynamic> json) =>
      _$ProizvodjaciBiciklaPregledFromJson(json);

  /// Connect the generated [_$ProizvodjaciBiciklaPregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProizvodjaciBiciklaPregledToJson(this);
}
