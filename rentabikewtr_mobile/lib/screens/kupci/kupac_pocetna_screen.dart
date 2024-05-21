import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rentabikewtr_mobile/main.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/model/mojProfilArguments.dart';
import 'package:rentabikewtr_mobile/model/turistickiVodici.dart';
import 'package:rentabikewtr_mobile/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_list_screen.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_mojeRezervacije_screen.dart';

import '../../model/bicikli.dart';
import '../../model/korisnici.dart';
import '../../model/kupci.dart';
//import '../../model/kupciSearch.dart';
//import '../../providers/kupciSearch_provider.dart';
import '../../model/kupciProfil.dart';
import '../../providers/bicikli_provider.dart';
import '../../providers/kupciProfil_provider.dart';
import '../../providers/kupci_provider.dart';
import 'kupac_mojProfil_screen.dart';

class KupacPocetnaScreen extends StatelessWidget {
  static const String routeName = "/kupac_pocetna";
  KupacPocetnaScreen({Key? key, this.argumentsKor}) : super(key: key);
  KorisniciProfil? argumentsKor;
  KupciProfil? argumentsKupci;
  //KupciProfilProvider? _kupciProfilProvider;
  TuristickiVodiciProvider? _vodiciProvider;

  //BicikliProvider? _bicikliProvider;
  //KupciSearchProvider? _kupciSearchProvider;
  MojProfilArguments? argumentsMojProfil;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Kupac - početna stranica-\n Dobro došli")),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 40,
            ),

            Container(
              width: 400,
              height: 50,
              margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(6, 57, 133, 1),
                    Color.fromRGBO(143, 148, 251, .6)
                  ])),
              child: InkWell(
                onTap: () async =>
                    Navigator.pushNamed(context, BicikliListScreen.routeName),
                child: Center(
                    child: Text(
                  "Bicikli pregled",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            // ),
            SizedBox(height: 40),
            Container(
              clipBehavior: Clip.hardEdge,
              width: 400,
              height: 50,
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6)
                  ])),
              // child: ElevatedButton(
              //   onPressed: () async => Navigator.pushNamed(
              //       context, KupacMojProfilScreen.routeName,
              //       arguments: argumentsKor),
              //   child: Text("Moj profil"),
              // ),
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(
                      context, KupacMojProfilScreen.routeName,
                      arguments: argumentsKor);
                },
                child: Text("Moj profil"),
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: 400,
              height: 50,
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6)
                  ])),
              child: ElevatedButton(
                child: Text("Moje rezervacije"),
                onPressed: () async => Navigator.pushNamed(
                    context, KupacMojeRezervacijeScreen.routeName,
                    arguments: argumentsKor),
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: 400,
              height: 50,
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6)
                  ])),
              child: ElevatedButton(
                child: Text("Odjava iz aplikacije"),
                onPressed: () async =>
                    Navigator.pushNamed(context, HomePage.routeName),
              ),
            ),
          ]),
        ));
  }

  // Future<void>? loadKupacArgument() async {
  //   argumentsKupci = await _kupciProfilProvider
  //       ?.getById(argumentsKor!.korisnikId!) as KupciProfil?;
  //   return null;
  // }
}
