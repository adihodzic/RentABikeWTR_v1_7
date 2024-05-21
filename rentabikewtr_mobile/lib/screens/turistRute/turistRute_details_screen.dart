import 'dart:collection';
import 'dart:convert';
//import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/model/detalji.dart';
import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';
import 'package:rentabikewtr_mobile/providers/detalji_provider.dart';
import 'package:rentabikewtr_mobile/providers/turistRute_provider.dart';
import 'package:rentabikewtr_mobile/providers/rezervacije_provider.dart';
import 'package:rentabikewtr_mobile/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
//import 'package:provider/provider.dart';

//import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';

import '../../model/screenArguments.dart';
import '../../model/turistRute.dart';

import '../../model/turistickiVodici.dart';
import '../../utils/util.dart';
import '../../widgets/master_screen.dart';
import '../rezervacije/rezervacija_korak1_screen.dart';
import '../rezervacije/rezervacija_korak3tr_screen.dart';

class TuristRuteDetailsScreen extends StatelessWidget {
  //Bicikli argumentsBic; //-- ako koristimo prosljeđivanje objekta
  ScreenArguments args;

  TuristRuteDetailsScreen({Key? key, required this.args}) : super(key: key);

  static const String routeName = "/turistrute_details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args.argumentsTR!.naziv!), //dva uzvicnika zbog
        //...dva nullable parametra
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                // First child in the Row for the name and the
                // Release date information.
                Expanded(
                  // Name and Release date are in the same column
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Code to create the view for name.
                      Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Original Name: " + args.argumentsTR!.naziv!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Code to create the view for release date.
                      Container(
                        height: 200,
                        width: 100,
                        child:
                            imageFromBase64String(args.argumentsTR!.slikaRute!),
                      ),

                      Center(
                          child: ElevatedButton(
                        child: Text("Rezervacija turist rute"),
                        onPressed: () {
                          Navigator.pushNamed(
                            context, "${RezervacijaKorak3trScreen.routeName}",
                            arguments:
                                args, //Ovdje treba koristiti konstruktor klase,
                            //....ScreenArguments ili koje vec,a ne objekat
                            //...args (koji je tog tipa....razlog je sto
                            //...Konstruktor inicijalizira property-e
                          ); // slanje sa više argumenata
                        },
                      )),
                    ],
                  ),
                ),
                // Icon to indicate the rating.
                new Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
                //new Text('${bic.voteAverage}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
