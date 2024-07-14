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
import 'package:rentabikewtr_desktop/model/drzave.dart';
import 'package:rentabikewtr_desktop/model/korisniciDetalji.dart';
import 'package:rentabikewtr_desktop/model/korisniciPregled.dart';
import 'package:rentabikewtr_desktop/model/korisniciUpsert.dart';
import 'package:rentabikewtr_desktop/model/turistRuteDetalji.dart';
import 'package:rentabikewtr_desktop/model/turistRutePregled.dart';

import 'package:rentabikewtr_desktop/providers/turistRute_detalji_provider.dart';

import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';

import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';

import 'package:rentabikewtr_desktop/widgets/menuAdmin.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class TuristRuteDetaljiScreen extends StatefulWidget {
  final TuristRutePregled argumentsT;
  const TuristRuteDetaljiScreen({Key? key, required this.argumentsT})
      : super(key: key);

  @override
  State<TuristRuteDetaljiScreen> createState() =>
      _TuristRuteDetaljiScreenState();
}

class _TuristRuteDetaljiScreenState extends State<TuristRuteDetaljiScreen> {
  TextEditingController _nazivController = TextEditingController();
  TextEditingController _opisRuteController = TextEditingController();
  TextEditingController _cijenaRuteController = TextEditingController();

  TuristRuteDetalji?
      turistRutaDetalji; //-- ako koristimo prosljeđivanje objekta

  List<TuristRutePregled> turistRutePregled = [];

  int turistrutaid = 0;

  String? slika;
  String? novaSlika;
  File? _imageFile;
  final int _maxFileSize = 250 * 1024; //veličina slike do 250KB
  TuristRuteDetaljiProvider? _turistRuteDetaljiProvider = null;

  GlobalKey<FormState>? _formKey;
  //bool isEmail(String input) => EmailValidator.validate(input);
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
  bool isCijena(String input) {
    // This regular expression allows numbers like 1, 1.0, 12.34, 123.456, etc.
    final RegExp regex = RegExp(r'^\d+(\.\d+)$');
    return regex.hasMatch(input);
  } // potrebno za validaciju

  bool dupliEmail = true;
  bool duploKorIme = true;

  //TextEditingController _date = TextEditingController();

  @override
  void initState() {
    _formKey = GlobalKey();
    slika = widget.argumentsT.slikaRute;
    _turistRuteDetaljiProvider = context.read<TuristRuteDetaljiProvider>();

    loadTuristRuteDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {});
    super.initState();
  }

  Future<void> loadTuristRuteDetalji() async {
    var tmpturistRutaDetalji = await _turistRuteDetaljiProvider
        ?.getById(widget.argumentsT.turistRutaId!);

    setState(() {
      turistrutaid = widget.argumentsT.turistRutaId!;
      turistRutaDetalji = tmpturistRutaDetalji;

      _nazivController.text = turistRutaDetalji!.naziv!;
      _opisRuteController.text = turistRutaDetalji!.opisRute!;
      _cijenaRuteController.text = turistRutaDetalji!.cijenaRute!.toString();
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
                          Container(
                            height: 70,
                            width: 500,
                            child: imageFromBase64String(slika ?? ""),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "RentABikeWTR -Uredi turist rutu",
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
                                      maxHeight: 450),
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
                                            controller: _nazivController,
                                            decoration: const InputDecoration(
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
                                          TextFormField(
                                            controller: _opisRuteController,
                                            minLines: 1,
                                            maxLines: 3,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Opis rute",
                                                hintText: 'Unesite opis rute'),
                                            maxLength: 200,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Prezime je obavezno polje.';
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
                                          TextFormField(
                                            controller: _cijenaRuteController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Cijena",
                                                hintText: '10.0'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Cijena je obavezno polje.';
                                              } else if (!isCijena(value)) {
                                                return 'Cijena mora biti u formatu broja ##.#.';
                                              } else {
                                                return null;
                                              }
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        Colors.grey),
                                                onPressed: _pickImage,
                                                child: Text('Upload slike...'),
                                              ),
                                            ],
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
                                                            ListaVodiciScreen(),
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

    await _turistRuteDetaljiProvider?.update(turistrutaid, turistRutaDetalji);

    await _showDialog(
        context, 'Success', 'Učitavaju se podaci za novu turist rutu...');
    // _updateTuristickiVodicData();
  }

  void _updateTuristRutaData() {
    setState(() {
      turistRutaDetalji!.turistRutaId = turistrutaid;

      if (novaSlika != null) {
        turistRutaDetalji!.slikaRute = novaSlika;
      } else {
        turistRutaDetalji!.slikaRute = widget.argumentsT.slikaRute;
      }

      if (!isPostojeciNaziv(_nazivController.text)) {
        turistRutaDetalji!.naziv = _nazivController.text;
      } else {
        turistRutaDetalji!.naziv = widget.argumentsT.naziv;
      }
      turistRutaDetalji!.opisRute = _opisRuteController.text;
      turistRutaDetalji!.cijenaRute = double.parse(_cijenaRuteController.text);

      // }

      // Print the value of _cijenaController.text for debugging
      print('Cijena text: ${turistRutaDetalji!.naziv}');

      print('Final Cijena: ${turistRutaDetalji!.cijenaRute}');
      print('Final naziv:${turistRutaDetalji!.naziv} ');
    });
  }

  Future<void> _handleSubmissionError(e) async {
    await _showDialog(context, 'Error', 'Došlo je do greške!');
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
    for (var ruta in turistRutePregled) {
      if (input == ruta.naziv) {
        brojac = brojac + 1;
      }
    }
    if (brojac > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      // Check file size
      if (file.lengthSync() < _maxFileSize) {
        String base64Image = base64Encode(file.readAsBytesSync());
        setState(() {
          _imageFile = file;
          novaSlika = base64Image;
          slika = novaSlika; // Save to the Slika string object
        });
      } else {
        _showDialog(
            context, 'Greška', 'Dozvoljen je upload slike, veličine do 250KB');
        return;
      }
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
