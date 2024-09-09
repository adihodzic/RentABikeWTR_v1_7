//import 'dart:js_interop';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/drzave.dart';
import 'package:rentabikewtr_desktop/model/korisniciDetalji.dart';
import 'package:rentabikewtr_desktop/model/korisniciPregled.dart';
import 'package:rentabikewtr_desktop/model/korisniciUpsert.dart';
import 'package:rentabikewtr_desktop/model/rezervacijeBiciklDostupni.dart';
import 'package:rentabikewtr_desktop/model/screenArgumentsR.dart';
import 'package:rentabikewtr_desktop/model/turistRutePregled.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodici.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodiciUpsert.dart';
import 'package:rentabikewtr_desktop/providers/drzave_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisnici_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistRutePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_kupac_korak4_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class RezervacijaTuristRuteKorak3Screen extends StatefulWidget {
  //final ScreenArgumentsR arguments;
  RezervacijeBiciklDostupni? argumentsB;
  DateTime? datumPretrage;
  TuristRutePregled? argumentsT;
  TuristickiVodici? argumentsV;
  RezervacijaTuristRuteKorak3Screen(
      {Key? key, required this.argumentsB, required this.datumPretrage})
      : super(key: key);

  @override
  State<RezervacijaTuristRuteKorak3Screen> createState() =>
      _RezervacijaTuristRuteKorak3ScreenState();
}

