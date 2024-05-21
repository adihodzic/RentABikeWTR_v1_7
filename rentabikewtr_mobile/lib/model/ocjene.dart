import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'ocjene.g.dart';

@JsonSerializable()
class Ocjene {
  int? ocjena;
  DateTime? datumOcjene = DateTime.now();
  int? biciklID;
  int? kupacID;
  //String? slika;

  Ocjene({this.ocjena, this.datumOcjene, this.biciklID, this.kupacID}) {}

  factory Ocjene.fromJson(Map<String, dynamic> json) => _$OcjeneFromJson(json);

  /// Connect the generated [_$BicikliToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OcjeneToJson(this);
}
