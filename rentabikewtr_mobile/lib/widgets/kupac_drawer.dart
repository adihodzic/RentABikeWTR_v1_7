import 'package:rentabikewtr_mobile/main.dart';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
//import 'package:thirtyfour_app/providers/cart_provider.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_mojProfil_screen.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_mojeRezervacije_screen.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_pocetna_screen.dart';
import 'package:rentabikewtr_mobile/screens/rezervacije/rezervacija_korak1_screen.dart';
import '../providers/bicikli_provider.dart';
import '../screens/bicikli/bicikli_details_screen.dart';

//import '../screens/cart/cart_screen.dart';

class KupacDrawer extends StatelessWidget {
  final KorisniciProfil argumentsKor;
  KupacDrawer({Key? key, required this.argumentsKor}) : super(key: key);
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
            tileColor: Colors.blue,
            title: Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.popAndPushNamed(context, KupacPocetnaScreen.routeName,
                  arguments: argumentsKor);
            },
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text('Bicikli lista', style: TextStyle(color: Colors.blue)),
            onTap: () {
              Navigator.popAndPushNamed(context, BicikliListScreen.routeName,
                  arguments: argumentsKor);
            },
          ),
          ListTile(
            tileColor: Colors.blue,
            title:
                Text('Moje rezervacije', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.popAndPushNamed(
                  context, KupacMojeRezervacijeScreen.routeName,
                  arguments: argumentsKor);
            },
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text('Moj profil', style: TextStyle(color: Colors.blue)),
            onTap: () {
              Navigator.popAndPushNamed(context, KupacMojProfilScreen.routeName,
                  arguments: argumentsKor);
            },
          ),
          ListTile(
            tileColor: Colors.blue,
            title: Text('Odjava', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomePage.routeName, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
