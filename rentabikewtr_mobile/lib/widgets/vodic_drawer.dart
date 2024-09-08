import 'package:rentabikewtr_mobile/main.dart';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/model/poziviDezurnomVozilu.dart';
import 'package:rentabikewtr_mobile/model/turistickiVodici.dart';
import 'package:rentabikewtr_mobile/providers/turistickiVodici_provider.dart';
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
import 'package:rentabikewtr_mobile/screens/vodicapp/vodic_najave_odmora_screen.dart';
import 'package:rentabikewtr_mobile/screens/vodicapp/vodic_pocetna_screen.dart';
import 'package:rentabikewtr_mobile/screens/vodicapp/vodic_poziv_dezurnom_vozilu_screen.dart';
import '../providers/bicikli_provider.dart';
import '../screens/bicikli/bicikli_details_screen.dart';

//import '../screens/cart/cart_screen.dart';

class VodicDrawer extends StatelessWidget {
  // final TuristickiVodici argumentsTV;
  final KorisniciProfil argumentsKor;
  VodicDrawer({Key? key, required this.argumentsKor}) : super(key: key);
  TuristickiVodici vod = TuristickiVodici();

  //BicikliDrawer();
  TuristickiVodiciProvider? _turistickiVodiciProvider;

  //CartProvider? _cartProvider;
  //Bicikli bic;
  @override
  Widget build(BuildContext context) {
    //_cartProvider = context.watch<CartProvider>();
    _turistickiVodiciProvider = context.watch<TuristickiVodiciProvider>();
    print("called build drawer");
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            tileColor: Colors.blue,
            title: Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.popAndPushNamed(context, VodicPocetnaScreen.routeName,
                  arguments: argumentsKor);
            },
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text('Najava odmora', style: TextStyle(color: Colors.blue)),
            onTap: () {
              Navigator.popAndPushNamed(
                  context, VodicNajaveOdmoraScreen.routeName,
                  arguments: argumentsKor);
            },
          ),
          ListTile(
            tileColor: Colors.blue,
            title:
                Text('Dežurno vozilo', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.popAndPushNamed(
                  context, VodicPozivDezurnomVoziluScreen.routeName,
                  arguments: argumentsKor);
            },
          ),
          ListTile(
            tileColor: Colors.white,
            title: Text('Odjava', style: TextStyle(color: Colors.blue)),
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
