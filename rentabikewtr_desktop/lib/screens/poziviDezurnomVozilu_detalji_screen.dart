//import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/drzave.dart';
import 'package:rentabikewtr_desktop/model/korisniciDetalji.dart';
import 'package:rentabikewtr_desktop/model/korisniciPregled.dart';
import 'package:rentabikewtr_desktop/model/korisniciUpsert.dart';
import 'package:rentabikewtr_desktop/model/poziviDezurnomVoziluPregled.dart';
import 'package:rentabikewtr_desktop/model/turistRuteDetalji.dart';
import 'package:rentabikewtr_desktop/model/turistRutePregled.dart';
import 'package:rentabikewtr_desktop/providers/poziviDezurnomVoziluPregled_provider.dart';

import 'package:rentabikewtr_desktop/providers/turistRute_detalji_provider.dart';

import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';

import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';

import 'package:rentabikewtr_desktop/widgets/menuAdmin.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class PoziviDezurnomVoziluDetaljiScreen extends StatefulWidget {
  final PoziviDezurnomVoziluPregled argumentsP;
  const PoziviDezurnomVoziluDetaljiScreen({Key? key, required this.argumentsP})
      : super(key: key);

  @override
  State<PoziviDezurnomVoziluDetaljiScreen> createState() =>
      _PoziviDezurnomVoziluDetaljiScreenState();
}

