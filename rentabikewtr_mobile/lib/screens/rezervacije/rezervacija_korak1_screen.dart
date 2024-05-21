import 'package:rentabikewtr_mobile/model/rezervacije.dart';
import 'package:rentabikewtr_mobile/providers/rezervacije_provider.dart';
import 'package:rentabikewtr_mobile/screens/rezervacije/rezervacija_korak3tr_screen.dart';
import 'package:rentabikewtr_mobile/screens/rezervacije/rezervacija_korak3bic_screen.dart';
//import 'package:rentabikewtr_mobile/widgets/eprodaja_drawer.dart';
import 'package:rentabikewtr_mobile/widgets/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../model/bicikli.dart';
import '../../providers/rezervacije_provider.dart';
import '../../utils/util.dart';
import '../turistRute/turistRute_list_screen.dart';

class RezervacijaKorak1Screen extends StatelessWidget {
  //final int biciklId;
  Bicikli argumentsBic; //ako bi htio vise argumenata poslati onda koristim
  //...klasu npr. ScreenArguments.... Onda nju kasnije pozovem ...pogledati primjer
  RezervacijaKorak1Screen({Key? key, required this.argumentsBic})
      : super(key: key);
  static const String routeName = "/rezervacije_bicikli";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rezervacija bicikla')),
      body: ListView(
        //ovo sam stavio umjesto kolone da imam ljepsi izgled
        //...tacnije da se ne zalijepe dugmad za dno ekrana...
        children: [
          _buildProductCardList(),
          _buildBuyButton(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: imageFromBase64String(argumentsBic.slika!),
                ),
                SizedBox(height: 20.0),
                Text(
                  argumentsBic.nazivBicikla!,
                  textAlign: TextAlign.end,
                ),
                ElevatedButton(
                  child: Text('Izvrsi rezervaciju bicikla'),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "${RezervacijaKorak3bicScreen.routeName}",
                      arguments: argumentsBic,
                    );
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  child: Text('Rezervacija bicikla i turist rute'),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "${TuristRuteListScreen.routeName}",
                      arguments: argumentsBic,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_buildBuyButton() {
  return Column();
}

_buildProductCardList() {
  return Column();
}
