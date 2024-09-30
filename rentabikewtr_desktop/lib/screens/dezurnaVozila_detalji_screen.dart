//import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/dezurnaVozilaDetalji.dart';
import 'package:rentabikewtr_desktop/model/dezurnaVozilaPregled.dart';
import 'package:rentabikewtr_desktop/model/drzave.dart';
import 'package:rentabikewtr_desktop/model/korisniciDetalji.dart';
import 'package:rentabikewtr_desktop/model/korisniciPregled.dart';
import 'package:rentabikewtr_desktop/model/korisniciUpsert.dart';
import 'package:rentabikewtr_desktop/model/turistRuteDetalji.dart';
import 'package:rentabikewtr_desktop/model/turistRutePregled.dart';
import 'package:rentabikewtr_desktop/providers/dezurnaVozilaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/dezurnaVozila_detalji_provider.dart';

import 'package:rentabikewtr_desktop/providers/turistRute_detalji_provider.dart';

import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_dezurnaVozila_screen.dart';

import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';

import 'package:rentabikewtr_desktop/widgets/menuAdmin.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class DezurnaVozilaDetaljiScreen extends StatefulWidget {
  final DezurnaVozilaPregled argumentsDV;
  const DezurnaVozilaDetaljiScreen({Key? key, required this.argumentsDV})
      : super(key: key);

  @override
  State<DezurnaVozilaDetaljiScreen> createState() =>
      _TuristRuteDetaljiScreenState();
}

class _TuristRuteDetaljiScreenState extends State<DezurnaVozilaDetaljiScreen> {
  TextEditingController _nazivDezurnogVozilaController =
      TextEditingController();
  TextEditingController _tipVozilaController = TextEditingController();
  //TextEditingController _cijenaRuteController = TextEditingController();

  DezurnaVozilaDetalji?
      dezurnoVoziloDetalji; //-- ako koristimo prosljeđivanje objekta

  List<DezurnaVozilaPregled> dezurnaVozilaPregled = [];

  int voziloid = 0;

  DezurnaVozilaDetaljiProvider? _dezurnaVozilaDetaljiProvider = null;
  DezurnaVozilaPregledProvider? _dezurnaVozilaPregledProvider = null;

  GlobalKey<FormState>? _formKey;

  bool dupliNaziv = false;

  @override
  void initState() {
    _formKey = GlobalKey();

    _dezurnaVozilaDetaljiProvider =
        context.read<DezurnaVozilaDetaljiProvider>();
    _dezurnaVozilaPregledProvider =
        context.read<DezurnaVozilaPregledProvider>();

    loadDezurnaVozilaDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {});
    super.initState();
  }

  Future<void> loadDezurnaVozilaDetalji() async {
    var tmpDezurnoVoziloDetalji = await _dezurnaVozilaDetaljiProvider
        ?.getById(widget.argumentsDV.dezurnoVoziloId!);

    setState(() {
      voziloid = widget.argumentsDV.dezurnoVoziloId!;
      dezurnoVoziloDetalji = tmpDezurnoVoziloDetalji;

      _nazivDezurnogVozilaController.text =
          dezurnoVoziloDetalji!.nazivDezurnogVozila!;
      _tipVozilaController.text = dezurnoVoziloDetalji!.tipVozila!;
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
                            "RentABikeWTR -Uredi dežurno vozilo",
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
                                      maxHeight: 300),
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
                                            controller:
                                                _nazivDezurnogVozilaController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Naziv",
                                                hintText: 'Unesite naziv'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Naziv je obavezno polje.';
                                              } else if (value
                                                      .characters.length <
                                                  3) {
                                                return 'Mora da sadrži minimalno 3(tri) karaktera.';
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
                                            controller: _tipVozilaController,
                                            minLines: 1,
                                            maxLines: 3,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Tip Vozila",
                                                hintText:
                                                    'Npr. Terenac ili Kombi'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Ovo je obavezno polje.';
                                              } else if (value
                                                      .characters.length <
                                                  3) {
                                                return 'Mora da sadrži minimalno 3(tri) karaktera.';
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
                                                            ListaDezurnaVozilaScreen(),
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
                                                                        RadnikPortalScreen()));
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

  // MenuBar MenuAdmin(BuildContext context) => MenuAdmin(context);

  // dynamic MenuMenu(BuildContext context) => MenuBar(context);

/////////////////////////////////////////////////////////////////////////
  Future<void> _handleFormSubmission() async {
    _updateTuristRutaData();

    await _dezurnaVozilaDetaljiProvider?.update(voziloid, dezurnoVoziloDetalji);

    await _showDialog(context, 'Success', 'Učitavaju se podaci za vozilo...');
    // _updateTuristickiVodicData();
  }

  void _updateTuristRutaData() {
    setState(() {
      dezurnoVoziloDetalji!.dezurnoVoziloId = voziloid;

      if (!isPostojeciNaziv(_nazivDezurnogVozilaController.text)) {
        dezurnoVoziloDetalji!.nazivDezurnogVozila =
            _nazivDezurnogVozilaController.text;
      } else {
        dezurnoVoziloDetalji!.nazivDezurnogVozila =
            widget.argumentsDV.nazivDezurnogVozila;
        throw Exception();
      }
      dezurnoVoziloDetalji!.tipVozila = _tipVozilaController.text;

      // }

      // Print the value of _cijenaController.text for debugging
      print('Cijena text: ${dezurnoVoziloDetalji!.nazivDezurnogVozila}');

      print('Final Tip: ${dezurnoVoziloDetalji!.tipVozila}');
    });
  }

  Future<void> _handleSubmissionError(e) async {
    if (dupliNaziv) {
      //   _nazivController.text = "";
      await _showDialog(context, 'Error', 'Naziv već postoji!');
    } else {
      await _showDialog(context, 'Error', 'Došlo je do greške!');
      print('Greška:Poruka o kontekstu greške $e');
    }
  }

  void validateController() {
    if (!_formKey!.currentState!.validate()) {
      _showDialog(context, 'Error', 'Pogrešan unos pokušajte ponovo');
      // value is false.. textFields are rebuilt in order to show errorLabels
      return;
    } else {
      _showDialog(context, 'Success', 'Uspješno ste kreirali novu turist rutu');
    }
    // action WHEN values are valid
  }

  bool isPostojeciNaziv(String input) {
    var brojac = 0;
    for (var voz in dezurnaVozilaPregled) {
      if (input == voz.nazivDezurnogVozila) {
        brojac = brojac + 1;
      }
    }
    if (brojac > 0) {
      dupliNaziv = true;
      return true;
    } else {
      return false;
    }
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
