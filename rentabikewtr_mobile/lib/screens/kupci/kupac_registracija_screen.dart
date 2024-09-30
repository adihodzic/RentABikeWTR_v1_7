import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_mobile/main.dart';
import 'package:rentabikewtr_mobile/model/godineKupci.dart';
import 'package:rentabikewtr_mobile/providers/godineKupci_provider.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_list_screen.dart';
import 'package:rentabikewtr_mobile/utils/util.dart';
import 'package:rentabikewtr_mobile/widgets/header_widget.dart';

import '../../model/drzave.dart';
import '../../model/korisniciUpsert.dart';
import '../../model/kupci.dart';
import '../../providers/drzave_provider.dart';
import '../../providers/korisniciProfil_provider.dart';
import '../../providers/korisniciRegistracija_provider.dart';
import '../../providers/korisnici_provider.dart';
import '../../providers/kupci_provider.dart';
import '../../utils/util.dart';

class KupacRegistracijaScreen extends StatefulWidget {
  static const String routeName = "/kupac_registracija";
  const KupacRegistracijaScreen({Key? key}) : super(key: key);

  @override
  State<KupacRegistracijaScreen> createState() =>
      _KupacRegistracijaScreenState();
}

class _KupacRegistracijaScreenState extends State<KupacRegistracijaScreen> {
  String title = "Registracija kupca";
  KorisniciUpsert koros = KorisniciUpsert();
  Kupci kupos = Kupci();
  Drzave? _selectedValue;
  //Drzave _selectedValue = Drzave(); - ovako izbacuje gresku should be exactly one item, or two or zero..na dropdown-u
  List<Drzave> data = [];
  Drzave? dod;
  GodineKupci? _selectedGodineValue;
  List<GodineKupci> godinekupci = [];
  GodineKupci? god;
  String? _selectedSpolValue;
  // String? _selectedSpol;
  List<String> listaSpol = [];
  late DrzaveProvider _drzaveProvider;
  late GodineKupciProvider _godineKupciProvider;
  late KorisniciRegistracijaProvider _korisniciRegistracijaProvider;
  late KupciProvider _kupciProvider;
  late KorisniciProfilProvider _korisniciProfilProvider;
  late KorisniciProvider _korisniciProvider;
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    //title = "Registracija kupca";
    Authorization.username = "test";
    Authorization.password = "test";
    koros = KorisniciUpsert(
        korisnickoIme: null,
        password: null,
        ime: null,
        prezime: null,
        aktivan: true,
        telefon: null,
        email: null,
        drzavaID: null,
        datumRegistracije: DateTime.now(),
        ulogaID: 4);
    kupos = Kupci(
        kupacId: null,
        brojLKPasosa: null,
        adresa: null,
        grad: null,
        spol: null);

