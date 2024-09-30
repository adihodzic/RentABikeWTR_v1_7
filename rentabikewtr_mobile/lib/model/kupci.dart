import 'dart:ffi';
//import 'dart:html';

import 'package:json_annotation/json_annotation.dart';

part 'kupci.g.dart';

@JsonSerializable(explicitToJson: true)
class Kupci {
  int? kupacId;
  String? adresa;
  String? grad;
  String? brojLKPasosa;
  String? spol;
  int? godineKupacID;

  Kupci(
      {this.kupacId,
      this.adresa,
      this.grad,
      this.brojLKPasosa,
      this.spol,
      this.godineKupacID}) {}

  factory Kupci.fromJson(Map<String, dynamic> json) => _$KupciFromJson(json);

  /// Connect the generated [_$KupciToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$KupciToJson(this);
}
