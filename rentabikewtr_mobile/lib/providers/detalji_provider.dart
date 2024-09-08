import 'package:collection/collection.dart';

import 'package:flutter/widgets.dart';

import '../model/bicikli.dart';
import '../model/detalji.dart';

class DetaljiProvider with ChangeNotifier {
  Detalji detalji = Detalji();
  addToCart(Bicikli bicikli) {
    if (findInCart(bicikli) != null) {
      findInCart(bicikli)?.count++;
    } else {
      detalji.items.add(DetaljiItem(bicikli, 1));
    }

    notifyListeners();
  }

  // removeFromCart(Product product) {
  //   cart.items.removeWhere((item) => item.product.proizvodId == product.proizvodId);
  //   notifyListeners();
  // }

  DetaljiItem? findInCart(Bicikli bicikli) {
    DetaljiItem? item = detalji.items
        .firstWhereOrNull((item) => item.bicikli.biciklID == bicikli.biciklID);
    return item;
  }
}