class _RezervacijaTuristRuteKorak3ScreenState
    extends State<RezervacijaTuristRuteKorak3Screen> {
  TextEditingController _nazivBiciklaController = TextEditingController();
  TextEditingController _velicinaBiciklaController = TextEditingController();
  TextEditingController _bojaController = TextEditingController();
  TextEditingController _nazivTipaBiciklaController = TextEditingController();
  TextEditingController _nazivProizvodjacaController = TextEditingController();
  TextEditingController _nazivModelaController = TextEditingController();
  TextEditingController _cijenaVodicaController = TextEditingController();
  TextEditingController _cijenaRuteController = TextEditingController();
  TextEditingController _opisRuteController = TextEditingController();

  TextEditingController _statusBiciklaController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();
//SLIKA
  //TextEditingController _passwordController = TextEditingController();
  TextEditingController _datePickerController = TextEditingController();
  TextEditingController _vrijemePreuzimanjaPickerController =
      TextEditingController();

  TextEditingController _vrijemeVracanjaPickerController =
      TextEditingController();
  RezervacijeBiciklDostupni? rezBiciklDostupni;

  DateTime? datumPre;
  TimeOfDay? vrijeme; //= TimeOfDay(hour: 9, minute: 0);
  TimeOfDay? vrijeme2;
  bool isTRutaRez = false; // = TimeOfDay(hour: 18, minute: 0);

  // String? stringVrijeme;
  // String? stringVrijeme2;
  DateTime? pickedDate = DateTime.now();
  TextEditingController _datumPretrageController = TextEditingController();
  //REZERVACIJE TuristRute - checkBox...

  //RezervacijeUpsert? argumentsKor; //-- ako koristimo prosljeđivanje objekta
  List<TuristRutePregled> turistRute = [];
  TuristRutePregled? _selectedTuristRuta;
  TuristRutePregledProvider? _turistRutePregledProvider = null;

  List<KorisniciPregled> korisniciPregled = [];

  List<Drzave>? drzave = [];
  Drzave? _selectedDrzava;
  DrzaveProvider? _drzaveProvider = null;

  List<TuristickiVodici>? turistickiVodici = [];
  TuristickiVodici? _selectedTuristickiVodic;
  TuristickiVodiciPregledProvider? _turistickiVodiciPregledProvider = null;
  Image? slikaTuristRute;
  String? opisTuristRute;
  // TuristickiVodiciDetaljiProvider? _turistickiVodiciDetaljiProvider = null;
  // KorisniciProvider? _korisniciProvider = null;
  // KorisniciDetaljiProvider? _korisniciDetaljiProvider = null;
  // KorisniciPregledProvider? _korisniciPregledProvider = null;
  // //KorisniciUpsert? korisnik;
  // KorisniciDetalji? currentUser;
  // KorisniciDetalji? korisnikDetalji;
  // TuristickiVodici? turistickiVodicDetalji;
  // TuristickiVodiciUpsert? turistickiVodic;
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
    final RegExp regex = RegExp(r'^\d+(\.\d+)?$');
    return regex.hasMatch(input);
  } // potrebno za validaciju

  bool dupliEmail = true;
  bool duploKorIme = true;

  //TextEditingController _date = TextEditingController();

  @override
  void initState() {
    _formKey = GlobalKey();

    _drzaveProvider = context.read<DrzaveProvider>();
    _turistickiVodiciPregledProvider =
        context.read<TuristickiVodiciPregledProvider>();
    _turistRutePregledProvider = context.read<TuristRutePregledProvider>();
    // _korisniciDetaljiProvider = context.read<KorisniciDetaljiProvider>();
    // //_korisniciPregledProvider = context.read<TuristickiVodiciProvider>();
    // _turistickiVodiciDetaljiProvider =
    //     context.read<TuristickiVodiciDetaljiProvider>();

    // _turistickiVodiciDetaljiProvider =
    //     Provider.of<TuristickiVodiciDetaljiProvider>(context,
    //       listen: false); //ovo mi je vazan red za inic providera
    loadData();
    loadRezervacijeBiciklDostupniDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {
      //DateTime? pickedDate = DateTime.now();
      //_datePickerController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    });
    super.initState();
  }

  Future loadData() async {
    var tmpData = await _drzaveProvider?.get();
    var tmpVodiciData = await _turistickiVodiciPregledProvider?.get();
    var tmpTuristRute = await _turistRutePregledProvider?.get();

    setState(() {
      drzave = tmpData!;
      turistickiVodici = tmpVodiciData!;
      turistRute = tmpTuristRute!;
    });
  }

  Future<void> loadRezervacijeBiciklDostupniDetalji() async {
    setState(() async {
      // _cijenaVodicaController.text =
      //     _selectedTuristickiVodic!.cijenaVodica.toString();
      //_cijenaRuteController.text = _selectedTuristRuta!.cijenaRute.toString();

      // stringVrijeme2 = vrijeme2!.format(context).toString();
      var biciklid = widget.argumentsB!.biciklID;
      rezBiciklDostupni = widget.argumentsB;
      _nazivBiciklaController.text = widget.argumentsB!.nazivBicikla!;
      //_velicinaBiciklaController=widget.argumentsB!.nazv
      _nazivTipaBiciklaController.text = widget.argumentsB!.nazivTipa!;
      _nazivProizvodjacaController.text = widget.argumentsB!.nazivProizvodjaca!;
      _nazivModelaController.text = widget.argumentsB!.nazivModela!;
      _bojaController.text = widget.argumentsB!.boja!;

      //_cijenaVodicaController.text = null;
      datumPre = widget.datumPretrage!;
      _datumPretrageController.text =
          DateFormat('dd-MM-yyyy').format(datumPre!);
    });
  }

  // Future loadData() async {
  //   var tmpData = await _drzaveProvider?.get();
  //   var tmpkorisniciPregled = await _korisniciPregledProvider?.get();
  //   setState(() {
  //     drzave = tmpData!;
  //     korisniciPregled = tmpkorisniciPregled!;
  //   });
  // }
  //var datumRegistracije= _DatePickerContreo

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
                            height: 50,
                            width: 500,
                            child: imageFromBase64String(
                                widget.argumentsB!.slika!),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "RentABikeWTR -Rezervacija-korak 3",
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
                                      maxHeight: 330),
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
                                                _datumPretrageController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Datum pretrage",
                                                hintText: ''),
                                            maxLength: 20,
                                            // validator: (value) {
                                            //   if (value == null || value.isEmpty) {
                                            //     return 'E-mail je obavezno polje';
                                            //   } else if (!isEmail(value)) {
                                            //     return 'Pravilno unesite e-mail.';
                                            //     //   } else if (isPostojeciEmail(
                                            //     //       value)) {
                                            //     //     return 'Email već postoji!';
                                            //   } else {
                                            //     return null;
                                            //   }
                                            // },
                                            // autovalidateMode:
                                            //     AutovalidateMode.onUserInteraction,
                                          ),
                                          DropdownButtonFormField<
                                              TuristickiVodici>(
                                            decoration: InputDecoration(
                                              labelText: 'Odaberite Vodica',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedTuristickiVodic,
                                            onChanged:
                                                (TuristickiVodici? newValue) {
                                              setState(() {
                                                _selectedTuristickiVodic =
                                                    newValue;
                                                _cijenaVodicaController?.text =
                                                    newValue!.cijenaVodica
                                                        .toString();
                                              });
                                            },
                                            items: turistickiVodici!.map(
                                                (TuristickiVodici
                                                    turistickiVodic) {
                                              return DropdownMenuItem<
                                                  TuristickiVodici>(
                                                value: turistickiVodic,
                                                child: Text(
                                                    turistickiVodic.naziv!),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Odaberite vodica';
                                              }
                                              return null;
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            readOnly: true,
                                            controller: _cijenaVodicaController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText:
                                                    "Cijena turističkog vodiča",
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 160,
                              // ),
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth: 300,
                                      minHeight: 100,
                                      maxHeight: 330),
                                  // width: 300,
                                  // height: 300,
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
                                          DropdownButtonFormField<
                                              TuristRutePregled>(
                                            decoration: InputDecoration(
                                              labelText:
                                                  'Odaberite turist rutu',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedTuristRuta,
                                            onChanged:
                                                (TuristRutePregled? newValue) {
                                              setState(() {
                                                _selectedTuristRuta = newValue;
                                                _cijenaRuteController.text =
                                                    newValue!.cijenaRute
                                                        .toString();
                                                slikaTuristRute =
                                                    imageFromBase64String(
                                                        newValue!.slikaRute!);
                                                _opisRuteController.text =
                                                    newValue.opisRute!;
                                              });
                                            },
                                            items: turistRute!.map(
                                                (TuristRutePregled turistRuta) {
                                              return DropdownMenuItem<
                                                  TuristRutePregled>(
                                                value: turistRuta,
                                                child: Text(turistRuta.naziv!),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Odaberite turist rutu';
                                              }
                                              return null;
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          SizedBox(height: 20),
                                          TextFormField(
                                            controller: _cijenaRuteController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Cijena turist rute",
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
                                          TextFormField(
                                            readOnly: true,
                                            controller: _opisRuteController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "Opis turist rute",
                                              hintText: '',
                                            ),
                                            maxLines: null,
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLength: 70,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Cijena je obavezno polje.';
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
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth: 300,
                                      minHeight: 100,
                                      maxHeight: 330),
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
                                          Text(
                                            "Slika turist rute:",
                                            style: TextStyle(
                                              //fontSize: 30,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            //fontStyle: FontStyle.italic,
                                            //color: Color.fromARGB(255, 11, 7, 255)),
                                          ),
                                          Container(
                                            height: 150,
                                            width: 200,
                                            child: slikaTuristRute,
                                          ),
                                          SizedBox(
                                            height: 20,
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
                                                  child: Text("Nazad ..."),
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                    // MaterialPageRoute(
                                                    //   builder: (context) =>
                                                    //       ListaVodiciScreen(),
                                                    //),
                                                    //);
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
                                                  child: Text("Dalje ..."),
                                                  onPressed: () async {
                                                    if (_formKey!.currentState!
                                                        .validate()) {
                                                      try {
                                                        await _handleFormSubmission();
                                                        await _showDialog(
                                                            context,
                                                            'Success',
                                                            'Uspješno ste editovali turističko vodiča');

                                                        await Navigator.of(
                                                                context)
                                                            .push(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              RezervacijaKupacKorak4Screen(
                                                            argumentsB:
                                                                rezBiciklDostupni,
                                                            argumentsT:
                                                                _selectedTuristRuta,
                                                            argumentsV:
                                                                _selectedTuristickiVodic,
                                                            datumPretrage:
                                                                datumPre,
                                                          ),
                                                        ));
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
    _updateRezervacijaData();

    // await _korisniciDetaljiProvider?.patch(korisnikid, korisnikDetalji);
    // currentUser = await _korisniciDetaljiProvider
    //     ?.getProfilKorisnika(korisnikDetalji!.korisnickoIme!);
    await _showDialog(
        context, 'Success', 'Učitavaju se podaci za novog korisnika...');
    // // _updateTuristickiVodicData();
    // await _turistickiVodiciDetaljiProvider?.patch(
    //     turistickiVodicid!, turistickiVodicDetalji);
  }

  void _updateRezervacijaData() {}

  Future<void> _handleSubmissionError(e) async {
    await _showDialog(context, 'Error', 'Došlo je do greške!');
  }

  void validateController() {
    if (!_formKey!.currentState!.validate()) {
      _showDialog(context, 'Error', 'Pogrešan unos pokušajte ponovo');
      // value is false.. textFields are rebuilt in order to show errorLabels
      return;
    } else {
      _showDialog(context, 'Success', 'Uspješno ste kreirali novog korisnika');
    }
    // action WHEN values are valid
  }

//Ovo je ako hoću DateTime.now da imam na TextEditingController-u
  onTapFunctionNow({required BuildContext context}) async {
    // DateTime? pickedDate = DateTime.now();
    // _date2Controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
  }

//Ovdje omogućavamo da se klikom na textformField unese datum
  onTapFunction({required BuildContext context}) async {}

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
