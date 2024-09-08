import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'poruke.g.dart';

@JsonSerializable()
class Poruke {
  String? tekst;
  DateTime? datumPoruke = DateTime.now();
  int? korisnikID;

  Poruke({
    this.tekst,
    this.datumPoruke,
    this.korisnikID,
  }) {}

  factory Poruke.fromJson(Map<String, dynamic> json) => _$PorukeFromJson(json);

  /// Connect the generated [_$PorukeToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PorukeToJson(this);
}
