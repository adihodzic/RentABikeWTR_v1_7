import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rentabikewtr_mobile/model/checkoutArguments.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/model/rezervacije.dart';
import 'package:rentabikewtr_mobile/providers/rezervacije_provider.dart';
import 'package:rentabikewtr_mobile/widgets/header_widget.dart';
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
  String title = "Rezervacija bicikla-plaćanje";
  //String cijena = argumentsBiciklo.cijenaBicikla.toString();
  final TextEditingController _cijenaUslugeController = TextEditingController();
  Bicikli argumentsBiciklo;
  KorisniciProfil argumentsKorisnik;
  DateTime argumentsDate;
  //Rezervacije rez = Rezervacije();
  double cijenaUsluge = 10.0;
  DateTime datumIzdavanja = DateTime.now();
  SesijaProvider? _sesijaProvider = null;
  String? sesijaId;
  Future<String>? s;

  late RezervacijeProvider _rezervacijeProvider;

  RezervacijaKorak3bicScreen(
      {Key? key,
      required this.argumentsBiciklo,
      required this.argumentsKorisnik,
      required this.argumentsDate})
      : super(key: key);
  static const String routeName = "/rezervacijebic_placanje";

  Future<String> makeRequest() async {
    var url = Uri.parse(
        'https://10.0.2.2:44335/api/Sesija?nazivBicikla=${argumentsBiciklo.nazivBicikla}&cijenaBicikla=${argumentsBiciklo.cijenaBicikla}');

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
    return MasterScreenWidget(
      argumentsKor: argumentsKorisnik,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          HeaderWidget(title: title),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      //Container je bio ili SizedBox
                      height: 100, //bio je height
                      width: 150, //bio je width i kasnije 100

                      child: imageFromBase64String(argumentsBiciklo.slika!)),
                ),
                //ovo je bilo prije x.slika!
              ),
              ////////////////////////////////////////////

              // // Code to create the view for name.
              // Container(
              //   padding: const EdgeInsets.only(bottom: 8.0),
              //   child: Text(
              //     argumentsBiciklo.nazivBicikla!,
              //     style: TextStyle(
              //       fontWeight: FontWeight.normal,
              //     ),
              //   ),
              // ),
              // // Code to create the view for release date.
              // Container(
              //   height: 200,
              //   width: 200,
              //   child: imageFromBase64String(argumentsBiciklo.slika!),
              // ),
              Text(argumentsBiciklo.nazivBicikla!),
              // //Text("Datum preuzimanja: " + rez.datumIzdavanja!.day.toString()),
              // Text("Datum preuzimanja: " + datumIzdavanja.day.toString()),
              // Text("Cijena usluge: " + cijenaUsluge.toString()),

              // Container(),
              SizedBox(
                height: 50,
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue:
                        DateFormat('dd-MM-yyyy').format(argumentsDate),
                    readOnly: true,
                    //controller: _datumPreuzimanjaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Datum preuzimanja",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: '',
                      suffixIcon: Icon(Icons.calendar_view_day),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
///////////////////////////////////////////////////////////////////////////////////////
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: argumentsBiciklo.cijenaBicikla.toString(),
                    readOnly: true,
                    //controller: _cijenaUslugeController(text:argumentsBiciklo.cijenaBicikla),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Cijena",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: '',
                      suffixIcon: Icon(Icons.price_change),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
///////////////////////////////////////////////////////////////////////////
              ///
              ///
              ///
              Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //color: Color.fromRGBO(143, 148, 251, .6),
                      color: Color.fromARGB(233, 120, 180, 229),

                      child: Padding(
                        padding: const EdgeInsets.all(20.0), //prosiren inkWell
                        child: InkWell(
                          child: Center(
                              child: Text("Izvrši plaćanje",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          onTap: () async {
                            try {
                              await makeRequest();
                              Navigator.pushNamed(
                                context,
                                "${CheckoutPage.routeName}", //moram prepraviti
                                arguments: CheckoutArguments(
                                    sesijaId,
                                    argumentsBiciklo,
                                    argumentsKorisnik,
                                    argumentsDate),
                              );
                            } catch (e) {
                              throw Exception("Došlo je do greške");
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              ///
              ///
              ///
              Container(
                padding: EdgeInsets.all(2),
                child: Center(
                    child: InkWell(
                  child: Center(
                      child: Text("Izvrši plaćanje",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                  onTap: () async {
                    try {
                      await makeRequest();
                      Navigator.pushNamed(
                        context,
                        "${CheckoutPage.routeName}", //moram prepraviti
                        arguments: CheckoutArguments(sesijaId, argumentsBiciklo,
                            argumentsKorisnik, argumentsDate),
                      );
                    } catch (e) {
                      throw Exception("Došlo je do greške");
                    }
                  },
                )),
              ),
            ],
          ),
          //Icon to indicate the rating.
          // new Icon(
          //   Icons.star,
          //   color: Colors.red[500],
          // ),
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
