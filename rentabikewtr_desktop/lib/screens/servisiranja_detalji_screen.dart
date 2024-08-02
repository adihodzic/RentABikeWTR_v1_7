//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:rentabikewtr_desktop/model/rezervniDijeloviDetalji.dart';
import 'package:rentabikewtr_desktop/model/rezervniDijeloviPregled.dart';
import 'package:rentabikewtr_desktop/model/servisiranjaDetalji.dart';
import 'package:rentabikewtr_desktop/model/servisiranjaPregled.dart';

import 'package:rentabikewtr_desktop/providers/rezervniDijeloviPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/rezervniDijelovi_detalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/servisiranjaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/servisiranja_detalji_provider.dart';

import 'package:rentabikewtr_desktop/screens/lista_servisiranja_screen.dart';

import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';

import 'package:rentabikewtr_desktop/utils/util.dart';

import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class ServisiranjaDetaljiScreen extends StatefulWidget {
  final ServisiranjaPregled argumentsS;
  const ServisiranjaDetaljiScreen({Key? key, required this.argumentsS})
      : super(key: key);

  @override
  State<ServisiranjaDetaljiScreen> createState() =>
      _ServisiranjaDetaljiScreenState();
}

class _ServisiranjaDetaljiScreenState extends State<ServisiranjaDetaljiScreen> {
  TextEditingController _nazivBiciklaController = TextEditingController();
  TextEditingController _datumServisiranjaController = TextEditingController();
  TextEditingController _opisKvaraController = TextEditingController();
  TextEditingController _preduzetaAkcijaController = TextEditingController();
  TextEditingController _komentarServiseraController = TextEditingController();

  ServisiranjaPregled? argumentsS; //-- ako koristimo prosljeđivanje objekta
  List<ServisiranjaPregled> servisiranjaPregled = [];

  ServisiranjaDetalji? servisiranjeDetalji;
  RezervniDijeloviPregled? rezervniDio;
  List<RezervniDijeloviPregled> pocetnaListaSelected = [];
  List<RezervniDijeloviPregled> lista = [];
  List<RezervniDijeloviPregled>? listaSelected = [];

  RezervniDijeloviDetalji dio = RezervniDijeloviDetalji();
  RezervniDijeloviDetalji dioPocetna = RezervniDijeloviDetalji();

  RDIsKoristenPregled? koristen;
  List<RDIsKoristenPregled>? statusLista = [];
  List<RDIsKoristenPregled>? statusListaSelected = [];

  int biciklid = 0;

  //String title = "Dodaj";

  DateTime? dateServ;
  int? servisiranjeid;
  RezervniDijeloviPregledProvider? _rezervniDijeloviPregledProvider = null;
  RezervniDijeloviDetaljiProvider? _rezervniDijeloviDetaljiProvider = null;
  ServisiranjaPregledProvider? _servisiranjaPregledProvider = null;
  ServisiranjaDetaljiProvider? _servisiranjaDetaljiProvider = null;
  GlobalKey<FormState>? _formKey;

