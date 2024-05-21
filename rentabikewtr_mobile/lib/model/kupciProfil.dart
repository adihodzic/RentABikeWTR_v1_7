import 'dart:ffi';
//import 'dart:html';

import 'package:json_annotation/json_annotation.dart';

part 'kupciProfil.g.dart';

@JsonSerializable(explicitToJson: true)
class KupciProfil {
  final int kupacId;
  String? adresa;
  String? grad;
  String? brojLKPasosa;

  KupciProfil(
      {required this.kupacId, this.adresa, this.grad, this.brojLKPasosa}) {}

  factory KupciProfil.fromJson(Map<String, dynamic> json) =>
      _$KupciProfilFromJson(json);

  /// Connect the generated [_$KupciToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KupciProfilToJson(this);
}
