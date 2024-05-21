import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rentabikewtr_mobile/model/checkoutArguments.dart';
import 'package:rentabikewtr_mobile/model/checkoutTrArguments.dart';
import 'package:rentabikewtr_mobile/model/rezervacije.dart';
import 'package:rentabikewtr_mobile/providers/rezervacije_provider.dart';
//import 'package:rentabikewtr_mobile/widgets/eprodaja_drawer.dart';
import 'package:rentabikewtr_mobile/widgets/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../model/bicikli.dart';
import '../../model/screenArguments.dart';
import '../../model/turistRute.dart';
import '../../model/turistickiVodici.dart';
import '../../providers/rezervacije_provider.dart';
import '../../providers/sesija_provider.dart';
import '../../utils/util.dart';
import 'checkout_tr_page.dart';

class RezervacijaKorak3trScreen extends StatelessWidget {
  final ScreenArguments args;
  //Rezervacije rez = Rezervacije();
  double cijenaUsluge = 30.0;
  DateTime datumIzdavanja = DateTime.now();
  SesijaProvider? _sesijaProvider = null;
  String? sesijaId;
  Future<String>? s;

  late RezervacijeProvider _rezervacijeProvider;

  RezervacijaKorak3trScreen({Key? key, required this.args}) : super(key: key);

  static const String routeName = "/rezervacijetr_placanje";

  Future<String> makeRequest() async {
    var url = Uri.parse(
        'https://10.0.2.2:7140/api/Sesija/xSesija?nazivBicikla=${args.argumentsBic!.nazivBicikla}&nazivRute=${args.argumentsTR!.naziv}&jezikVodica=${args.argumentsTV!.jezik}');

    var headers = {
      'accept': 'text/plain',
      'Content-Type': 'application/json',
    };

    var body = {
      'sessionId': 'string',
      'publishableKey': 'string',
    };

    var response =
        await http.post(url, headers: headers, body: json.encode(body));

    // Handle the response
    if (response.statusCode == 200) {
      print(response.body);
      sesijaId = response.body;
      return "Success"; // ovo je fazon jer mora biti nesto vraceno da bude async funkcija
      //zbog onPressed property-ja jer onda nece preskociti funkciju i uraditi navigaciju
      //nego ce sacekati da zavrsi funckija da se await-a....(zato funkcija ne moze biti void)
    } else {
      print('API call failed with status code: ${response.statusCode}');
      throw Exception("Greška");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rezervacija turist rute-placanje'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(32.0),
            // Name and Release date are in the same column
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Code to create the view for name.
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Original Name: " + args.argumentsBic!.nazivBicikla!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Code to create the view for release date.
                Container(
                  height: 200,
                  width: 200,
                  child: imageFromBase64String(args.argumentsBic!.slika!),
                ),
                Text("Naziv bicikla: " + args.argumentsBic!.nazivBicikla!),
                //Text("Datum preuzimanja: " + rez.datumIzdavanja!.day.toString()),
                Text("Datum usluge: " + datumIzdavanja.day.toString()),
                //Text("Cijena usluge (Bicikl): " + cijenaUsluge.toString()),
                //////////Turist ruta  //////////////////////////////
                Container(
                  height: 200,
                  width: 200,
                  child: imageFromBase64String(args.argumentsTR!.slikaRute!),
                ),
                Text("Naziv rute: " + args.argumentsTR!.naziv!),
                //Text("Datum preuzimanja: " + rez.datumIzdavanja!.day.toString()),
                Text("Turistički vodič: ${args.argumentsTV!.naziv}"),
                Text("Cijena usluge: " + cijenaUsluge.toString()),

                SizedBox(height: 30),
                Center(),
                Center(
                    child: ElevatedButton(
                  child: Text("Izvrši plaćanje"),
                  onPressed: () async {
                    await makeRequest();
                    Navigator.pushNamed(context,
                        "${CheckoutTrPage.routeName}", //moram prepraviti
                        arguments: CheckoutTrArguments(
                            sesijaId,
                            args.argumentsBic,
                            args.argumentsTR,
                            args.argumentsTV)); //bila je sesijaId
                  }, //moram prepraviti
                  //arguments: args.argumentsBic);
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
    );
    // new Container(
    //     padding: const EdgeInsets.all(32.0),
    //     child: new Text(movie.overview,
    //       softWrap: true,
    //     )
    //)
  }
}

_buildBuyButton() {
  return Column();
}

_buildProductCardList() {
  return Column();
}
