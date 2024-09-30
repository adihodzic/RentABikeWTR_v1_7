import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/model/mojProfilArguments.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_mojeRezervacije_screen.dart';
import 'package:rentabikewtr_mobile/utils/util.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rentabikewtr_mobile/main.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_list_screen.dart';
import 'package:rentabikewtr_mobile/widgets/kupac_drawer.dart';
import 'package:rentabikewtr_mobile/widgets/master_screen.dart';
import 'package:rentabikewtr_mobile/widgets/header_widget.dart';

import '../../model/bicikli.dart';
import '../../model/drzave.dart';
import '../../model/korisnici.dart';
import '../../model/korisniciUpsert.dart';
import '../../model/kupci.dart';
//import '../../model/kupciSearch.dart';
import '../../model/kupciProfil.dart';
import '../../providers/drzave_provider.dart';
import '../../providers/korisniciProfilUpdate_provider.dart';
import '../../providers/korisniciProfil_provider.dart';
import '../../providers/korisnici_provider.dart';
//import '../../providers/kupciSearch_provider.dart';
import '../../providers/kupciProfil_provider.dart';
import '../../providers/kupci_provider.dart';
import '../../providers/bicikli_provider.dart';
import 'kupac_pocetna_screen.dart';

class KupacMojProfilScreen extends StatefulWidget {
  static const String routeName = "/moj_profil";
  //final MojProfilArguments mojProfilArguments;
  final KorisniciProfil argumentsKor;

  //final Kupci argumentsKup;
  KupacMojProfilScreen({Key? key, required this.argumentsKor})
      : super(key: key);

  @override
  State<KupacMojProfilScreen> createState() => _KupacMojProfilScreenState();
}

class _KupacMojProfilScreenState extends State<KupacMojProfilScreen> {
  String? title;
  late DrzaveProvider _drzaveProvider;
  //late BicikliProvider _bicikliProvider;
  KupciProvider? _kupciProvider;
  //late KupciSearchProvider _kupciSearchProvider;
  late KorisniciProfilProvider _korisniciProfilProvider;
  late KorisniciProfilUpdateProvider _korisniciProfilUpdateProvider;
  KupciProfilProvider? _kupciProfilProvider;
  late KorisniciProvider _korisniciProvider;
  // late Future<Korisnici?> _korisniciFuture;
  // late Future<Kupci?> _kupciFuture;
  //KorisniciUpsert koros = KorisniciUpsert();
  List<Korisnici> korisniciPregled = [];

  KorisniciProfil? korosProfil; // = KorisniciProfil();
  List<KupciProfil> dataKupci = [];
  KupciProfil? kuposProfil;
  //late Kupci? kupos;
  Kupci? kupos;
  //
  //Kupci? kupciData = Kupci();

  int drzavaid = 0;
  var dateReg = DateTime.now();
  String? _selectedValue;
  String? _selectedSpol;
  List<String> listaSpol = [];

  //Drzave _selectedValue = Drzave(); - ovako izbacuje gresku should be exactly one item, or two or zero..na dropdown-u
  List<Drzave> data = [];
  //List<Kupci> dataKupci = [];
  Drzave? dod;
  int currentIndex = 0;
  var dupliEmail = false;

  TextEditingController _korisnickoImeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordPotvrdaController = TextEditingController();
  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();
  TextEditingController _brojLKPasosaController = TextEditingController();
  TextEditingController _gradController = TextEditingController();
  TextEditingController _adresaController = TextEditingController();
  //TextEditingController _spolController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    title =
        '${widget.argumentsKor.ime!}' + ' ' + '${widget.argumentsKor.prezime!}';
    super.initState();

    // kupos = KorisniciProfil(
    //     kupacId: widget.argumentsKor.korisnikId,
    //     brojLKPasosa: null,
    //     adresa: null,
    //     grad: null);

    _drzaveProvider = context.read<DrzaveProvider>();
    _korisniciProfilProvider = context.read<KorisniciProfilProvider>();
    _korisniciProfilUpdateProvider =
        context.read<KorisniciProfilUpdateProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _kupciProvider = context.read<KupciProvider>();
    //_kupciProfilProvider = context.read<KupciProfilProvider>();

    // loadDataKupci();
    //loadDataDrzave();
    //loadKupac();