class _PoziviDezurnomVoziluDetaljiScreenState
    extends State<PoziviDezurnomVoziluDetaljiScreen> {
  TextEditingController _viseDetaljaController = TextEditingController();
  TextEditingController _datumPozivaController = TextEditingController();
  TextEditingController _vrijemePozivaController = TextEditingController();
  TextEditingController _nazivDezurnogVozilaController =
      TextEditingController();
  TextEditingController _nazivController = TextEditingController();
  TextEditingController _nazivPoslovniceController = TextEditingController();

  PoziviDezurnomVoziluPregled?
      pozivDezurnomVoziluPregled; //-- ako koristimo prosljeđivanje objekta

  List<PoziviDezurnomVoziluPregled> poziviDezurnomVoziluPregled = [];
  PoziviDezurnomVoziluPregledProvider? _poziviDezurnomVoziluPregledProvider;

  int pozivid = 0;

  GlobalKey<FormState>? _formKey;

  @override
  void initState() {
    _formKey = GlobalKey();

    _poziviDezurnomVoziluPregledProvider =
        context.read<PoziviDezurnomVoziluPregledProvider>();

    loadPoziviDezurnomVoziluDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {});
    super.initState();
  }

  Future<void> loadPoziviDezurnomVoziluDetalji() async {
    var tmpPozivDezurnomVozilu = widget.argumentsP;

    setState(() {
      pozivid = widget.argumentsP.pozivDezurnomVoziluId!;
      pozivDezurnomVoziluPregled = tmpPozivDezurnomVozilu;
      pozivDezurnomVoziluPregled!.nesreca = widget.argumentsP.nesreca;
      pozivDezurnomVoziluPregled!.kvar = widget.argumentsP.kvar;
      pozivDezurnomVoziluPregled!.zahtjevKlijenta =
          widget.argumentsP.zahtjevKlijenta;
      pozivDezurnomVoziluPregled!.losiVremenskiUslovi =
          widget.argumentsP.losiVremenskiUslovi;
      pozivDezurnomVoziluPregled!.viseDetalja = widget.argumentsP.viseDetalja;
      pozivDezurnomVoziluPregled!.datumPoziva = widget.argumentsP.datumPoziva;
      pozivDezurnomVoziluPregled!.vrijemePoziva =
          widget.argumentsP.vrijemePoziva;
      pozivDezurnomVoziluPregled!.nazivDezurnogVozila =
          widget.argumentsP.nazivDezurnogVozila;
      pozivDezurnomVoziluPregled!.viseDetalja = widget.argumentsP.viseDetalja;
      pozivDezurnomVoziluPregled!.naziv =
          widget.argumentsP.naziv; // Turisticki vodic
      pozivDezurnomVoziluPregled!.nazivPoslovnice =
          widget.argumentsP.nazivPoslovnice;

      _viseDetaljaController.text =
          pozivDezurnomVoziluPregled!.viseDetalja ?? "";
      _datumPozivaController.text = DateFormat('dd-MM-yyyy')
          .format(pozivDezurnomVoziluPregled!.datumPoziva!);
      _vrijemePozivaController.text = DateFormat('hh:mm')
          .format(pozivDezurnomVoziluPregled!.vrijemePoziva!);
      _nazivDezurnogVozilaController.text =
          pozivDezurnomVoziluPregled!.nazivDezurnogVozila!;

      _nazivController.text = pozivDezurnomVoziluPregled!.naziv!;
      _nazivPoslovniceController.text =
          pozivDezurnomVoziluPregled!.nazivPoslovnice!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: MenuRadnik(),
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/logo.jpg",
                            height: 50,
                            width: 500,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "RentABikeWTR -Poziv dežurnom vozilu - detalji",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 11, 7, 255)),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth: 300,
                                      minHeight: 100,
                                      maxHeight: 360),
                                  // width: 300,
                                  // height: 450,
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Color.fromARGB(255, 246, 249, 252),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 30, 16, 10),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            readOnly: true,
                                            controller:
                                                _nazivDezurnogVozilaController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Vozilo",
                                                hintText: 'Unesite naziv'),
                                            maxLength: 20,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            controller: _nazivController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Turistički vodič",
                                                hintText: 'Unesite naziv'),
                                            maxLength: 20,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            controller: _datumPozivaController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Datum poziva",
                                                hintText: ''),
                                            maxLength: 20,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            controller:
                                                _vrijemePozivaController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Vrijeme poziva",
                                                hintText: ''),
                                            maxLength: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth: 300,
                                      minHeight: 100,
                                      maxHeight: 270),
                                  // width: 300,
                                  // height: 450,
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Color.fromARGB(255, 246, 249, 252),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 30, 16, 10),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            readOnly: true,
                                            controller: _viseDetaljaController,
                                            minLines: 1,
                                            maxLines: 3,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Više detalja",
                                                hintText: ''),
                                            maxLength: 100,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            controller:
                                                _nazivPoslovniceController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Poslovnica",
                                                hintText: ''),
                                            maxLength: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth: 300,
                                      minHeight: 100,
                                      maxHeight: 360),
                                  // width: 300,
                                  // height: 450,
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Color.fromARGB(255, 246, 249, 252),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 20, 16, 10),
                                      child: Column(
                                        children: [
                                          CheckboxListTile(
                                            title: Text("Nesreća: "),
                                            value: pozivDezurnomVoziluPregled!
                                                .nesreca,
                                            onChanged: null,
                                          ),
                                          SizedBox(height: 20),
                                          CheckboxListTile(
                                              title: Text("Kvar: "),
                                              value: pozivDezurnomVoziluPregled!
                                                  .kvar!,
                                              onChanged: null),
                                          SizedBox(height: 20),
                                          CheckboxListTile(
                                              title: Text("Zahtjev klijenta: "),
                                              value: pozivDezurnomVoziluPregled!
                                                  .zahtjevKlijenta!,
                                              onChanged: null),
                                          SizedBox(height: 20),
                                          CheckboxListTile(
                                              title: Text(
                                                  "Loši vremenski uslovi: "),
                                              value: pozivDezurnomVoziluPregled!
                                                  .losiVremenskiUslovi!,
                                              onChanged: null),
                                          SizedBox(height: 20),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                      minWidth: 120,
                                                      maxWidth: 120,
                                                      //minHeight: 100,
                                                      //maxHeight: 450
                                                    ),
                                                    //width: 120,
                                                    child: ElevatedButton(
                                                      child: Text("Nazad ..."),
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                              ])
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
        ]),
      ),
    );
  }

  void validateController() {
    if (!_formKey!.currentState!.validate()) {
      _showDialog(context, 'Error', 'Pogrešan unos pokušajte ponovo');
      // value is false.. textFields are rebuilt in order to show errorLabels
      return;
    } else {
      _showDialog(context, 'Success', 'Uspješno ste izmijenili podatke');
    }
    // action WHEN values are valid
  }

  Future<void> _showDialog(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
