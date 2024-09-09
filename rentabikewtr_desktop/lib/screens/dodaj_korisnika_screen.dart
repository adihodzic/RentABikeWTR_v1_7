import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/drzave.dart';
import 'package:rentabikewtr_desktop/model/korisniciPregled.dart';
import 'package:rentabikewtr_desktop/model/korisniciUpsert.dart';
import 'package:rentabikewtr_desktop/providers/drzave_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisnici_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';

import 'package:email_validator/email_validator.dart';
import 'package:rentabikewtr_desktop/widgets/menuAdmin.dart';
//import 'package:flutter_hooks/flutter_hooks.dart';

class DodajKorisnikaScreen extends StatefulWidget {
  DodajKorisnikaScreen({super.key});

  @override
  State<DodajKorisnikaScreen> createState() => _DodajKorisnikaScreenState();
}

class _DodajKorisnikaScreenState extends State<DodajKorisnikaScreen> {
  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _korisnickoImeController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _datePickerController = TextEditingController();
  DateTime? pickedDate = DateTime.now();
  TextEditingController _date2Controller = TextEditingController();
  TextEditingController _passwordPotvrdaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  List<KorisniciPregled> korisniciPregled = [];

  List<Drzave>? drzave = [];
  Drzave? _selectedDrzava;
  DrzaveProvider? _drzaveProvider = null;
  KorisniciProvider? _korisniciProvider = null;
  KorisniciPregledProvider? _korisniciPregledProvider = null;
  KorisniciUpsert? korisnik;
  GlobalKey<FormState>? _formKey; // potrebno za validaciju
  //bool isEmail(String input) => EmailValidator.validate(input);
  bool isEmail(String input) {
    if (EmailValidator.validate(input)) {
      // potrebno za validaciju
      return true;
    } else {
      return false;
    }
  }

  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input); // potrebno za validaciju

  bool dupliEmail = true;
  bool duploKorIme = true;

  //TextEditingController _date = TextEditingController();

  @override
  void initState() {
    _formKey = GlobalKey(); // potrebno za validaciju
    _drzaveProvider = context.read<DrzaveProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _korisniciPregledProvider = context.read<KorisniciPregledProvider>();

    korisnik = KorisniciUpsert(
        korisnickoIme: null,
        password: null,
        ime: null,
        prezime: null,
        aktivan: true,
        telefon: null,
        email: null,
        drzavaID: null,
        datumRegistracije: DateTime.now(),
        ulogaID: 2);
    //kupos = Kupci(kupacId: null, brojLKPasosa: null, adresa: null, grad: null);
    loadData();
    setState(() {
      DateTime? pickedDate = DateTime.now();
      _datePickerController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    });
    super.initState();
  }

  Future loadData() async {
    var tmpData = await _drzaveProvider?.get();
    var tmpkorisniciPregled = await _korisniciPregledProvider?.get();
    setState(() {
      drzave = tmpData!;
      korisniciPregled = tmpkorisniciPregled!;
    });
  }
  //var datumRegistracije= _DatePickerContreo

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
                  child: MenuAdmin(),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(children: [
                            // Image.network("https://www.fit.ba/content/public/images/og-image.jpg", height: 100, width: 100,),
                            Image.asset(
                              "assets/images/logo.jpg",
                              height: 50,
                              width: 500,
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            Text(
                              "RentABikeWTR -Dodaj korisnika!!!",
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
                              children: [
                                Container(
                                  width: 300,
                                  height: 450,
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
                                            controller: _imeController,
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
                                            controller: _prezimeController,
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
                                            controller:
                                                _korisnickoImeController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Korisničko ime",
                                                hintText:
                                                    'Unesite korisničko ime'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Korisničko ime je obavezno polje.';
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
                                            controller: _passwordController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Lozinka",
                                                hintText: 'Unesite lozinku'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Lozinka je obavezno polje.';
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
                                            controller:
                                                _passwordPotvrdaController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Potrda lozinke",
                                                hintText: 'Potvrdite lozinku'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  value !=
                                                      _passwordController
                                                          .text) {
                                                return 'Potvrda lozinke mora da bude jednaka kao i lozinka.';
                                              } else if (value
                                                      .characters.length <
                                                  3) {
                                                return 'Password should be at least 3 characters.';
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
                                // SizedBox(
                                //   width: 160,
                                // ),
                                Container(
                                  width: 300,
                                  height: 450,
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
                                            controller: _emailController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "E-mail",
                                                hintText:
                                                    'Unesite e-mail adresu'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'E-mail je obavezno polje';
                                              } else if (!isEmail(value)) {
                                                return 'Pravilno unesite e-mail.';
                                                //   } else if (isPostojeciEmail(
                                                //       value)) {
                                                //     return 'Email već postoji!';
                                              } else {
                                                return null;
                                              }
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          TextFormField(
                                            controller: _telefonController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Telefon",
                                                hintText:
                                                    'Unesite broj telefona'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty ||
                                                  !isPhone(value)) {
                                                return 'Telefon je obavezan.';
                                              } else if (value
                                                      .characters.length <
                                                  10) {
                                                return 'Telefon mora imati minimalno 10 karaktera.';
                                              } else if (isPostojeciEmail(
                                                  value)) {
                                                return 'Email već postoji';
                                              } else {
                                                return null;
                                              }
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          TextFormField(
                                            controller: _datePickerController,
                                            readOnly: true,
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
                                          SizedBox(height: 20),
                                          DropdownButtonFormField<Drzave>(
                                            decoration: InputDecoration(
                                              labelText: 'Odaberite državu',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedDrzava,
                                            onChanged: (Drzave? newValue) {
                                              setState(() {
                                                _selectedDrzava = newValue;
                                              });
                                            },
                                            items: drzave!.map((Drzave drzava) {
                                              return DropdownMenuItem<Drzave>(
                                                value: drzava,
                                                child:
                                                    Text(drzava.nazivDrzave!),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Odaberite državu';
                                              }
                                              return null;
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          SizedBox(height: 30),
                                          Row(children: [
                                            Container(
                                              width: 120,
                                              child: ElevatedButton(
                                                child: Text("Otkaži"),
                                                onPressed: () async {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DodajKorisnikaScreen(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            Container(
                                              width: 120,
                                              child: ElevatedButton(
                                                  child: Text("Snimi"),
                                                  onPressed: () async {
                                                    if (_formKey!.currentState!
                                                        .validate()) {
                                                      // potrebno za validaciju
                                                      try {
                                                        // _formKey!.currentState!
                                                        //     .validate();

                                                        setState(() {
                                                          korisnik!
                                                                  .datumRegistracije =
                                                              DateTime.now();
                                                          korisnik!.aktivan =
                                                              true;
                                                          korisnik!.drzavaID =
                                                              _selectedDrzava!
                                                                  .drzavaID;
                                                          //koros.nazivDrzave = dod!.nazivDrzave;  -- samo treba ID drzave
                                                          //Authorization.username = _usernameController.text;
                                                          dupliEmail =
                                                              isPostojeciEmail(
                                                                  _emailController
                                                                      .text);
                                                          if (!dupliEmail) {
                                                            korisnik!.email =
                                                                _emailController
                                                                    .text;
                                                          }
                                                          duploKorIme =
                                                              isPostojeceKorIme(
                                                                  _korisnickoImeController
                                                                      .text);
                                                          if (!duploKorIme) {
                                                            korisnik!
                                                                    .korisnickoIme =
                                                                _korisnickoImeController
                                                                    .text;
                                                          }
                                                          korisnik!.ime =
                                                              _imeController
                                                                  .text;
                                                          korisnik!.prezime =
                                                              _prezimeController
                                                                  .text;
                                                          korisnik!.telefon =
                                                              _telefonController
                                                                  .text;
                                                          korisnik!.ulogaID = 2;

                                                          korisnik!.password =
                                                              _passwordController
                                                                  .text;
                                                          korisnik!
                                                                  .passwordPotvrda =
                                                              _passwordPotvrdaController
                                                                  .text;
                                                        });

                                                        await _korisniciProvider
                                                            ?.insert(korisnik);
                                                        // final isValid = _formKey!
                                                        //     .currentState!
                                                        //     .validate();
                                                        // if (isValid == true) {
                                                        int broj = 4;
                                                        for (int i = 3;
                                                            i >= 0;
                                                            i--) {
                                                          broj = broj - 1;
                                                        }

                                                        _showDialog(
                                                            context,
                                                            'Success',
                                                            'Uspješno ste kreirali novog korisnika');
                                                        // await Navigator
                                                        //     .pushReplacementNamed(
                                                        //   context,
                                                        //   "${AdminPortalScreen.routeName}",
                                                        await Navigator.of(
                                                                context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                AdminPortalScreen(),
                                                          ),
                                                        );
                                                      } catch (e) {
                                                        if (dupliEmail) {
                                                          _emailController
                                                              .text = "";
                                                          _showDialog(
                                                              context,
                                                              'Error',
                                                              'Email već postoji!');
                                                        }
                                                        if (duploKorIme) {
                                                          _korisnickoImeController
                                                              .text = "";
                                                          _showDialog(
                                                              context,
                                                              'Error',
                                                              'Korisničko ime već postoji!');
                                                        }
                                                      }
                                                    }
                                                  }),
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
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
                            padding:
                                const EdgeInsets.fromLTRB(100, 16, 100, 30),
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
      ),
    );
  }

  bool isPostojeciEmail(String input) {
    var brojac = 0;
    for (var kor in korisniciPregled) {
      if (input == kor.email) {
        brojac = brojac + 1;
      }
    }
    if (brojac > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isPostojeceKorIme(String input) {
    var brojac = 0;
    for (var kor in korisniciPregled) {
      if (input == kor.korisnickoIme) {
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
      _showDialog(context, 'Success', 'Uspješno ste kreirali novog korisnika');
    }
    // action WHEN values are valid
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

class MenuAcceleratorApp extends StatelessWidget {
  const MenuAcceleratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          const SingleActivator(LogicalKeyboardKey.keyT, control: true):
              VoidCallbackIntent(() {
            debugDumpApp();
          }),
        },
        child: const Scaffold(body: SafeArea(child: AdminPortalScreen())),
      ),
    );
  }
}
