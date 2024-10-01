//import 'dart:html';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/model/drzave.dart';
import 'package:rentabikewtr_desktop/model/korisniciDetalji.dart';
import 'package:rentabikewtr_desktop/model/korisniciPregled.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodici.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodiciUpsert.dart';
import 'package:rentabikewtr_desktop/providers/drzave_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisnici_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';

import 'package:rentabikewtr_desktop/widgets/menuAdmin.dart';

class VodiciDetaljiScreen extends StatefulWidget {
  final TuristickiVodici argumentsK;
  const VodiciDetaljiScreen({Key? key, required this.argumentsK})
      : super(key: key);

  @override
  State<VodiciDetaljiScreen> createState() => _VodiciDetaljiScreenState();
}

class _VodiciDetaljiScreenState extends State<VodiciDetaljiScreen> {
  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _korisnickoImeController = TextEditingController();
  TextEditingController _nazivController = TextEditingController();
  TextEditingController _jezikController = TextEditingController();
  TextEditingController _cijenaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();

  TextEditingController _datePickerController = TextEditingController();
  DateTime? pickedDate = DateTime.now();
  TextEditingController _date2Controller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordPotvrdaController = TextEditingController();

  KorisniciDetalji? argumentsKor; //-- ako koristimo prosljeđivanje objekta

  List<KorisniciPregled> korisniciPregled = [];

  List<Drzave>? drzave = [];
  Drzave? _selectedDrzava;
  Drzave? _selectedValue;
  String? _nazivDrzave;
  //Drzave _selectedDrzava = Drzave();
  int korisnikid = 0;
  int drzavaid = 0;
  var dateReg = DateTime.now();
  int? turistickiVodicid;
  DrzaveProvider? _drzaveProvider = null;
  TuristickiVodiciProvider? _turistickiVodiciProvider = null;
  TuristickiVodiciDetaljiProvider? _turistickiVodiciDetaljiProvider = null;
  KorisniciProvider? _korisniciProvider = null;
  KorisniciDetaljiProvider? _korisniciDetaljiProvider = null;
  KorisniciPregledProvider? _korisniciPregledProvider = null;
  //KorisniciUpsert? korisnik;
  KorisniciDetalji? currentUser;
  KorisniciDetalji? korisnikDetalji;
  TuristickiVodici? turistickiVodicDetalji;
  TuristickiVodiciUpsert? turistickiVodic;
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
    _korisniciProvider = context.read<KorisniciProvider>();
    _korisniciPregledProvider = context.read<KorisniciPregledProvider>();
    _korisniciDetaljiProvider = context.read<KorisniciDetaljiProvider>();
    _turistickiVodiciProvider = context.read<TuristickiVodiciProvider>();
    _turistickiVodiciDetaljiProvider =
        context.read<TuristickiVodiciDetaljiProvider>();

    _drzaveProvider = context.read<DrzaveProvider>();
    _turistickiVodiciProvider = context.read<TuristickiVodiciProvider>();
    _korisniciDetaljiProvider = context.read<KorisniciDetaljiProvider>();
    //_korisniciPregledProvider = context.read<TuristickiVodiciProvider>();
    _turistickiVodiciDetaljiProvider =
        context.read<TuristickiVodiciDetaljiProvider>();

    _turistickiVodiciDetaljiProvider =
        Provider.of<TuristickiVodiciDetaljiProvider>(context,
            listen: false); //ovo mi je vazan red za inic providera

    loadTuristickiVodicDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {
      //DateTime? pickedDate = DateTime.now();
      //_datePickerController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    });
    super.initState();
  }