    _drzaveProvider = context.read<DrzaveProvider>();
    _godineKupciProvider = context.read<GodineKupciProvider>();
    _korisniciProfilProvider = context.read<KorisniciProfilProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _korisniciRegistracijaProvider =
        context.read<KorisniciRegistracijaProvider>();
    _kupciProvider = context.read<KupciProvider>();
    print("called initState");
    loadDataDrzave();
    super.initState();
  }

  Future loadDataDrzave() async {
    var tmpData = await _drzaveProvider.get(null);
    var tmpGodineKupci = await _godineKupciProvider.get(null);
    setState(() {
      data = tmpData;
      godinekupci = tmpGodineKupci;
      listaSpol = ["Muski", "Zenski"];
      // _selectedSpolValue =
      //     _selectedSpol!.isNotEmpty && listaSpol.contains(_selectedSpol)
      //         ? _selectedSpol
      //         : null;
    });
  }
  // widget.rezos.biciklId = widget.args.argumentsBic!.biciklId;
  // widget.rezos.cijenaUsluge = 10;
  // widget.rezos.kupacID = 8; //potrebno staviti aktivnog kupca
  // widget.rezos.korisnikID = 8;
  // widget.rezos.datumIzdavanja = DateTime.now();
  // widget.rezos.vrijemePreuzimanja = DateTime.now();
  // widget.rezos.vrijemeVracanja = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // final _korisniciRegistracijaProvider =
    //     Provider.of<KorisniciRegistracijaProvider>(context);
    // final _korisniciProvider = Provider.of<KorisniciProvider>(context);
    // final _kupciProvider = Provider.of<KupciProvider>(context);
    // final _korisniciProfilProvider =
    //     Provider.of<KorisniciProfilProvider>(context);
    // final _drzaveProvider = Provider.of<DrzaveProvider>(context);
    return Scaffold(
      appBar:
          AppBar(title: Text('RentABikeWTR'), automaticallyImplyLeading: false),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(title: title!),
              SizedBox(height: 50.0),
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
                      hintText: 'Unesite ime',
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
                        return 'Minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },
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
                    controller: _prezimeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Prezime",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Unesite prezime',
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
                    controller: _korisnickoImeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Korisničko ime",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Unesite korisničko ime',
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
                        return 'Korisničko ime je obavezno polje.';
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
                      if (value == null || value.isEmpty) {
                        return 'Lozinka je obavezno polje.';
                      } else if (value.characters.length < 3) {
                        return 'Minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },
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
                      hintText: 'Potvrdite lozinku',
                      counterText: "", //sakriven counter od maxLength
                      suffixIcon: Icon(Icons.password),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    maxLength: 20,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lozinka je obavezno polje.';
                      } else if (value.characters.length < 3) {
                        return 'Minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },
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

              SizedBox(height: 2),
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
                      hintText: 'Odaberite spol',
                      hintStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedSpolValue,
                    //value: _selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSpolValue = newValue;
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
                  child: DropdownButtonFormField<GodineKupci>(
                    decoration: InputDecoration(
                      labelText: 'Odaberite godine',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedGodineValue,
                    onChanged: (GodineKupci? newValue) {
                      setState(() {
                        _selectedGodineValue = newValue;
                      });
                    },
                    items: godinekupci.map((GodineKupci godina) {
                      return DropdownMenuItem<GodineKupci>(
                        value: godina,
                        child: Text(godina.godinePoGrupama!),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Izaberite godine';
                      }
                      return null;
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
                        return 'Minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },
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
                        return 'Minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },
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
                        return 'Minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },
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
                        return 'Minimalno 3(tri) karaktera.';
                      } else {
                        return null;
                      }
                    },
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
                  child: DropdownButtonFormField<Drzave>(
                    decoration: InputDecoration(
                      labelText: 'Odaberite državu',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedValue,
                    onChanged: (Drzave? newValue) {
                      setState(() {
                        _selectedValue = newValue;
                      });
                    },
                    items: data.map((Drzave drzava) {
                      return DropdownMenuItem<Drzave>(
                        value: drzava,
                        child: Text(drzava.nazivDrzave!),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Odaberite državu';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ),

              // Container(
              //   padding: EdgeInsets.all(8),
              //   child: DropdownButton<Drzave>(
              //       hint: Text("Odaberite državu"),
              //       value: _selectedValue,
              //       icon: const Icon(Icons.keyboard_arrow_down),

              //       // Array list of items
              //       items: data.map<DropdownMenuItem<Drzave>>((dod) {
              //         return DropdownMenuItem<Drzave>(
              //           value: dod,
              //           child: Text(dod.nazivDrzave!),
              //         );
              //       }).toList(),
              //       // After selecting the desired option,it will
              //       // change button value to selected value
              //       onChanged: (dod) {
              //         setState(() {
              //           _selectedValue = dod!;
              //         });
              //       }),
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              // SizedBox(height: 30.0),
              SizedBox(
                height: 2,
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
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          child: Center(
                              child: Text("Sačuvaj",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          onTap: () async {
                            try {
                              setState(() {
                                koros.datumRegistracije = DateTime.now();
                                koros.aktivan = true;
                                koros.drzavaID = _selectedValue!.drzavaID;
                                //koros.nazivDrzave = dod!.nazivDrzave;  -- samo treba ID drzave
                                //Authorization.username = _usernameController.text;
                                koros.email = _emailController.text;
                                koros.ime = _imeController.text;
                                koros.prezime = _prezimeController.text;
                                koros.telefon = _telefonController.text;
                                koros.ulogaID = 4;
                                koros.korisnickoIme =
                                    _korisnickoImeController.text;
                                koros.password = _passwordController.text;
                                koros.passwordPotvrda =
                                    _passwordPotvrdaController.text;
                              });

                              await _korisniciRegistracijaProvider
                                  .insertKupca(koros);

                              int broj = 3;
                              for (int i = 2; i >= 0; i--) {
                                broj = broj - 1;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Uspješno ste registrovani....$broj'),
                                      backgroundColor: Colors.blue),
                                );
                              }
                              Authorization.password = koros.password;
                              Authorization.username = koros.korisnickoIme;

                              // ignore: await_only_futures
                              var currentUser = await _korisniciProfilProvider
                                  .getProfilKorisnika(koros.korisnickoIme!);
                              setState(() {
                                if (currentUser != null) {
                                  kupos.kupacId = currentUser.korisnikId;
                                }
                                kupos.brojLKPasosa =
                                    _brojLKPasosaController.text;
                                kupos.adresa = _adresaController.text;
                                kupos.grad = _gradController.text;
                                kupos.spol = _selectedSpolValue;
                                kupos.godineKupacID =
                                    _selectedGodineValue!.godineKupacId;
                              });
                              await _kupciProvider.insert(kupos);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Uspješno ste registrovani. Dobro došli u RentABikeWTR!!! Učitavanje aplikacije...'),
                                    backgroundColor: Colors.blue),
                              );
                              await Navigator.pushReplacementNamed(
                                context,
                                "${HomePage.routeName}",
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Nisu sva polja popunjena.'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          // child: Text("Sačuvaj"),
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
}
