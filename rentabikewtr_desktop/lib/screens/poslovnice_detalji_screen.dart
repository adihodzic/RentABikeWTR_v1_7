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
import 'package:rentabikewtr_desktop/model/poslovniceDetalji.dart';
import 'package:rentabikewtr_desktop/model/poslovnicePregled.dart';
import 'package:rentabikewtr_desktop/model/poziviDezurnomVoziluPregled.dart';
import 'package:rentabikewtr_desktop/model/turistRuteDetalji.dart';
import 'package:rentabikewtr_desktop/model/turistRutePregled.dart';
import 'package:rentabikewtr_desktop/providers/poslovniceDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/poslovnicePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/poziviDezurnomVoziluPregled_provider.dart';

import 'package:rentabikewtr_desktop/providers/turistRute_detalji_provider.dart';

import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_poslovnice_screen.dart';

import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';

import 'package:rentabikewtr_desktop/widgets/menuAdmin.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class PoslovniceDetaljiScreen extends StatefulWidget {
  final PoslovnicePregled argumentsP;
  const PoslovniceDetaljiScreen({Key? key, required this.argumentsP})
      : super(key: key);

  @override
  State<PoslovniceDetaljiScreen> createState() =>
      _PoslovniceDetaljiScreenState();
}

class _PoslovniceDetaljiScreenState extends State<PoslovniceDetaljiScreen> {
  TextEditingController _nazivPoslovniceController = TextEditingController();
  TextEditingController _emailKontaktController = TextEditingController();
  TextEditingController _adresaController = TextEditingController();
  TextEditingController _brojTelefonaController = TextEditingController();

  PoslovnicePregled?
      poslovnicaPregled; //-- ako koristimo prosljeđivanje objekta

  List<PoslovnicePregled> poslovnicePregled = [];
  PoslovnicePregledProvider? _poslovnicePregledProvider;
  PoslovniceDetaljiProvider? _poslovniceDetaljiProvider;
  int poslovnicaid = 0;

  PoslovniceDetalji? poslovnicaDetalji;

  GlobalKey<FormState>? _formKey;

  bool isEmail(String input) {
    if (EmailValidator.validate(input)) {
      return true;
    } else {
      return false;
    }
  }

  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);

  @override
  void initState() {
    _formKey = GlobalKey();

    _poslovnicePregledProvider = context.read<PoslovnicePregledProvider>();
    _poslovniceDetaljiProvider = context.read<PoslovniceDetaljiProvider>();

    loadPoslovniceDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {});
    super.initState();
  }

  Future<void> loadPoslovniceDetalji() async {
    var tmpPoslovnicaPregled = widget.argumentsP;
    var tmpPoslovnicaDetalji = await _poslovniceDetaljiProvider
        ?.getById(widget.argumentsP.poslovnicaId!);

    setState(() {
      poslovnicaid = widget.argumentsP.poslovnicaId!;
      poslovnicaPregled = tmpPoslovnicaPregled;
      poslovnicaDetalji = tmpPoslovnicaDetalji!;

      // poslovnicaPregled!.nazivPoslovnice = widget.argumentsP.nazivPoslovnice;
      // poslovnicaPregled!.emailKontakt = widget.argumentsP.emailKontakt;
      // poslovnicaPregled!.adresa = widget.argumentsP.adresa;
      // poslovnicaPregled!.brojTelefona = widget.argumentsP.brojTelefona;

      _nazivPoslovniceController.text = poslovnicaDetalji!.nazivPoslovnice!;
      _emailKontaktController.text = poslovnicaDetalji!.emailKontakt!;
      _adresaController.text = poslovnicaDetalji!.adresa!;
      _brojTelefonaController.text = poslovnicaDetalji!.brojTelefona!;
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
                            "RentABikeWTR -Poslovnica - detalji",
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
                                      maxHeight: 430),
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
                                            //readOnly: true,
                                            controller:
                                                _nazivPoslovniceController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Naziv poslovnice",
                                                hintText: 'Unesite naziv'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Naziv je obavezno polje.';
                                              } else if (value
                                                      .characters.length <
                                                  3) {
                                                return 'Minimalno 3(tri) karaktera..';
                                              } else {
                                                return null;
                                              }
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            //readOnly: true,
                                            controller: _emailKontaktController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "e-mail",
                                                hintText: 'Unesite e-mail'),
                                            maxLength: 30,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'E-mail je obavezno polje';
                                              } else if (!isEmail(value)) {
                                                return 'Pravilno unesite e-mail.';
                                              } else {
                                                return null;
                                              }
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            //readOnly: true,
                                            controller: _adresaController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Adresa",
                                                hintText: 'Unesite adresu'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Naziv je obavezno polje.';
                                              } else if (value
                                                      .characters.length <
                                                  3) {
                                                return 'Mora da sadrži minimalno 3(tri) karaktera..';
                                              } else {
                                                return null;
                                              }
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            //readOnly: true,
                                            controller: _brojTelefonaController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Broj telefona",
                                                hintText: 'npr. +38711223344'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Telefon je obavezan.';
                                              } else if (value
                                                      .characters.length <
                                                  10) {
                                                return 'Telefon mora imati minimalno 10 karaktera.';
                                              } else if (!isPhone(value)) {
                                                return 'Nepravilan format';
                                              } else {
                                                return null;
                                              }
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          SizedBox(height: 30),
                                          Row(children: [
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
                                                  child: Text("Otkaži"),
                                                  onPressed: () async {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ListaPoslovniceScreen(),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 16),
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
                                                  child: Text("Snimi"),
                                                  onPressed: () async {
                                                    if (_formKey!.currentState!
                                                        .validate()) {
                                                      try {
                                                        await _handleFormSubmission();
                                                        // await _showDialog(
                                                        //     context,
                                                        //     'Success',
                                                        //     'Uspješno ste editovali turističko vodiča');
                                                        await Navigator.of(
                                                                context)
                                                            .push(MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ListaPoslovniceScreen()));
                                                      } catch (e) {
                                                        await _handleSubmissionError(
                                                            e);
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
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
      _showDialog(
          context, 'Success', 'Uspješno ste Uspješno ste izmijenili podatke');
    }
    // action WHEN values are valid
  }

  Future<void> _handleFormSubmission() async {
    _updatePoslovnicaData();

    await _poslovniceDetaljiProvider?.patch(poslovnicaid, poslovnicaDetalji);
    // currentUser = await _korisniciDetaljiProvider
    //     ?.getProfilKorisnika(korisnikDetalji!.korisnickoIme!);
    await _showDialog(
        context, 'Success', 'Učitavaju se podaci za poslovnicu...');
    // _updateTuristickiVodicData();
  }

  Future<void> _handleSubmissionError(e) async {
    print('Greska: Kontekst greške $e');
    await _showDialog(context, 'Error', 'Došlo je do greške!');
  }

  void _updatePoslovnicaData() {
    setState(() {
      poslovnicaDetalji!.poslovnicaId = poslovnicaid;
      poslovnicaDetalji!.nazivPoslovnice = _nazivPoslovniceController.text;
      poslovnicaDetalji!.emailKontakt = _emailKontaktController.text;
      poslovnicaDetalji!.adresa = _adresaController.text;
      poslovnicaDetalji!.brojTelefona = _brojTelefonaController.text;

      // Print the final value of cijena for debugging
      print('Final Cijena: ${poslovnicaDetalji?.nazivPoslovnice}');
    });
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
