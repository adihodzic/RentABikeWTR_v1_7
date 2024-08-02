import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rentabikewtr_mobile/model/checkoutArguments.dart';
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
import '../../providers/rezervacije_provider.dart';
import '../../providers/sesija_provider.dart';
import '../../utils/util.dart';
import 'checkout_page.dart';

class RezervacijaKorak3bicScreen extends StatelessWidget {
  Bicikli argumentsBic;
  //Rezervacije rez = Rezervacije();
  double cijenaUsluge = 10.0;
  DateTime datumIzdavanja = DateTime.now();
  SesijaProvider? _sesijaProvider = null;
  String? sesijaId;
  Future<String>? s;

  late RezervacijeProvider _rezervacijeProvider;

  RezervacijaKorak3bicScreen({Key? key, required this.argumentsBic})
      : super(key: key);
  static const String routeName = "/rezervacijebic_placanje";

  Future<String> makeRequest() async {
    var url = Uri.parse(
        'https://10.0.2.2:44335/api/Sesija?nazivBicikla=${argumentsBic.nazivBicikla}');

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
        title: Text('Rezervacija bicikla-placanje'),
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
                    "Original Name: " + argumentsBic.nazivBicikla!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Code to create the view for release date.
                Container(
                  height: 200,
                  width: 200,
                  child: imageFromBase64String(argumentsBic.slika!),
                ),
                Text("Naziv bicikla: " + argumentsBic.nazivBicikla!),
                //Text("Datum preuzimanja: " + rez.datumIzdavanja!.day.toString()),
                Text("Datum preuzimanja: " + datumIzdavanja.day.toString()),
                Text("Cijena usluge: " + cijenaUsluge.toString()),

                Container(),

                Container(
                  padding: EdgeInsets.all(2),
                  child: Center(
                      child: ElevatedButton(
                    child: Text("Izvrši plaćanje"),
                    onPressed: () async {
                      await makeRequest();
                      Navigator.pushNamed(
                        context,
                        "${CheckoutPage.routeName}", //moram prepraviti
                        arguments: CheckoutArguments(sesijaId, argumentsBic),
                      );
                    },
                  )),
                ),
              ],
            ),
          ),
          //Icon to indicate the rating.
          new Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          //       //new Text('${bic.voteAverage}'),
        ],
      ),
    );
    // ],
    // ));
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
