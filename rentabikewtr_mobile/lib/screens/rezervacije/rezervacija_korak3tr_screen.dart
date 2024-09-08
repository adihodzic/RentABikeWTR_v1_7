import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rentabikewtr_mobile/model/checkoutArguments.dart';
import 'package:rentabikewtr_mobile/model/checkoutTrArguments.dart';
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
import '../../model/screenArguments.dart';
import '../../model/turistRute.dart';
import '../../model/turistickiVodici.dart';
import '../../providers/rezervacije_provider.dart';
import '../../providers/sesija_provider.dart';
import '../../utils/util.dart';
import 'checkout_tr_page.dart';

class RezervacijaKorak3trScreen extends StatefulWidget {
  final ScreenArguments arguments;
  // final Bicikli argumentsBic;
  // final KorisniciProfil argumentsKor;
  // final TuristRute argumentsTR;
  // final TuristickiVodici argumentsTV;

  RezervacijaKorak3trScreen({Key? key, required this.arguments})
      // required this.argumentsBic,
      // required this.argumentsKor,
      // required this.argumentsTR,
      // required this.argumentsTV})
      : super(key: key);

  static const String routeName = "/rezervacijetr_placanje";

  @override
  State<RezervacijaKorak3trScreen> createState() =>
      _RezervacijaKorak3trScreenState();
}

class _RezervacijaKorak3trScreenState extends State<RezervacijaKorak3trScreen> {
  String title = 'Rezervacija turist rute-placanje';
  //ScreenArguments? arguments;
  TuristRute? argumentsTR;

  TuristickiVodici? argumentsTV;

  //Rezervacije rez = Rezervacije();

  double cijenaUsluge = 0.0;

  DateTime datumIzdavanja = DateTime.now();

  SesijaProvider? _sesijaProvider = null;

  String? sesijaId;

  Future<String>? s;

  late RezervacijeProvider _rezervacijeProvider;

  Future<String> makeRequest() async {
    var url = Uri.parse(
        'http://10.0.2.2:44335/api/Sesija/xSesija?nazivBicikla=${widget.arguments!.argumentsBic!.nazivBicikla!}&nazivRute=${widget.arguments!.argumentsTR!.naziv}&jezikVodica=${widget.arguments!.argumentsTV!.jezik}&cijenaUsluge=$cijenaUsluge');

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
  void initState() {
    //_formKey = GlobalKey();

    // _drzaveProvider = context.read<DrzaveProvider>();
    // _turistickiVodiciPregledProvider =
    //     context.read<TuristickiVodiciPregledProvider>();
    // _turistRutePregledProvider = context.read<TuristRutePregledProvider>();
    // _korisniciPregledProvider = context.read<KorisniciPregledProvider>();
    // _korisniciRezervacijePregledProvider =
    //     context.read<KorisniciRezervacijePregledProvider>();
    // _kupciProvider = context.read<KupciProvider>();

    // _turistickiVodiciDetaljiProvider =
    //     context.read<TuristickiVodiciDetaljiProvider>();

    // _turistickiVodiciDetaljiProvider =
    //     Provider.of<TuristickiVodiciDetaljiProvider>(context,
    //       listen: false); //ovo mi je vazan red za inic providera
    //loadData();
    //loadRezervacijeBiciklDostupniDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {
      double cijenaVodica =
          (widget.arguments.argumentsTV!.cijenaVodica!).toDouble();
      double cijenaBicikla =
          (widget.arguments.argumentsBic!.cijenaBicikla!).toDouble();
      double cijenaTuristRute =
          (widget.arguments.argumentsTR!.cijenaRute!).toDouble();
      cijenaUsluge = cijenaVodica + cijenaBicikla + cijenaTuristRute;

      //DateTime? pickedDate = DateTime.now();
      //_datePickerController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      argumentsKor: widget.arguments.argumentsKor!,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          HeaderWidget(title: title),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
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

                                child: imageFromBase64String(
                                    widget.arguments.argumentsBic!.slika!)),
                          ),
                          //ovo je bilo prije x.slika!
                        ),
                        Center(
                            child: Text(
                                widget.arguments.argumentsBic!.nazivBicikla!)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
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

                                child: imageFromBase64String(
                                    widget.arguments.argumentsTR!.slikaRute!)),
                          ),
                          //ovo je bilo prije x.slika!
                        ),
                        Center(
                            child: Text(widget.arguments.argumentsTR!.naziv!)),
                      ],
                    ),
                  ),
                ],
              ),

              ////////////////////////////////////////////

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
                    initialValue: DateFormat('dd-MM-yyyy')
                        .format(widget.arguments.argumentsDate!),
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
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget.arguments.argumentsTV!.naziv!,
                    readOnly: true,
                    //controller: _datumPreuzimanjaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Turistički vodič",
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
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: cijenaUsluge.toString(),
                    readOnly: true,
                    //controller: _datumPreuzimanjaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Cijena",
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

              SizedBox(height: 30),

              Row(
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
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          child: Center(
                              child: Text("Izvrši plaćanje",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),

                          onTap: () async {
                            try {} catch (e) {
                              throw Exception("Došlo je do greške");
                            }
                            await makeRequest();
                            Navigator.pushNamed(context,
                                "${CheckoutTrPage.routeName}", //moram prepraviti
                                arguments: CheckoutTrArguments(
                                    sesijaId,
                                    widget.arguments.argumentsBic!,
                                    widget.arguments.argumentsKor,
                                    widget.arguments.argumentsTR,
                                    widget.arguments.argumentsTV,
                                    widget.arguments
                                        .argumentsDate)); //bila je sesijaId
                          }, //moram prepraviti
                          //arguments: args.argumentsBic);
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Icon to indicate the rating.
          // new Icon(
          //   Icons.star,
          //   color: Colors.red[500],
          // ),
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
