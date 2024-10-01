import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:image/image.dart' as img;

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/bicikli.dart';
import 'package:rentabikewtr_desktop/model/bicikliDetalji.dart';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/model/drzave.dart';
import 'package:rentabikewtr_desktop/model/korisniciDetalji.dart';
import 'package:rentabikewtr_desktop/model/korisniciPregled.dart';
import 'package:rentabikewtr_desktop/model/korisniciUpsert.dart';
import 'package:rentabikewtr_desktop/model/modeliBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/poslovnicePregled.dart';
import 'package:rentabikewtr_desktop/model/proizvodjaciBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/statusiPregled.dart';
import 'package:rentabikewtr_desktop/model/tipoviBicikla.dart';
import 'package:rentabikewtr_desktop/model/tipoviBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/turistRute.dart';
import 'package:rentabikewtr_desktop/model/turistRuteDetalji.dart';
import 'package:rentabikewtr_desktop/model/turistRutePregled.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodici.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodiciUpsert.dart';
import 'package:rentabikewtr_desktop/model/velicineBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/providers/bicikliPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/bicikli_detalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/bicikli_provider.dart';
import 'package:rentabikewtr_desktop/providers/drzave_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisnici_provider.dart';
import 'package:rentabikewtr_desktop/providers/modeliBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/poslovnicePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/proizvodjaciBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/tipoviBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/tipoviBicikla_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistRutePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistRute_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_desktop/providers/velicineBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_bicikli_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_tipoviBicikla.dart';
import 'package:rentabikewtr_desktop/screens/lista_turistRute_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';
import 'package:rentabikewtr_desktop/widgets/menuAdmin.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class DodajTipBiciklaScreen extends StatefulWidget {
  DodajTipBiciklaScreen({super.key});

  @override
  State<DodajTipBiciklaScreen> createState() => _DodajTipBiciklaScreenState();
}

class _DodajTipBiciklaScreenState extends State<DodajTipBiciklaScreen> {
  TextEditingController _nazivTipaController = TextEditingController();

  TipoviBicikla? tipBicikla; //-- ako koristimo prosljeđivanje objekta

  TipoviBiciklaProvider? _tipoviBiciklaProvider = null;
  TipoviBiciklaPregledProvider? _tipoviBiciklaPregledProvider = null;

  List<TipoviBiciklaPregled> tipoviBiciklaPregled = [];

  GlobalKey<FormState>? _formKey; // potrebno za validaciju
  //bool isEmail(String input) => EmailValidator.validate(input);

  bool dupliEmail = true;
  bool dupliNaziv = false;

  //TextEditingController _date = TextEditingController();

  @override
  void initState() {
    _formKey = GlobalKey(); // potrebno za validaciju
    // _defaultImage();
    //slika = widget.argumentsB.slika;
    _tipoviBiciklaProvider = context.read<TipoviBiciklaProvider>();
    _tipoviBiciklaPregledProvider =
        context.read<TipoviBiciklaPregledProvider>();

    tipBicikla = TipoviBicikla(nazivTipa: null);

    loadData(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {});
    super.initState();
  }

  Future loadData() async {
    var tmpTipoviBiciklaPregled = await _tipoviBiciklaPregledProvider?.get();

    setState(() {
      tipoviBiciklaPregled = tmpTipoviBiciklaPregled!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      // potrebno za validaciju

      key: _formKey, // potrebno za validaciju
      child: Column(
        children: <Widget>[
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
                  flex: 2,
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
                            "RentABikeWTR -Dodaj tip bicikla",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 11, 7, 255)),
                          ),
                          SizedBox(
                            height: 2,
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
                                      maxHeight: 200),
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
                                          16, 30, 16, 30),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _nazivTipaController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Naziv tipa",
                                                hintText: 'Unesite naziv tipa'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Naziv je obavezno polje.';
                                              } else if (value
                                                      .characters.length <
                                                  3) {
                                                return 'Minimalno 3(tri) karaktera.';
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
                                                            ListaTipoviBiciklaScreen(),
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
                                                        //     'Uspješno ste unijeli novi tip bicikla');
                                                        await Navigator.of(
                                                                context)
                                                            .push(MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ListaTipoviBiciklaScreen()));
                                                      } catch (e) {
                                                        await _handleSubmissionError(
                                                            e);
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 160,
                              // ),
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
        ],
      ),
    ));
  }

  Future<void> _handleFormSubmission() async {
    // try{
    _updateTuristRuteData();
    await _tipoviBiciklaProvider?.insert(tipBicikla);

    await _showDialog(
        context, 'Success', 'Učitavaju se podaci za novi tip bicikla...');
    // }catch(e){
    //_showDialog(context, "Greška", e.toString());
    // }
  }

  void _updateTuristRuteData() {
    setState(() {
      //turistRuta!.statusID = 1;
      if (!isPostojeciNaziv(_nazivTipaController.text)) {
        tipBicikla!.nazivTipa = _nazivTipaController.text;
      } else {
        dupliNaziv = true;
        _nazivTipaController.text = "";
        throw Exception(); // ovo mi je bitno da odmah baci exception, da ne prođe na API
        //nije ubace tekst zbog naredne poruke
      }
    });
  }

  Future<void> _handleSubmissionError(e) async {
    // if (dupliEmail) {
    //   _emailController.text = "";
    //   await _showDialog(context, 'Error', 'Email već postoji!');
    // }
    if (dupliNaziv) {
      //   _nazivController.text = "";
      await _showDialog(context, 'Error', 'Naziv već postoji!');
    } else {
      await _showDialog(context, 'Error', 'Došlo je do greške!');
      print('Greška:Poruka o kontekstu greške $e');
    }
  }

  bool isPostojeciNaziv(String input) {
    var brojac = 0;
    for (var tip in tipoviBiciklaPregled) {
      if (input == tip.nazivTipa) {
        brojac = brojac + 1;
      }
    }
    if (brojac > 0) {
      return true;
    } else {
      return false;
    }
  }

  void validateController() {
    if (!_formKey!.currentState!.validate()) {
      _showDialog(context, 'Error', 'Pogrešan unos pokušajte ponovo');
      // value is false.. textFields are rebuilt in order to show errorLabels
      return;
    } else {
      _showDialog(context, 'Success', 'Uspješno ste unijeli novi tip bicikla');
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
