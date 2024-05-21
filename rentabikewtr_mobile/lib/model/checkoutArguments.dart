import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:rentabikewtr_mobile/model/turistRute.dart';
import 'package:rentabikewtr_mobile/model/turistickiVodici.dart';

import 'bicikli.dart';

//part 'screenArguments.g.dart';

//@JsonSerializable()
class CheckoutArguments {
  Bicikli? argumentsBic;
  String? sessionId;

  CheckoutArguments(this.sessionId, this.argumentsBic);
}

//   ScreenArguments() {}

//   factory ScreenArguments.fromJson(Map<String, dynamic> json) =>
//       _$BicikliFromJson(json);

//   /// Connect the generated [_$BicikliToJson] function to the `toJson` method.
//   Map<String, dynamic> toJson() => _$BicikliToJson(this);
// }
