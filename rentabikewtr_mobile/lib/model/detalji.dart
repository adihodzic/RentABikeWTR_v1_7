//import 'package:Thirtysix_app/lib/model/bicikli.dart';

import 'bicikli.dart';

class Detalji {
  List<DetaljiItem> items = [];
}

class DetaljiItem {
  DetaljiItem(this.bicikli, this.count);
  late Bicikli bicikli;
  late int count;
}
