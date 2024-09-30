import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:core';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/model/modeliBicikla.dart';
import 'package:rentabikewtr_desktop/model/modeliBiciklaPregled.dart';

import 'package:rentabikewtr_desktop/providers/modeliBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/modeliBicikla_provider.dart';
import 'package:rentabikewtr_desktop/screens/lista_modeliBicikla_screen.dart';
import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class DodajModelBiciklaScreen extends StatefulWidget {
  DodajModelBiciklaScreen({super.key});

  @override
  State<DodajModelBiciklaScreen> createState() =>
      _DodajModelBiciklaScreenState();
}

class _DodajModelBiciklaScreenState extends State<DodajModelBiciklaScreen> {
  TextEditingController _nazivModelaController = TextEditingController();

  ModeliBicikla? modelBicikla; //-- ako koristimo prosljeđivanje objekta

  ModeliBiciklaProvider? _modeliBiciklaProvider = null;
  ModeliBiciklaPregledProvider? _modeliBiciklaPregledProvider = null;

  List<ModeliBiciklaPregled> modeliBiciklaPregled = [];

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
    _modeliBiciklaProvider = context.read<ModeliBiciklaProvider>();
    _modeliBiciklaPregledProvider =
        context.read<ModeliBiciklaPregledProvider>();

    modelBicikla = ModeliBicikla(nazivModela: null);

    loadData(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {});
    super.initState();
  }

  Future loadData() async {
    var tmpModeliBiciklaPregled = await _modeliBiciklaPregledProvider?.get();

    setState(() {
      modeliBiciklaPregled = tmpModeliBiciklaPregled!;
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
                                            controller: _nazivModelaController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Naziv modela",
                                                hintText:
                                                    'Unesite naziv modela'),
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
                                                            ListaModeliBiciklaScreen(),
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

                                                        await Navigator.of(
                                                                context)
                                                            .push(MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ListaModeliBiciklaScreen()));
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
    _updateModeliBiciklaData();
    await _modeliBiciklaProvider?.insert(modelBicikla);

    await _showDialog(
        context, 'Success', 'Učitavaju se podaci za novo biciklo...');
    // }catch(e){
    //_showDialog(context, "Greška", e.toString());
    // }
  }

  void _updateModeliBiciklaData() {
    setState(() {
      //turistRuta!.statusID = 1;
      if (!isPostojeciNaziv(_nazivModelaController.text)) {
        modelBicikla!.nazivModela = _nazivModelaController.text;
      } else {
        dupliNaziv = true;
        _nazivModelaController.text = "";
        throw Exception(); // ovo mi je bitno da odmah baci exception, da ne prođe na API
        //nije ubacen tekst zbog naredne poruke
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
    for (var tip in modeliBiciklaPregled) {
      if (input == tip.nazivModela) {
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
