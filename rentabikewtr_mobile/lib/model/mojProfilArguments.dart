import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:rentabikewtr_mobile/model/turistRute.dart';
import 'package:rentabikewtr_mobile/model/turistickiVodici.dart';

import 'bicikli.dart';
import 'korisniciProfil.dart';
import 'kupci.dart';
import 'kupciProfil.dart';

//import 'bicikli.dart';

//part 'screenArguments.g.dart';

//@JsonSerializable()
class MojProfilArguments {
  KorisniciProfil? argumentsKor;
  KupciProfil? argumentsKupci;
  MojProfilArguments(this.argumentsKor, this.argumentsKupci);
}

//   ScreenArguments() {}

//   factory ScreenArguments.fromJson(Map<String, dynamic> json) =>
//       _$BicikliFromJson(json);

//   /// Connect the generated [_$BicikliToJson] function to the `toJson` method.
//   Map<String, dynamic> toJson() => _$BicikliToJson(this);
// }
