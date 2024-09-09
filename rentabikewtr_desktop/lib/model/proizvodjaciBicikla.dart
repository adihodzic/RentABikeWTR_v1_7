import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'proizvodjaciBicikla.g.dart';

@JsonSerializable()
class ProizvodjaciBicikla {
  String? nazivProizvodjaca;

  ProizvodjaciBicikla({this.nazivProizvodjaca}) {}

  factory ProizvodjaciBicikla.fromJson(Map<String, dynamic> json) =>
      _$ProizvodjaciBiciklaFromJson(json);

  /// Connect the generated [_$ProizvodjaciBiciklaToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProizvodjaciBiciklaToJson(this);
}
