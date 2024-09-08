import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rentabikewtr_mobile/main.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/widgets/header_widget.dart';
import 'package:rentabikewtr_mobile/widgets/masterVodic_screen.dart';

import 'vodic_najave_odmora_screen.dart';
import 'vodic_poziv_dezurnom_vozilu_screen.dart';

class VodicPocetnaScreen extends StatelessWidget {
  static const String routeName = "/vodic_pocetna";
  final KorisniciProfil argumentsKor;
  final String title = "Vodič portal - Dobro došli";
  const VodicPocetnaScreen({Key? key, required this.argumentsKor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasterVodicScreenWidget(
        argumentsKor: this.argumentsKor,
        // appBar: AppBar(
        //     title: Text("Turistički vodič - trenutna ruta - Dobro došli")),
        child: SingleChildScrollView(
          child: Column(children: [
            HeaderWidget(title: title),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(6, 57, 133, 1),
                            Color.fromRGBO(143, 148, 251, .6)
                          ])),
                      child: InkWell(
                        onTap: () async => Navigator.pushNamed(
                            context, VodicNajaveOdmoraScreen.routeName,
                            arguments: argumentsKor),
                        child: Column(children: [
                          SizedBox(
                            height: 16,
                          ),
                          Icon(Icons.coffee),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Najava odmora",
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                        // child: Center(
                        //     child: Text(
                        //   "Bicikli pregled",
                        //   style: TextStyle(color: Colors.white),
                        // )),
                      ),
                    ),
                  ),
                ),

                // ElevatedButton(
                //     onPressed: () async => Navigator.pushNamed(
                //         context, VodicNajavaOdmoraScreen.routeName,
                //         arguments: argumentsKor),
                //     child: Text("Najava odmora")),
                SizedBox(width: 10),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(6, 57, 133, 1),
                            Color.fromRGBO(143, 148, 251, .6)
                          ])),
                      child: InkWell(
                        onTap: () async => Navigator.pushNamed(
                            context, VodicPozivDezurnomVoziluScreen.routeName,
                            arguments: argumentsKor),
                        child: Column(children: [
                          SizedBox(
                            height: 16,
                          ),
                          Icon(Icons.car_rental),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Dežurno vozilo",
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                        // child: Center(
                        //     child: Text(
                        //   "Bicikli pregled",
                        //   style: TextStyle(color: Colors.white),
                        // )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // ElevatedButton(
            //   onPressed: () async => Navigator.pushNamed(
            //       context, VodicPozivDezurnomVoziluScreen.routeName),
            //   child: Text("Dežurno vozilo"),
            // ),
            SizedBox(height: 40),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 120,
                  height: 120,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(6, 57, 133, 1),
                        Color.fromRGBO(143, 148, 251, .6)
                      ])),
                  child: InkWell(
                    onTap: () async => Navigator.pushNamedAndRemoveUntil(
                        context, HomePage.routeName, (route) => false),
                    child: Column(children: [
                      SizedBox(
                        height: 16,
                      ),
                      Icon(Icons.logout),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Odjava iz aplikacije",
                        style: TextStyle(color: Colors.white),
                      ),
                    ]),
                    // child: Center(
                    //     child: Text(
                    //   "Bicikli pregled",
                    //   style: TextStyle(color: Colors.white),
                    // )),
                  ),
                ),
              ),
            ),
            // ElevatedButton(
            //     child: Text("Odjava iz aplikacije"),
            //     onPressed: () async => Navigator.pushReplacementNamed(
            //         context, HomePage.routeName)),
          ]),
        ));
  }
}
