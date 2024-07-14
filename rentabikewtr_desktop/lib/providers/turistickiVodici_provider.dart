import 'package:rentabikewtr_desktop/model/turistickiVodiciUpsert.dart';
import 'package:rentabikewtr_desktop/providers/base_provider.dart';

import '../model/turistickiVodici.dart';

class TuristickiVodiciProvider extends BaseProvider<TuristickiVodiciUpsert> {
  TuristickiVodiciProvider() : super("TuristickiVodici"); //ako promijenim
  //...ovaj key onda moram promijeniti i rutu u rezervacija_korak2_screen.dart
  @override
  TuristickiVodiciUpsert fromJson(data) {
    return TuristickiVodiciUpsert.fromJson(data);
  }
}
