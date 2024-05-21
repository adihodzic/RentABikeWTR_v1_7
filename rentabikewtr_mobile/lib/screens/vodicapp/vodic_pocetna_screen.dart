import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rentabikewtr_mobile/main.dart';

import 'vodic_najava_odmora_screen.dart';
import 'vodic_poziv_dezurnom_vozilu_screen.dart';

class VodicPocetnaScreen extends StatelessWidget {
  static const String routeName = "/vodic_pocetna";
  const VodicPocetnaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Turistički vodič - trenutna ruta - Dobro došli")),
        body: Center(
          child: Column(children: [
            ElevatedButton(
                onPressed: () async => Navigator.pushNamed(
                    context, VodicNajavaOdmoraScreen.routeName),
                child: Text("Najava odmora")),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async => Navigator.pushNamed(
                  context, VodicPozivDezurnomVoziluScreen.routeName),
              child: Text("Dežurno vozilo"),
            ),
            ElevatedButton(
                child: Text("Odjava iz aplikacije"),
                onPressed: () async => Navigator.pushReplacementNamed(
                    context, HomePage.routeName)),
          ]),
        ));
  }
}
