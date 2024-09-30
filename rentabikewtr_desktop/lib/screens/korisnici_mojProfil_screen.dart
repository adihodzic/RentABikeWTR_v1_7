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
import 'package:rentabikewtr_desktop/providers/drzave_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisnici_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class KorisniciMojProfilScreen extends StatefulWidget {
  // final KorisniciPregled argumentsK;
  const KorisniciMojProfilScreen({super.key});

  @override
  State<KorisniciMojProfilScreen> createState() =>
      _KorisniciMojProfilScreenState();
}

class _KorisniciMojProfilScreenState extends State<KorisniciMojProfilScreen> {
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
  KorisniciDetalji? argumentsKor; //-- ako koristimo prosljeđivanje objekta

  List<KorisniciPregled> korisniciPregled = [];

  List<Drzave>? drzave = [];
  Drzave? _selectedDrzava;
  Drzave? _selectedValue;
  String? _nazivDrzave;
  //Drzave _selectedDrzava = Drzave();
  int drzavaid = 0;
  var dateReg = DateTime.now();
  int? korisnikid;
  DrzaveProvider? _drzaveProvider = null;
  KorisniciProvider? _korisniciProvider = null;
  KorisniciDetaljiProvider? _korisniciDetaljiProvider = null;
  KorisniciPregledProvider? _korisniciPregledProvider = null;
  //KorisniciUpsert? korisnik;
  KorisniciDetalji? korisnikDetalji;
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

    _korisniciDetaljiProvider =
        Provider.of<KorisniciDetaljiProvider>(context, listen: false);
    loadKorisnikDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {
      //DateTime? pickedDate = DateTime.now();
      //_datePickerController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    });
    super.initState();
  }

  Future<void> loadKorisnikDetalji() async {
    //argumentsKor!.korisnickoIme = widget.argumentsK.korisnickoIme;
    var tmpkorisniciDetalji = await _korisniciDetaljiProvider
        ?.getProfilKorisnika(Authorization.username!);
    // var tmpkorisnikDetalji = await _korisniciDetaljiProvider
    //     ?.getById(tmpkorisniciDetalji![0].korisnikId!);

    //widget.argumentsKor.korisnikId!);
    var tmpData = await _drzaveProvider?.get();
    var tmpkorisniciPregled = await _korisniciPregledProvider?.get();
    var tmpSelectedDrzava =
        await _drzaveProvider?.getById(tmpkorisniciDetalji!.drzavaID!);

    setState(() {
      korisnikDetalji = tmpkorisniciDetalji;
      drzave = tmpData;
      _selectedDrzava = tmpSelectedDrzava;
      _nazivDrzave = _selectedDrzava!.nazivDrzave;
      _korisnickoImeController.text = korisnikDetalji!.korisnickoIme!;

      korisnikid = korisnikDetalji!.korisnikId;
      _imeController.text = korisnikDetalji!.ime!;
      _prezimeController.text = korisnikDetalji!.prezime!;
      _emailController.text = korisnikDetalji!.email!;
      _telefonController.text = korisnikDetalji!.telefon!;
      drzavaid = korisnikDetalji!.drzavaID!;
      _datePickerController.text =
          DateFormat('dd-MM-yyyy').format(korisnikDetalji!.datumRegistracije!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
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
                    child: Container(
                      color: Colors.white,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(children: [
                            Image.asset(
                              "assets/images/logo.jpg",
                              height: 50,
                              width: 500,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "RentABikeWTR -Moj profil!!!",
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
                                            readOnly: true,
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
                                          SizedBox(
                                            height: 10,
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
                                            readOnly: true,
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
                                              } else if (!isPhone(value)) {
                                                return 'Nepravilan format';
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
                                                          RadnikPortalScreen(),
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
                                                      try {
                                                        await _handleFormSubmission();
                                                        await Navigator.of(
                                                                context)
                                                            .push(MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        KorisniciMojProfilScreen()));
                                                      } catch (e) {
                                                        await _handleSubmissionError(
                                                            e);
                                                        await Navigator.of(
                                                                context)
                                                            .push(MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        KorisniciMojProfilScreen()));
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

  Future<void> _handleFormSubmission() async {
    // try{
    await _updateKorisnikData();
    await _korisniciDetaljiProvider?.patch(korisnikid!, korisnikDetalji);

    if (_passwordController.text != null) {
      Authorization.password = _passwordController.text;
    }

    _showDialog(context, 'Success', 'Uspješnp ste editovali profil!');
    int broj = 4;
    for (int i = 3; i >= 0; i--) {
      broj = broj - 1;
    }
  }

  Future<void> _updateKorisnikData() async {
    setState(() {
      //turistRuta!.statusID = 1;
      korisnikDetalji!.korisnikId = korisnikid;

      korisnikDetalji!.aktivan = true;
      //widget.argumentsKor.email = _emailController.text;
      if (_emailController.text != korisnikDetalji!.email &&
          isPostojeciEmail(_emailController.text)) {
        dupliEmail = true;
        //_emailController.text = "";
        throw Exception(); // ovo mi je bitno da odmah baci exception, da ne prođe na API
        //nije ubace tekst zbog naredne poruke
      } else {
        korisnikDetalji!.email = _emailController.text;
      }
      korisnikDetalji!.ime = _imeController.text;
      korisnikDetalji!.prezime = _prezimeController.text;
      korisnikDetalji!.telefon = _telefonController.text;
      if (_selectedValue != null) {
        korisnikDetalji!.drzavaID = _selectedValue!.drzavaID;
      }

      var password = _passwordController.text;
      var passwordPotvrda = _passwordPotvrdaController.text;
      if (password != null) {
        korisnikDetalji!.password = _passwordController.text;
        korisnikDetalji!.passwordPotvrda = _passwordPotvrdaController.text;
      }
      if (password != passwordPotvrda) {
        throw Exception("Lozinke moraju biti iste!!!");
      }
    });
  }

  Future<void> _handleSubmissionError(e) async {
    if (dupliEmail) {
      //   _nazivController.text = "";
      _showDialog(context, 'Greška', 'Email već postoji!');
    } else if (_passwordController.text != _passwordPotvrdaController.text) {
      _showDialog(context, 'Greška', 'Potvrda i lozinka moraju biti iste!');
    } else {
      _showDialog(context, 'Greška', 'Došlo je do greške!');
      print('Greška:Poruka o kontekstu greške $e');
    }
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

      return;
    } else {
      _showDialog(context, 'Success', 'Uspješno ste izmijenili podatke');
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
