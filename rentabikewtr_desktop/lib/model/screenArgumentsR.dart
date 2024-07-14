import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:rentabikewtr_desktop/model/rezervacijeBiciklDostupni.dart';
//import 'package:rentabikewtr_desktop/model/turistRute.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodici.dart';

import 'bicikliPregled.dart';

//part 'screenArguments.g.dart';

//@JsonSerializable()

class ScreenArgumentsR {
  RezervacijeBiciklDostupni? argumentsB;
  //TuristRute? argumentsTR;
  TuristickiVodici? argumentsTV;
  DateTime? datumPretrage;
  ScreenArgumentsR(this.argumentsB, this.argumentsTV, this.datumPretrage);
}

//   ScreenArgumentsR() {}

//   factory ScreenArguments.fromJson(Map<String, dynamic> json) =>
//       _$BicikliFromJson(json);

//   /// Connect the generated [_$BicikliToJson] function to the `toJson` method.
//   Map<String, dynamic> toJson() => _$BicikliToJson(this);
// }