    //kupos = dataKupci;

    //'${widget.argumentsKor.ime} + ${widget.argumentsKor.prezime}';

    _korisnickoImeController.text = widget.argumentsKor.korisnickoIme!;
    // _passwordController.text = "";
    //_passwordPotvrdaController.text = "";
    _imeController.text = widget.argumentsKor.ime!;
    _prezimeController.text = widget.argumentsKor.prezime!;
    _emailController.text = widget.argumentsKor.email!;
    _telefonController.text = widget.argumentsKor.telefon!;
    drzavaid = widget.argumentsKor.drzavaID!;
    dateReg = widget.argumentsKor.datumRegistracije!;
    _korisniciProfilUpdateProvider = Provider.of<KorisniciProfilUpdateProvider>(
        context,
        listen: false); //ovo mi je vazan red za inic providera
    _kupciProfilProvider = Provider.of<KupciProfilProvider>(context,
        listen: false); // ovo mi je vazan red
    loadKupac();

    //_controller.text = 'Complete the story from here...';

    print("called initState");
  }

  // Future<void> loadDataDrzave() async {
  //   var tmpData = await _drzaveProvider.get(null);

  //   setState(() {
  //     data = tmpData;
  //   });
  // }

  Future<void> loadKupac() async {
    var tmpKorisniciPregled = await _korisniciProvider.get();
    var tmpKupac = await _kupciProfilProvider!.getById(
        widget.argumentsKor.korisnikId ??
            1); //widget.argumentsKor.korisnikId!);
    //kupos = await _kupciProvider.getById(widget.argumentsKor.korisnikId ?? 1)
    //as Kupci;
    //nisam await-ao kupce i zato mi se javljala greska
    //null check operator on null value!!!!!!!!!!!!!!!!!
    setState(() {
      korisniciPregled = tmpKorisniciPregled;
      kuposProfil = tmpKupac;
      _brojLKPasosaController.text = kuposProfil!.brojLKPasosa!;
      _gradController.text = kuposProfil!.grad!;
      _adresaController.text = kuposProfil!.adresa!;

      listaSpol = ["Muski", "Zenski"];
      _selectedSpol = kuposProfil!.spol!;
      _selectedValue =
          _selectedSpol!.isNotEmpty && listaSpol.contains(_selectedSpol)
              ? _selectedSpol
              : null;
      // kuposProfil = tmpKupac as KupciProfil;
    });
  }

  @override
  Widget build(BuildContext context) {
    //GETBYID definitivno ne moze ici na initial state...
    // if (kuposProfil != null) {
    //   _brojLKPasosaController.text = kuposProfil!.brojLKPasosa!;
    //   _gradController.text = kuposProfil!.grad!;
    //   _adresaController.text = kuposProfil!.adresa!;
    //   // _selectedSpol = kuposProfil!.spol!;
    //   // _selectedValue =
    //   //     _selectedSpol!.isNotEmpty && listaSpol.contains(_selectedSpol)
    //   //         ? _selectedSpol
    //   //         : null;
    //   // listaSpol.add("Muski");
    //   // listaSpol.add("Zenski");
    //   listaSpol = ["Muski", "Zenski"];
    // }

    return MasterScreenWidget(
      argumentsKor: widget.argumentsKor,
      // appBar: AppBar(
      //   title: Text('RentABikeWTR '),
      // ),
      // drawer: KupacDrawer(
      //   argumentsKor: widget.argumentsKor,
      // ),
      // //////////////////////////////////////////////////
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_bag),
      //       label: 'Moje rezervacije',
      //     ),
      //   ],
      //   selectedItemColor: Colors.amber[800],
      //   currentIndex: currentIndex,
      //   onTap: _onItemTapped,
      // ),
      /////////////////////////////////////////////////////
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                HeaderWidget(
                  title: title!,
                ),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    'assets/images/logo7.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ]),
              SizedBox(height: 20.0),
              //Authorization.username = _korisnickoImeController.text;
              //Authorization.password = _passwordController.text;
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: false,
                    controller: _imeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Ime",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Unesite model',
                      counterText: "", //sakriven counter od maxLength
                      suffixIcon: Icon(Icons.person),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ime je obavezno polje.';
                      } else if (value.characters.length < 3) {
                        return 'Mora da sadrži minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: false,
                    controller: _prezimeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Prezime",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Unesite model',
                      counterText: "", //sakriven counter od maxLength
                      suffixIcon: Icon(Icons.person),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Prezime je obavezno polje.';
                      } else if (value.characters.length < 3) {
                        return 'Mora da sadrži minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    controller: _korisnickoImeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Korisničko ime",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Unesite model',
                      counterText: "", //sakriven counter od maxLength
                      suffixIcon: Icon(Icons.person),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Prezime je obavezno polje.';
                      } else if (value.characters.length < 3) {
                        return 'Mora da sadrži minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: false,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Lozinka",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Unesite lozinku',
                      counterText: "", //sakriven counter od maxLength
                      suffixIcon: Icon(Icons.password),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    maxLength: 20,
                    validator: (value) {
                      if (value!.isNotEmpty && value!.characters.length < 3) {
                        return 'Minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },

                    //   if (value == null || value.isEmpty) {
                    //     return 'Lozinka je obavezno polje.';
                    //   } else if (value.characters.length < 3) {
                    //     return 'Minimalno 3(tri) karaktera.';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ),

              SizedBox(height: 2),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: false,
                    controller: _passwordPotvrdaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Potvrda Lozinke",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Unesite lozinku',
                      counterText: "", //sakriven counter od maxLength
                      suffixIcon: Icon(Icons.password),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    maxLength: 20,
                    // validator: (value) {
                    //   if (value!.compareTo(_passwordController.text) == 0) {
                    //     return 'Potvrda mora biti ista kao i lozinka.';
                    //   } else {
                    //     return null;
                    //   }
                    //}
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Lozinka je obavezno polje.';
                    //   } else if (value.characters.length < 3) {
                    //     return 'Minimalno 3(tri) karaktera.';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ),

              SizedBox(
                height: 2,
              ),

              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: false,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "E-mail",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Unesite e-mail adresu',
                      counterText: "", //sakriven counter od maxLength
                      suffixIcon: Icon(Icons.mail),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'E-mail je obavezan.';
                      } else if (value.characters.length < 10) {
                        return 'E-mail mora imati minimalno 10 karaktera.';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    style: TextStyle(color: Colors.blue),
                    decoration: InputDecoration(
                      hintText: '$_selectedSpol',
                      hintStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedValue,
                    //value: _selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue;
                      });
                    },
                    items: listaSpol.map((String spolobj) {
                      //bilo je Drzave drzava
                      return DropdownMenuItem<String>(
                        value: spolobj,
                        //value: drzava,
                        child: Text(spolobj),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Odaberite spol';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: false,
                    controller: _telefonController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Telefon",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Unesite broj telefona',
                      counterText: "", //sakriven counter od maxLength
                      suffixIcon: Icon(Icons.phone),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Telefon je obavezno polje.';
                      } else if (value.characters.length < 3) {
                        return 'Mora da sadrži minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: false,
                    controller: _brojLKPasosaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Broj LK/Pasoša",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Unesite broj LK ili pasoša',
                      counterText: "", //sakriven counter od maxLength
                      suffixIcon: Icon(Icons.book),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo je obavezno polje.';
                      } else if (value.characters.length < 3) {
                        return 'Mora da sadrži minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: false,
                    controller: _adresaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Adresa",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Unesite adresu',
                      counterText: "", //sakriven counter od maxLength
                      suffixIcon: Icon(Icons.location_pin),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Adresa je obavezno polje.';
                      } else if (value.characters.length < 3) {
                        return 'Mora da sadrži minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Color.fromARGB(255, 246, 249, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: false,
                    controller: _gradController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Grad",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Unesite naziv grada',
                      counterText: "", //sakriven counter od maxLength
                      suffixIcon: Icon(Icons.location_city),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Grad je obavezno polje.';
                      } else if (value.characters.length < 3) {
                        return 'Mora da sadrži minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //color: Color.fromRGBO(143, 148, 251, .6),
                      color: Color.fromARGB(233, 120, 180, 229),

                      child: Padding(
                        padding: const EdgeInsets.all(20.0), //prosiren inkWell
                        child: InkWell(
                          child: Center(
                              child: Text("Sačuvaj",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                await _handleFormSubmission();

                                await Navigator.pushReplacementNamed(
                                    context, KupacPocetnaScreen.routeName,
                                    arguments: widget.argumentsKor);
                              } catch (e) {
                                await _handleSubmissionError(e);
                              }
                            }
                          },
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
    );
  }

  Future<void> _handleFormSubmission() async {
    // try{
    await _updateKorisnikData();
    await _korisniciProfilUpdateProvider.update(
        widget.argumentsKor.korisnikId!, widget.argumentsKor);

    int broj = 4;
    for (int i = 3; i >= 0; i--) {
      broj = broj - 1;
    }
    if (_passwordController.text != null) {
      Authorization.password = _passwordController.text;
    }
    await _kupciProfilProvider?.update(
        widget.argumentsKor.korisnikId!, kuposProfil!);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
          'Uspješno ste izmijenili svoj profil!!! Učitavanje aplikacije...'),
      backgroundColor: Colors.blue,
    ));
    // }catch(e){
    //_showDialog(context, "Greška", e.toString());
    // }
  }

  Future<void> _updateKorisnikData() async {
    setState(() {
      //turistRuta!.statusID = 1;

      widget.argumentsKor.aktivan = true;
      //widget.argumentsKor.email = _emailController.text;
      if (_emailController.text != widget.argumentsKor.email &&
          isPostojeciEmail(_emailController.text)) {
        dupliEmail = true;
        //_emailController.text = "";
        throw Exception(); // ovo mi je bitno da odmah baci exception, da ne prođe na API
        //nije ubace tekst zbog naredne poruke
      } else {
        widget.argumentsKor!.email = _emailController.text;
      }
      widget.argumentsKor.ime = _imeController.text;
      widget.argumentsKor.prezime = _prezimeController.text;
      widget.argumentsKor.telefon = _telefonController.text;
      widget.argumentsKor.drzavaID = drzavaid;
      widget.argumentsKor.datumRegistracije = dateReg;
      var password = _passwordController.text;
      var passwordPotvrda = _passwordPotvrdaController.text;
      if (password != null) {
        widget.argumentsKor.password = _passwordController.text;
        widget.argumentsKor.passwordPotvrda = _passwordPotvrdaController.text;
      }
      if (password != passwordPotvrda) {
        throw Exception("Lozinke moraju biti iste!!!");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //       content:
        //           Text('Lozinke moraju biti iste!!! Unesite ponovo lozinku...'),
        //       backgroundColor: Color.fromARGB(255, 177, 43, 77)),
        // );
      }

      kuposProfil!.adresa = _adresaController.text;
      kuposProfil!.brojLKPasosa = _brojLKPasosaController.text;
      kuposProfil!.grad = _gradController.text;
      kuposProfil!.spol = _selectedValue;
    });
  }

  Future<void> _handleSubmissionError(e) async {
    if (dupliEmail) {
      //   _nazivController.text = "";
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('E-mail već postoji'),
        backgroundColor: Colors.red,
      ));
    } else if (_passwordController.text != _passwordPotvrdaController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Potvrda i lozinka moraju biti iste!'),
        backgroundColor: Colors.red,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Došlo je do greške'),
        backgroundColor: Colors.red,
      ));
      print('Greška:Poruka o kontekstu greške $e');
    }
  }

  Widget _buildHeader() {
    return Container(
      // alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        '${widget.argumentsKor.ime!}' + ' ' + '${widget.argumentsKor.prezime!}',
        style: TextStyle(
            color: Color.fromARGB(233, 120, 180, 229),
            fontSize: 30,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    if (currentIndex == 0) {
      Navigator.pushNamed(context, KupacPocetnaScreen.routeName,
          arguments: widget.argumentsKor);
    } else if (currentIndex == 1) {
      Navigator.pushNamed(context, KupacMojeRezervacijeScreen.routeName,
          arguments: widget.argumentsKor);
      // } else if (currentIndex == 2) {
      //   Navigator.pushNamed(context, KupacMojeRezervacijeDetailsScreen.routeName);
      // }
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

  void validateController() {
    if (!_formKey!.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('E-mail već postoji.'),
        backgroundColor: Colors.red,
      ));
      // value is false.. textFields are rebuilt in order to show errorLabels
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Uspješno ste editovali korisnika.'),
        backgroundColor: Colors.blue,
      ));
    }
    // action WHEN values are valid
  }
}
