import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:rentabikewtr_mobile/model/turistRute.dart';
import 'package:rentabikewtr_mobile/model/turistickiVodici.dart';

import 'bicikli.dart';
import 'turistRute.dart';
import 'turistickiVodici.dart';

//part 'screenArguments.g.dart';

//@JsonSerializable()
class CheckoutTrArguments {
  Bicikli? argumentsBic;
  TuristRute? argumentsTR;
  TuristickiVodici? argumentsTV;
  String? sessionId;

  CheckoutTrArguments(
      this.sessionId, this.argumentsBic, this.argumentsTR, this.argumentsTV);
}

//   ScreenArguments() {}

//   factory ScreenArguments.fromJson(Map<String, dynamic> json) =>
//       _$BicikliFromJson(json);

//   /// Connect the generated [_$BicikliToJson] function to the `toJson` method.
//   Map<String, dynamic> toJson() => _$BicikliToJson(this);
// }
