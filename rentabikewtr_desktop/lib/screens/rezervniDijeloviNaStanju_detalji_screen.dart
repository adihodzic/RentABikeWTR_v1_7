//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/model/rezervniDijeloviDetalji.dart';
import 'package:rentabikewtr_desktop/model/rezervniDijeloviPregled.dart';
import 'package:rentabikewtr_desktop/providers/rezervniDijeloviPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/rezervniDijelovi_detalji_provider.dart';
import 'package:rentabikewtr_desktop/screens/lista_rezervniDijelovi_screen.dart';
import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class RezervniDijeloviNaStanjuDetaljiScreen extends StatefulWidget {
  final RezervniDijeloviPregled argumentsR;
  const RezervniDijeloviNaStanjuDetaljiScreen(
      {Key? key, required this.argumentsR})
      : super(key: key);

  @override
  State<RezervniDijeloviNaStanjuDetaljiScreen> createState() =>
      _RezervniDijeloviNaStanjuDetaljiScreenState();
}

class _RezervniDijeloviNaStanjuDetaljiScreenState
    extends State<RezervniDijeloviNaStanjuDetaljiScreen> {
  TextEditingController _nazivRezervnogDijelaController =
      TextEditingController();
  TextEditingController _sifraArtiklaController = TextEditingController();
  TextEditingController _naStanjuController = TextEditingController();
  TextEditingController _nazivKategorijeController = TextEditingController();
  TextEditingController _novoNaStanjuController = TextEditingController();

  RezervniDijeloviDetalji?
      rezervniDio; //-- ako koristimo prosljeđivanje objekta

  List<RezervniDijeloviPregled> rezervniDijeloviPregled = [];
  RezervniDijeloviPregled? rezervniDioPregled;
  RezervniDijeloviPregledProvider? _rezervniDijeloviPregledProvider;
  RezervniDijeloviDetaljiProvider? _rezervniDijeloviDetaljiProvider;

  int dioid = 0;

  GlobalKey<FormState>? _formKey;

  bool isCijena(String input) {
    // This regular expression allows numbers like 1, 1.0, 12.34, 123.456, etc.
    final RegExp regex = RegExp(r'^\d+$');
    return regex.hasMatch(input);
  } // potrebno za validaciju

  @override
  void initState() {
    _formKey = GlobalKey();

    _rezervniDijeloviPregledProvider =
        context.read<RezervniDijeloviPregledProvider>();
    _rezervniDijeloviDetaljiProvider =
        context.read<RezervniDijeloviDetaljiProvider>();

    loadRezervniDijeloviDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {});
    super.initState();
  }

  Future<void> loadRezervniDijeloviDetalji() async {
    var tmpRezervniDijeloviPregled = widget.argumentsR;
    var tmpRezervniDio = await _rezervniDijeloviDetaljiProvider
        ?.getById(widget.argumentsR.rezervniDijeloviId!);

    setState(() {
      dioid = widget.argumentsR.rezervniDijeloviId!;
      rezervniDio = tmpRezervniDio;
      _nazivRezervnogDijelaController.text = rezervniDio!.nazivRezervnogDijela!;
      _sifraArtiklaController.text = rezervniDio!.sifraArtikla!;
      _naStanjuController.text = rezervniDio!.naStanju!.toString();
      _nazivKategorijeController.text = widget.argumentsR.nazivKategorije!;
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
                            "RentABikeWTR -Rezervni dijelovi - detalji",
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
                                                _nazivRezervnogDijelaController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Rezervni dio",
                                                hintText: 'Unesite naziv'),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            controller: _sifraArtiklaController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Šifra artikla",
                                                hintText: ''),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            controller: _naStanjuController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText:
                                                    "Trenutno(na stanju)",
                                                hintText: ''),
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
                                            controller: _novoNaStanjuController,
                                            minLines: 1,
                                            maxLines: 3,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Novo stanje",
                                                hintText:
                                                    'Unesite novu količinu na stanju'),
                                            maxLength: 5,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Cijena je obavezno polje.';
                                              } else if (!isCijena(value)) {
                                                return 'Cijena mora biti u formatu cijelog broja #';
                                              } else {
                                                return null;
                                              }
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          SizedBox(height: 20),
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
                                                            ListaRezervniDijeloviScreen(),
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
                                                                        ListaRezervniDijeloviScreen()));
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

  Future<void> _handleFormSubmission() async {
    _updateRezervniDioData();

    await _rezervniDijeloviDetaljiProvider?.patch(dioid, rezervniDio);

    await _showDialog(context, 'Success',
        'Učitavaju se podaci za novo količinu na stanju...');
  }

  void _updateRezervniDioData() {
    setState(() {
      rezervniDio!.rezervniDijeloviId = dioid;
      rezervniDio!.naStanju = int.parse(_novoNaStanjuController.text);

      // }

      // Print the value of _cijenaController.text for debugging
      print('Stanje text: ${rezervniDio!.naStanju}');
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
      _showDialog(context, 'Success', 'Uspješno ste dodali dio na stanje');
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
