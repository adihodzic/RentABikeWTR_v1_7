import 'package:rentabikewtr_desktop/model/turistickiVodiciUpsert.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';

import '../model/turistickiVodici.dart';

class TuristickiVodiciPregledProvider extends BaseProvider<TuristickiVodici> {
  TuristickiVodiciPregledProvider()
      : super("TuristickiVodici"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u rezervacija_korak2_screen.dart
  @override
  TuristickiVodici fromJson(data) {
    return TuristickiVodici.fromJson(data);
  }
}
