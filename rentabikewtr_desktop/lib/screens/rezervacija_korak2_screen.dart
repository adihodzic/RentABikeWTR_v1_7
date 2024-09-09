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
import 'package:rentabikewtr_desktop/model/turistickiVodici.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodiciUpsert.dart';
import 'package:rentabikewtr_desktop/providers/drzave_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisnici_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciDetalji_provider.dart';
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
import 'package:rentabikewtr_desktop/screens/rezervacija_turistRute_korak3_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class RezervacijaKorak2Screen extends StatefulWidget {
  //final ScreenArgumentsR arguments;
  RezervacijeBiciklDostupni? argumentsB;
  DateTime? datumPretrage;
  RezervacijaKorak2Screen(
      {Key? key, required this.argumentsB, required this.datumPretrage})
      : super(key: key);

  @override
  State<RezervacijaKorak2Screen> createState() =>
      _RezervacijaKorak2ScreenState();
}

class _RezervacijaKorak2ScreenState extends State<RezervacijaKorak2Screen> {
  TextEditingController _nazivBiciklaController = TextEditingController();
  TextEditingController _velicinaBiciklaController = TextEditingController();
  TextEditingController _bojaController = TextEditingController();
  TextEditingController _nazivTipaBiciklaController = TextEditingController();
  TextEditingController _nazivProizvodjacaController = TextEditingController();
  TextEditingController _nazivModelaController = TextEditingController();
  TextEditingController _cijenaController = TextEditingController();
  TextEditingController _statusBiciklaController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();
//SLIKA
  //TextEditingController _passwordController = TextEditingController();
  TextEditingController _datePickerController = TextEditingController();
  TextEditingController _vrijemePreuzimanjaPickerController =
      TextEditingController();

  TextEditingController _vrijemeVracanjaPickerController =
      TextEditingController();
  DateTime? datumPre;
  TimeOfDay? vrijeme; //= TimeOfDay(hour: 9, minute: 0);
  TimeOfDay? vrijeme2;
  bool isTRutaRez = false; // = TimeOfDay(hour: 18, minute: 0);
  RezervacijeBiciklDostupni? rezBicikliDostupni;
  // String? stringVrijeme;
  // String? stringVrijeme2;
  DateTime? pickedDate = DateTime.now();
  TextEditingController _datumPretrageController = TextEditingController();
  //REZERVACIJE TuristRute - checkBox...

  //RezervacijeUpsert? argumentsKor; //-- ako koristimo prosljeđivanje objekta

  List<KorisniciPregled> korisniciPregled = [];

  // List<Drzave>? drzave = [];
  // Drzave? _selectedDrzava;
  // Drzave? _selectedValue;
  // String? _nazivDrzave;
  // //Drzave _selectedDrzava = Drzave();
  // int korisnikid = 0;
  // int drzavaid = 0;
  // var dateReg = DateTime.now();
  // int? turistickiVodicid;
  // DrzaveProvider? _drzaveProvider = null;
  // TuristickiVodiciProvider? _turistickiVodiciProvider = null;
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

    // _drzaveProvider = context.read<DrzaveProvider>();
    // _korisniciProvider = context.read<KorisniciProvider>();
    // _korisniciPregledProvider = context.read<KorisniciPregledProvider>();
    // _korisniciDetaljiProvider = context.read<KorisniciDetaljiProvider>();
    // _turistickiVodiciProvider = context.read<TuristickiVodiciProvider>();
    // _turistickiVodiciDetaljiProvider =
    //     context.read<TuristickiVodiciDetaljiProvider>();

    // _drzaveProvider = context.read<DrzaveProvider>();
    // _turistickiVodiciProvider = context.read<TuristickiVodiciProvider>();
    // _korisniciDetaljiProvider = context.read<KorisniciDetaljiProvider>();
    // //_korisniciPregledProvider = context.read<TuristickiVodiciProvider>();
    // _turistickiVodiciDetaljiProvider =
    //     context.read<TuristickiVodiciDetaljiProvider>();

    // _turistickiVodiciDetaljiProvider =
    //     Provider.of<TuristickiVodiciDetaljiProvider>(context,
    //       listen: false); //ovo mi je vazan red za inic providera

    loadRezervacijeBiciklDostupniDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {
      //DateTime? pickedDate = DateTime.now();
      //_datePickerController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    });
    super.initState();
  }

