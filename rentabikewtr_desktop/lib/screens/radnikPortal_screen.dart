import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_biciklo_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_dezurnoVozilo_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_modelBicikla_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_poslovnicu_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_proizvodjacaBicikla_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_rezervniDio_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_servisiranje_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_tipBicikla_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_turistRutu_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_bicikli_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_dezurnaVozila_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_modeliBicikla_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_poslovnice_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_poziviDezurnomVozilu_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_proizvodjaciBicikla_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_rezervniDijelovi_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_servisiranja_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_tipoviBicikla.dart';
import 'package:rentabikewtr_desktop/screens/lista_turistRute_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class RadnikPortalScreen extends StatelessWidget {
  const RadnikPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child:
                  MenuRadnik(), //extract to widget i sada je kao klasa u widget folderu (dart file)
            ),
          ],
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  //constraints: BoxConstraints(maxWidth: 800, maxHeight: 400),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(children: [
                        // Image.network("https://www.fit.ba/content/public/images/og-image.jpg", height: 100, width: 100,),
                        Image.asset(
                          "assets/images/logo.jpg",
                          height: 200,
                          width: 500,
                        ),
                        SizedBox(
                          height: 50,
                        ),

                        Text(
                          "RentABikeWTR -Radnik portal!!!",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(255, 11, 7, 255)),
                        )
                      ]),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,

                  //constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
                  child: Center(
                    child: Card(
                      color: Color.fromARGB(255, 78, 11, 212),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(100, 16, 100, 30),
                        child: Column(children: [
                          Image.asset(
                            "assets/images/logo6.jpg",
                            height: 400,
                            width: 400,
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
