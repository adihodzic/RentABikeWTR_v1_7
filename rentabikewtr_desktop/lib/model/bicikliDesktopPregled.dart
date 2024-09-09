import 'package:json_annotation/json_annotation.dart';

part 'bicikliDesktopPregled.g.dart';

@JsonSerializable()
class BicikliDesktopPregled {
  int? biciklID;
  String? nazivBicikla;
  String? nazivModela;
  String? nazivTipa;
  String? slika;

  BicikliDesktopPregled() {}

  factory BicikliDesktopPregled.fromJson(Map<String, dynamic> json) =>
      _$BicikliDesktopPregledFromJson(json);

  /// Connect the generated [_$BicikliDesktopPregledToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BicikliDesktopPregledToJson(this);
}
