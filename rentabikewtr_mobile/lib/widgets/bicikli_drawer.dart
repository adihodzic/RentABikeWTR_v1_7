import 'package:rentabikewtr_mobile/model/bicikli.dart';
//import 'package:thirtyfour_app/providers/cart_provider.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_mobile/screens/rezervacije/rezervacija_korak1_screen.dart';
import '../providers/bicikli_provider.dart';
import '../screens/bicikli/bicikli_details_screen.dart';

//import '../screens/cart/cart_screen.dart';

class BicikliDrawer extends StatelessWidget {
  BicikliDrawer({Key? key}) : super(key: key);
  Bicikli bic = Bicikli();
  //BicikliDrawer();
  BicikliProvider? _bicikliProvider;

  //CartProvider? _cartProvider;
  //Bicikli bic;
  @override
  Widget build(BuildContext context) {
    //_cartProvider = context.watch<CartProvider>();
    _bicikliProvider = context.watch<BicikliProvider>();
    print("called build drawer");
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.popAndPushNamed(
                  context, BicikliDetailsScreen.routeName);
            },
          ),
          ListTile(
            title: Text('Bicikli_detalji'),
            onTap: () {
              Navigator.popAndPushNamed(
                  context, RezervacijaKorak1Screen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
