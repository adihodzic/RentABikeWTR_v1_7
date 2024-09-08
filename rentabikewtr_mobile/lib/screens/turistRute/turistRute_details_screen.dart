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
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';
import 'package:rentabikewtr_mobile/providers/detalji_provider.dart';
import 'package:rentabikewtr_mobile/providers/turistRute_provider.dart';
import 'package:rentabikewtr_mobile/providers/rezervacije_provider.dart';
import 'package:rentabikewtr_mobile/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:rentabikewtr_mobile/widgets/header_widget.dart';
//import 'package:provider/provider.dart';

//import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';

import '../../model/screenArguments.dart';
import '../../model/turistRute.dart';

import '../../model/turistickiVodici.dart';
import '../../utils/util.dart';
import '../../widgets/master_screen.dart';
import '../rezervacije/rezervacija_korak1_screen.dart';
import '../rezervacije/rezervacija_korak3tr_screen.dart';

class TuristRuteDetailsScreen extends StatefulWidget {
  ScreenArguments args;

  TuristRuteDetailsScreen({Key? key, required this.args}) : super(key: key);

  static const String routeName = "/turistrute_details";

  @override
  State<TuristRuteDetailsScreen> createState() =>
      _TuristRuteDetailsScreenState();
}

class _TuristRuteDetailsScreenState extends State<TuristRuteDetailsScreen> {
  String? title;
  TextEditingController _opisRuteController = TextEditingController();
  TextEditingController _cijenaRuteController = TextEditingController();

  //int sesijaId
  // KorisniciProfil? argumentsKor;

  // TuristRute? argumentsTR;

  // TuristickiVodici? argumentsTV;

  // Bicikli? argumentsBic;
  @override
  void initState() {
    title = widget.args.argumentsTR!.naziv;
    setState(() {
      _opisRuteController.text = widget.args.argumentsTR!.opisRute!;
      _cijenaRuteController.text =
          (widget.args.argumentsTR!.cijenaRute!).toString();
    });

    // TODO: implement initState
    super.initState();
    // _turistRuteProvider = context.read<TuristRuteProvider>();
    // _bicikliProvider = context.read<BicikliProvider>();
    // _turistickiVodiciProvider = context.read<TuristickiVodiciProvider>();
    // // _cartProvider = context.read<CartProvider>();
    // print("called initState");
    // loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      argumentsKor: widget.args.argumentsKor!,
      child: ListView(
        children: <Widget>[
          HeaderWidget(title: title!),
          SizedBox(
            height: 50,
          ),
          Column(
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
                          widget.args.argumentsTR!.slikaRute!)),
                ),
                //ovo je bilo prije x.slika!
              ),
              Center(
                child: Text(
                  widget.args.argumentsTR!.naziv!,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
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
                    readOnly: true,
                    controller: _opisRuteController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Opis rute",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: '',
                      counterText: "", //sakriven counter od maxLength
                      suffixIcon: Icon(Icons.map),
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
                    readOnly: true,
                    controller: _cijenaRuteController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Cijena rute",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: '',
                      counterText: "", //sakriven counter od maxLength
                      suffixIcon: Icon(Icons.map),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),

              // First child in the Row for the name and the
              // Release date information.
              // Container(
              //   padding: const EdgeInsets.only(bottom: 8.0),
              //   child: Center(
              //     child: Text(
              //       widget.args.argumentsTR!.naziv!,
              //       style: TextStyle(
              //         fontWeight: FontWeight.normal,
              //       ),
              //     ),
              //   ),
              // ),
              // // Code to create the view for release date.
              // Container(
              //   height: 200,
              //   width: 100,
              //   child: imageFromBase64String(
              //       widget.args.argumentsTR!.slikaRute!),
              // ),
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
                      // child: Container(
                      //   height: 30,
                      //   margin: EdgeInsets.fromLTRB(5, 10, 0, 10),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(2),
                      //     gradient: LinearGradient(colors: [
                      //       Color.fromRGBO(143, 148, 251, 1),
                      //       Color.fromRGBO(143, 148, 251, .6)
                      //     ]),
                      //   ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0), //prosiren inkWell
                        child: InkWell(
                          child: Center(
                              child: Text("Rezervacija turist rute",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          onTap: () async {
                            try {
                              // await _handleFormSubmission();
                              // await _showDialog(
                              //     context,
                              //     'Success',
                              //     'Uspješno ste editovali detalje bicikla');
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RezervacijaKorak3trScreen(
                                              arguments: ScreenArguments(
                                            widget.args.argumentsKor,
                                            widget.args.argumentsTR,
                                            widget.args.argumentsBic,
                                            widget.args.argumentsTV,
                                            widget.args.argumentsDate,
                                          ))));
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
              // Icon to indicate the rating.
              // new Icon(
              //   Icons.star,
              //   color: Colors.red[500],
              // ),
              //new Text('${bic.voteAverage}'),
            ],
          ),
        ],
      ),
    );
  }
}