  Future<void> loadRezervacijeBiciklDostupniDetalji() async {
    setState(() async {
      vrijeme = TimeOfDay(hour: 9, minute: 0);
      vrijeme2 = TimeOfDay(hour: 18, minute: 0);
      var stringVrijeme = vrijeme!.hour.toString().padLeft(2, '0') +
          ':' +
          vrijeme!.minute.toString().padLeft(2, '0');
      var stringVrijeme2 = vrijeme2!.hour.toString().padLeft(2, '0') +
          ':' +
          vrijeme2!.minute.toString().padLeft(2, '0');
      // stringVrijeme2 = vrijeme2!.format(context).toString();
      var biciklid = widget.argumentsB!.biciklID;
      rezBicikliDostupni = widget.argumentsB;

      _nazivBiciklaController.text = widget.argumentsB!.nazivBicikla!;
      //_velicinaBiciklaController=widget.argumentsB!.nazv
      _nazivTipaBiciklaController.text = widget.argumentsB!.nazivTipa!;
      _nazivProizvodjacaController.text = widget.argumentsB!.nazivProizvodjaca!;
      _nazivModelaController.text = widget.argumentsB!.nazivModela!;
      _bojaController.text = widget.argumentsB!.boja!;
      _cijenaController.text = widget.argumentsB!.cijenaBicikla.toString();
      datumPre = widget.datumPretrage!;
      _datumPretrageController.text =
          DateFormat('dd-MM-yyyy').format(datumPre!);
      _vrijemePreuzimanjaPickerController.text = stringVrijeme as String;
      _vrijemeVracanjaPickerController.text = stringVrijeme2 as String;
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
                            "RentABikeWTR -Rezervacija-korak 2",
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
                                      maxHeight: 370),
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
                                            controller: _nazivBiciklaController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Ime",
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
                                            controller:
                                                _nazivTipaBiciklaController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Prezime",
                                                hintText: 'Unesite prezime'),
                                            maxLength: 20,
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
                                            readOnly: true,
                                            controller:
                                                _nazivProizvodjacaController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Korisničko ime",
                                                hintText: 'npr. vodicengleski'),
                                            maxLength: 20,
                                            // validator: (value) {
                                            //   if (value == null || value.isEmpty) {
                                            //     return 'Korisničko ime je obavezno polje.';
                                            //   } else if (value.characters.length < 3) {
                                            //     return 'Mora da sadrži minimalno 3(tri) karaktera.';
                                            //   } else {
                                            //     return null;
                                            //   }
                                            // },
                                            // autovalidateMode:
                                            //     AutovalidateMode.onUserInteraction,
                                          ),
                                          TextFormField(
                                            controller: _nazivModelaController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Naziv",
                                                hintText:
                                                    'npr. Vodic-engleski'),
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
                                          TextFormField(
                                            controller: _bojaController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Jezik",
                                                hintText: 'npr. Engleski'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Jezik je obavezno polje.';
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
                                          TextFormField(
                                            controller: _cijenaController,
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
                                      maxHeight: 370),
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
                                            readOnly: true,
                                            controller:
                                                _vrijemePreuzimanjaPickerController,
                                            // initialValue:
                                            //     vrijeme!.format(context),
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText:
                                                    "Vrijeme preuzimanja",
                                                hintText: ''),
                                            maxLength: 20,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            controller:
                                                _vrijemeVracanjaPickerController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText:
                                                  "Kliknite za unos datuma",
                                              hintText:
                                                  'Kliknite za unos datuma',
                                              // hintText:
                                              //     "Click here to select date"
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          CheckboxListTile(
                                              title: Text(
                                                  "Rezervacija turist rute sa vodičem"),
                                              value: isTRutaRez,
                                              onChanged: (cekirano) {
                                                setState(() {
                                                  isTRutaRez = cekirano!;
                                                });
                                              }),
                                          SizedBox(height: 20),
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
                                                        // await _showDialog(
                                                        //     context,
                                                        //     'Success',
                                                        //     'Uspješno ste editovali $isTRutaRez');
                                                        if (isTRutaRez) {
                                                          Navigator.of(context)
                                                              .push(
                                                                  MaterialPageRoute(
                                                            builder: (context) =>
                                                                RezervacijaTuristRuteKorak3Screen(
                                                              argumentsB:
                                                                  rezBicikliDostupni,
                                                              datumPretrage:
                                                                  datumPre,
                                                            ),
                                                          ));
                                                        } else {
                                                          Navigator.of(context)
                                                              .push(
                                                                  MaterialPageRoute(
                                                            builder: (context) =>
                                                                RezervacijaKupacKorak4Screen(
                                                              argumentsB:
                                                                  rezBicikliDostupni,
                                                              datumPretrage:
                                                                  datumPre,
                                                            ),
                                                          ));
                                                        }
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