  Future<void> loadTuristickiVodicDetalji() async {
    //widget.argumentsKor.korisnikId!);
    var tmpData = await _drzaveProvider?.get();
    var tmpkorisnikDetalji = await _korisniciDetaljiProvider
        ?.getProfilKorisnikaById(widget.argumentsK.turistickiVodicId!);
    var tmpSelectedDrzava =
        await _drzaveProvider?.getById(tmpkorisnikDetalji!.drzavaID!);

    setState(() {
      korisnikid = widget.argumentsK.turistickiVodicId!;
      korisnikDetalji = tmpkorisnikDetalji;
      drzave = tmpData;
      _selectedDrzava = tmpSelectedDrzava;
      _nazivDrzave = _selectedDrzava!.nazivDrzave;
      _korisnickoImeController.text = korisnikDetalji!.korisnickoIme!;
      _imeController.text = korisnikDetalji!.ime!;
      _prezimeController.text = korisnikDetalji!.prezime!;

      turistickiVodicDetalji = widget.argumentsK;
      turistickiVodicid = widget.argumentsK.turistickiVodicId;
      _nazivController.text = widget.argumentsK.naziv!;
      _jezikController.text = widget.argumentsK.jezik!;
      _emailController.text = korisnikDetalji!.email!;
      _telefonController.text = korisnikDetalji!.telefon!;
      _cijenaController.text = widget.argumentsK.cijenaVodica!.toString();
      // drzavaid = korisnikDetalji!.drzavaID!;
      _datePickerController.text =
          DateFormat('dd-MM-yyyy').format(korisnikDetalji!.datumRegistracije!);

      // kuposProfil = tmpKupac as KupciProfil;
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
                child: MenuAdmin(),
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
                            "RentABikeWTR -Uredi turističkog vodiča",
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
                                          16, 10, 16, 10),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _imeController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: _prezimeController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            controller:
                                                _korisnickoImeController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Korisničko ime",
                                                hintText: 'npr. vodicengleski'),
                                            //maxLength: 20,
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
                                          SizedBox(
                                            height: 30,
                                          ),
                                          TextFormField(
                                            controller: _passwordController,
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Lozinka",
                                                hintText: 'Unesite lozinku'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  value!.characters.length <
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
                                          TextFormField(
                                            controller:
                                                _passwordPotvrdaController,
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Potvrda lozinke",
                                                hintText: 'Potvrdite lozinku'),
                                            maxLength: 20,
                                            // validator: (value) {
                                            //   if (value == null ||
                                            //       value.isEmpty ||
                                            //       value !=
                                            //           _passwordController
                                            //               .text) {
                                            //     return 'Potvrda lozinke mora da bude jednaka kao i lozinka.';
                                            //   } else if (value
                                            //           .characters.length <
                                            //       3) {
                                            //     return 'Password should be at least 3 characters.';
                                            //   } else {
                                            //     return null;
                                            //   }
                                            // },
                                            // autovalidateMode: AutovalidateMode
                                            //     .onUserInteraction,
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
                                      maxHeight: 300),
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
                                          16, 10, 16, 10),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _nazivController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: _jezikController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: _cijenaController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
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
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            readOnly: true,
                                            controller: _emailController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "E-mail",
                                                hintText:
                                                    'Unesite e-mail adresu'),
                                            //maxLength: 20,
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
                                          SizedBox(
                                            height: 30,
                                          ),
                                          TextFormField(
                                            controller: _telefonController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Telefon",
                                                hintText:
                                                    'Unesite broj telefona'),
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
                                                return 'Nepravilan format.';
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
                                            controller: _datePickerController,
                                            readOnly: true,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      16, 0, 16, 0),
                                              border: OutlineInputBorder(),
                                              labelText:
                                                  "Kliknite za unos datuma",
                                              hintText:
                                                  'Kliknite za unos datuma',
                                              // hintText:
                                              //     "Click here to select date"
                                            ),
                                          ),
                                          SizedBox(height: 30),
                                          DropdownButtonFormField<Drzave>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      16, 0, 16, 0),
                                              hintText: '$_nazivDrzave',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedValue,
                                            //value: _selectedValue,
                                            onChanged: (Drzave? newValue) {
                                              setState(() {
                                                _selectedValue = newValue ??
                                                    _selectedDrzava!;
                                              });
                                            },
                                            items: drzave!.map((Drzave drzava) {
                                              //bilo je Drzave drzava
                                              return DropdownMenuItem<Drzave>(
                                                value: drzava,
                                                //value: drzava,
                                                child:
                                                    Text(drzava.nazivDrzave!),
                                              );
                                            }).toList(),
                                          ),
                                          SizedBox(height: 40),
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
                                                        await _showDialog(
                                                            context,
                                                            'Success',
                                                            'Uspješno ste editovali turističkog vodiča');
                                                        await Navigator.of(
                                                                context)
                                                            .push(MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ListaVodiciScreen()));
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
    _updateKorisnikData();

    await _korisniciDetaljiProvider?.patch(korisnikid, korisnikDetalji);
    // currentUser = await _korisniciDetaljiProvider
    //     ?.getProfilKorisnika(korisnikDetalji!.korisnickoIme!);
    await _showDialog(
        context, 'Success', 'Učitavaju se podaci za novog korisnika...');
    // _updateTuristickiVodicData();
    await _turistickiVodiciDetaljiProvider?.patch(
        turistickiVodicid!, turistickiVodicDetalji);
  }

  void _updateKorisnikData() {
    setState(() {
      korisnikDetalji!.korisnikId = korisnikid;
      korisnikDetalji!.aktivan = true;
      if (_selectedValue != null) {
        korisnikDetalji!.drzavaID = _selectedValue!.drzavaID;
      } else {
        korisnikDetalji!.drzavaID = _selectedDrzava!.drzavaID;
      }

      korisnikDetalji!.ime = _imeController.text;
      korisnikDetalji!.prezime = _prezimeController.text;
      korisnikDetalji!.telefon = _telefonController.text;
      korisnikDetalji!.ulogaID = 3;
      korisnikDetalji!.aktivan = true;
      // dupliEmail = isPostojeciEmail(_emailController.text);
      // if (!dupliEmail) {
      korisnikDetalji!.email = _emailController.text;
      // }

      korisnikDetalji!.korisnickoIme = _korisnickoImeController.text;

      korisnikDetalji!.ime = _imeController.text;
      korisnikDetalji!.prezime = _prezimeController.text;
      korisnikDetalji!.telefon = _telefonController.text;
      korisnikDetalji!.ulogaID = 3;
      var password = _passwordController.text;
      var passwordPotvrda = _passwordPotvrdaController.text;
      if (password != null) {
        korisnikDetalji!.password = _passwordController.text;
        korisnikDetalji!.passwordPotvrda = _passwordPotvrdaController.text;
      }
      if (password != passwordPotvrda) {
        throw Exception("Lozinke moraju biti iste!!!");
      }
      turistickiVodicDetalji!.naziv = _nazivController.text;
      turistickiVodicDetalji!.jezik = _jezikController.text;

      // Print the value of _cijenaController.text for debugging
      print('Cijena text: ${_cijenaController.text}');

      // Ensure proper parsing and handle errors
      double? parsedCijena = double.tryParse(_cijenaController.text);
      if (parsedCijena != null) {
        // Print the parsed value for debugging
        print('Parsed Cijena: $parsedCijena');

        // Assign the parsed double to cijena
        turistickiVodicDetalji!.cijenaVodica = parsedCijena;
      } else {
        // Handle invalid input if needed
        turistickiVodicDetalji!.cijenaVodica = 0.0;
      }

      // Print the final value of cijena for debugging
      print('Final Cijena: ${turistickiVodicDetalji!.cijenaVodica}');
      print('Final naziv:${turistickiVodicDetalji!.naziv} ');
      print('Final jezik:${turistickiVodicDetalji!.jezik} ');
    });
  }

  Future<void> _handleSubmissionError(e) async {
    if (_passwordController.text != _passwordPotvrdaController.text) {
      await _showDialog(
          context, 'Error', 'Lozinka i potvrda moraju biti iste!');
    } else {
      await _showDialog(context, 'Error', 'Došlo je do greške!');
      print('Greška:Poruka o kontekstu greške $e');
    }
  }

  void validateController() {
    if (!_formKey!.currentState!.validate()) {
      _showDialog(context, 'Error', 'Pogrešan unos pokušajte ponovo');

      return;
    } else {
      _showDialog(context, 'Success', 'Uspješno ste izmijenili podatke.');
    }
  }

//Ovo je ako hoću DateTime.now da imam na TextEditingController-u
  onTapFunctionNow({required BuildContext context}) async {
    DateTime? pickedDate = DateTime.now();
    _date2Controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
  }

//Ovdje omogućavamo da se klikom na textformField unese datum
  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2015),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    _date2Controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
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