  @override
  void initState() {
    _formKey = GlobalKey();
    _servisiranjaPregledProvider = context.read<ServisiranjaPregledProvider>();
    _servisiranjaDetaljiProvider = context.read<ServisiranjaDetaljiProvider>();
    _rezervniDijeloviPregledProvider =
        context.read<RezervniDijeloviPregledProvider>();

    loadServisiranjaDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsS
    setState(() {
      //DateTime? pickedDate = DateTime.now();
      //_datePickerController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    });
    super.initState();
  }

  Future<void> loadServisiranjaDetalji() async {
    var tmpLista = await _rezervniDijeloviPregledProvider?.get();
    pocetnaListaSelected = widget.argumentsS!.rezervniDijelovi!;
    var tmpservisiranjeDetalji = await _servisiranjaDetaljiProvider
        ?.getById(widget.argumentsS.servisiranjeId!);

    setState(() {
      servisiranjeDetalji = tmpservisiranjeDetalji!;
      servisiranjeid = widget.argumentsS.servisiranjeId!;
      biciklid = widget.argumentsS.biciklID!;
      listaSelected = pocetnaListaSelected!;
      lista = tmpLista!;
      statusLista = convertToStatusLista(lista); //2. dio konverzije
      statusListaSelected = convertToStatusLista(listaSelected!);

      for (var it in statusListaSelected!) {
        //koristen = it;
        koristen = statusLista!.firstWhere(
            (element) => element.rezervniDijeloviId == it.rezervniDijeloviId);
        setState(() {
          koristen!.isKoristen = true;
        });
      }

      _nazivBiciklaController.text = widget.argumentsS.nazivBicikla!;
      dateServ = widget.argumentsS.datumServisiranja!;
      _datumServisiranjaController.text =
          DateFormat('dd-MM-yyyy').format(dateServ!);
      _opisKvaraController.text = widget.argumentsS.opisKvara!;
      _preduzetaAkcijaController.text = widget.argumentsS.preduzetaAkcija ?? "";
      _komentarServiseraController.text = widget.argumentsS.komentarServisera!;
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
                  flex: 4,
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
                            "RentABikeWTR -Uredi podatke o servisiranju",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 11, 7, 255)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth: 250,
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
                                          16, 10, 16, 10),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              readOnly: true,
                                              controller:
                                                  _nazivBiciklaController,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "Naziv bicikla",
                                                  hintText: 'Unesite ime'),
                                              maxLength: 20,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Ime je obavezno polje.';
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
                                              readOnly: true,
                                              controller:
                                                  _datumServisiranjaController,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText:
                                                      "Datum servisiranja",
                                                  hintText: ''),
                                              maxLength: 20,
                                            ),
                                            TextFormField(
                                              controller: _opisKvaraController,
                                              maxLines: 3,
                                              minLines: 1,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "Opis kvara",
                                                  hintText: 'Kratki opis'),
                                              maxLength: 50,
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth: 250,
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
                                          16, 10, 16, 10),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller:
                                                  _preduzetaAkcijaController,
                                              maxLines: 3,
                                              minLines: 1,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "Preduzeta akcija",
                                                  hintText:
                                                      'Na čekanju, Završen servis i sl.'),
                                              maxLength: 50,
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
                                            TextFormField(
                                              controller:
                                                  _komentarServiseraController,
                                              maxLines: 3,
                                              minLines: 1,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText:
                                                      "Komentar servisera",
                                                  hintText:
                                                      'Npr. Zamijenjena guma, potrebno zamijeniti i sl.'),
                                              maxLength: 50,
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
                                            SizedBox(height: 9),
                                            Row(children: [
                                              Flexible(
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                      minWidth: 120,
                                                      maxWidth: 120),
                                                  //minHeight: 100,
                                                  // maxHeight: 450),
                                                  //width: 120,
                                                  child: ElevatedButton(
                                                    child: Text("Otkaži"),
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ListaServisiranjaScreen(),
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
                                                    minWidth: 100,
                                                    maxWidth: 100,
                                                    //minHeight: 100,
                                                    //maxHeight: 450
                                                  ),
                                                  //width: 120,
                                                  child: ElevatedButton(
                                                    child: Text("Snimi"),
                                                    onPressed: () async {
                                                      if (_formKey!
                                                          .currentState!
                                                          .validate()) {
                                                        try {
                                                          await _handleFormSubmission();
                                                          await _showDialog(
                                                              context,
                                                              'Success',
                                                              'Uspješno ste editovali podatke o servisiranju');
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
                                            ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 380,
                                      maxWidth: 400,
                                      minHeight: 300,
                                      maxHeight: 450),
                                  child: Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      color: Color.fromARGB(255, 246, 249, 252),
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 30, 16, 30),
                                          child: Column(
                                            children: [
                                              Container(
                                                  constraints: BoxConstraints(
                                                      minWidth: 350,
                                                      maxWidth: 370,
                                                      minHeight: 300,
                                                      maxHeight: 330),
                                                  child: _buildDataListView()),
                                            ],
                                          ))),
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

  Widget _buildDataListView() {
    return SingleChildScrollView(
      child: DataTable(
          columns: [
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Rezervni dio',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Dodaj/Ukloni dio',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: statusLista!
                  .map((RDIsKoristenPregled e) => DataRow(cells: [
                        DataCell(
                            Text(e.nazivRezervnogDijela?.toString() ?? "")),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              //int brojac = 0;
                              setState(() {
                                e.isKoristen = _handleButtonSubmission(e);
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    e.isKoristen ? Colors.red : Colors.blue)),
                            child: Text(e.isKoristen ? "Ukloni" : "Dodaj"),
                          ),
                        ),
                      ]))
                  .toList() ??
              []),
    );
  }

/////////////////////////////////////////////////////////////////////////
  Future<void> _handleFormSubmission() async {
    _updateServisiranjeData();

    await _showDialog(context, 'Success',
        'Učitavaju se promijenjeni podaci za servisiranje...');

    await _servisiranjaDetaljiProvider?.patch(
        servisiranjeid!, servisiranjeDetalji);
  }

  Future<void> _handleSubmissionError(e) async {
    print('Kontekst greske: $e');
    await _showDialog(context, 'Error', 'Došlo je do greške!');
  }

  Future<void> _updateServisiranjeData() async {
    setState(() async {
      servisiranjeDetalji!.servisiranjeId = servisiranjeid;

      servisiranjeDetalji!.opisKvara = _opisKvaraController.text;
      servisiranjeDetalji!.preduzetaAkcija = _preduzetaAkcijaController.text;
      servisiranjeDetalji!.komentarServisera =
          _komentarServiseraController.text;

      if (statusListaSelected != null) {
        listaSelected = convertToLista(statusListaSelected!);
        servisiranjeDetalji!.rezervniDijelovi = listaSelected;
      } else {
        listaSelected = null;
        servisiranjeDetalji!.rezervniDijelovi = null;
      }

      print('Serviser(Komentar) text: ${_komentarServiseraController.text}');
    });
  }

//ovdje u buttonSubmission se smanjuje naStanju, ali mora proci kroz petlju u API-ju.
//mogla bi se obrisati e.naStanju - 1, pa dodati u petlji u API-ju
//u API-ju se povecava naStanju
  bool _handleButtonSubmission(RDIsKoristenPregled e) {
    setState(() {
      if (statusListaSelected != null) {
        if (e.isKoristen == false && (e.naStanju as int) == 0) {
          throw Exception(_showDialog(
              context, 'Error', 'Nema rezervnog dijela na stanju!'));
        } else if (e.isKoristen == false && (e.naStanju as int) > 0) {
          e.isKoristen = true;
          //e.naStanju = (e.naStanju as int) - 1;
          statusListaSelected!.add(e);
        } else {
          e.isKoristen = false;
          e.naStanju = (e.naStanju as int) + 1;
          statusListaSelected!.removeWhere(
              (element) => element.rezervniDijeloviId == e.rezervniDijeloviId);
        }
      }
    });

    return e.isKoristen;
  }

  void validateController() {
    if (!_formKey!.currentState!.validate()) {
      _showDialog(context, 'Error', 'Pogrešan unos pokušajte ponovo');
      // value is false.. textFields are rebuilt in order to show errorLabels
      return;
    } else {
      _showDialog(context, 'Success',
          'Uspješno ste editovali podatke o servisiranju!!!');
    }
  }

//1. dio konverzije
  List<RDIsKoristenPregled> convertToStatusLista(
      List<RezervniDijeloviPregled> items) {
    return items.map((item) {
      return RDIsKoristenPregled(
        rezervniDijeloviId: item.rezervniDijeloviId,
        nazivRezervnogDijela: item.nazivRezervnogDijela,
        sifraArtikla: item.sifraArtikla,
        naStanju: item.naStanju,
        nazivKategorije: item.nazivKategorije,
        isKoristen: false,
      );
    }).toList();
  }

  //konverzija u suprotnom smjeru
  List<RezervniDijeloviPregled> convertToLista(
      List<RDIsKoristenPregled> items) {
    return items.map((item) {
      return RezervniDijeloviPregled(
        rezervniDijeloviId: item.rezervniDijeloviId,
        nazivRezervnogDijela: item.nazivRezervnogDijela,
        sifraArtikla: item.sifraArtikla,
        naStanju: item.naStanju,
        nazivKategorije: item.nazivKategorije,
      );
    }).toList();
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
