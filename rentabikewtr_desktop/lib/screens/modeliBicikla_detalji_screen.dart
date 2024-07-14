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
import 'package:rentabikewtr_desktop/model/modeliBiciklaDetalji.dart';
import 'package:rentabikewtr_desktop/model/modeliBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/tipoviBiciklaDetalji.dart';
import 'package:rentabikewtr_desktop/model/tipoviBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/turistRuteDetalji.dart';
import 'package:rentabikewtr_desktop/model/turistRutePregled.dart';
import 'package:rentabikewtr_desktop/providers/modeliBiciklaDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/modeliBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/tipoviBicikla_detalji_provider.dart';

import 'package:rentabikewtr_desktop/providers/turistRute_detalji_provider.dart';

import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_tipoviBicikla.dart';

import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';

import 'package:rentabikewtr_desktop/widgets/menuAdmin.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class ModeliBiciklaDetaljiScreen extends StatefulWidget {
  final ModeliBiciklaPregled argumentsM;
  const ModeliBiciklaDetaljiScreen({Key? key, required this.argumentsM})
      : super(key: key);

  @override
  State<ModeliBiciklaDetaljiScreen> createState() =>
      _ModeliBiciklaDetaljiScreenState();
}

class _ModeliBiciklaDetaljiScreenState
    extends State<ModeliBiciklaDetaljiScreen> {
  TextEditingController _nazivModelaController = TextEditingController();

  ModeliBiciklaDetalji?
      modelBiciklaDetalji; //-- ako koristimo prosljeđivanje objekta

  List<ModeliBiciklaPregled> modelBiciklaPregled = [];

  int modelbiciklaid = 0;

  ModeliBiciklaDetaljiProvider? _modeliBiciklaDetaljiProvider = null;
  ModeliBiciklaPregledProvider? _modeliBiciklaPregledProvider = null;

  GlobalKey<FormState>? _formKey;

  @override
  void initState() {
    _formKey = GlobalKey();

    _modeliBiciklaDetaljiProvider =
        context.read<ModeliBiciklaDetaljiProvider>();
    _modeliBiciklaPregledProvider =
        context.read<ModeliBiciklaPregledProvider>();
    loadModeliBiciklaDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {});
    super.initState();
  }

  Future<void> loadModeliBiciklaDetalji() async {
    var tmpModelBiciklaDetalji = await _modeliBiciklaDetaljiProvider
        ?.getById(widget.argumentsM.modelBiciklaId!);

    setState(() {
      modelbiciklaid = widget.argumentsM.modelBiciklaId!;
      modelBiciklaDetalji = tmpModelBiciklaDetalji;

      _nazivModelaController.text = tmpModelBiciklaDetalji!.nazivModela!;
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
                            "RentABikeWTR -Uredi model bicikla",
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
                                          16, 30, 16, 10),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _nazivModelaController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Naziv modela",
                                                hintText:
                                                    'Unesite naziv modela'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Naziv modela je obavezno polje.';
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
    _updateTipBiciklaData();

    await _modeliBiciklaDetaljiProvider?.update(
        modelbiciklaid, modelBiciklaDetalji);

    await _showDialog(
        context, 'Success', 'Učitavaju se podaci za novu turist rutu...');
    // _updateTuristickiVodicData();
  }

  void _updateTipBiciklaData() {
    setState(() {
      modelBiciklaDetalji!.modelBiciklaId = modelbiciklaid;
      modelBiciklaDetalji!.nazivModela = _nazivModelaController.text;
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
      _showDialog(context, 'Success', 'Uspješno ste kreirali novi tip bicikla');
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
