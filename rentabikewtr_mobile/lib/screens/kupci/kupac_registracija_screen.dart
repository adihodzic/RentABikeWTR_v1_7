import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_mobile/main.dart';
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
  late DrzaveProvider _drzaveProvider;
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
    kupos = Kupci(kupacId: null, brojLKPasosa: null, adresa: null, grad: null);

    _drzaveProvider = context.read<DrzaveProvider>();
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
    setState(() {
      data = tmpData;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(title: title!),
            SizedBox(height: 50.0),
            //Authorization.username = _korisnickoImeController.text;
            //Authorization.password = _passwordController.text;
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: _imeController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Ime",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
            SizedBox(height: 2),
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: _prezimeController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Prezime",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
            SizedBox(height: 2),
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: _korisnickoImeController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Korisničko ime",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
            SizedBox(height: 2),
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Lozinka",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
            SizedBox(height: 2),
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: _passwordPotvrdaController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Potvrda lozinke",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
            SizedBox(height: 2),
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "e-mail adresa",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
            SizedBox(height: 2),
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: _telefonController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Telefon",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
            SizedBox(height: 2),
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: _brojLKPasosaController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Broj LK/Pasoša",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
            SizedBox(height: 2),
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: _adresaController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Adresa",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
            SizedBox(height: 2),
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: _gradController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Grad",
                    hintStyle: TextStyle(color: Colors.grey[400])),
              ),
            ),
            SizedBox(height: 2),

            Container(
              padding: EdgeInsets.all(8),
              child: DropdownButton<Drzave>(
                  hint: Text("Odaberite državu"),
                  value: _selectedValue,
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: data.map<DropdownMenuItem<Drzave>>((dod) {
                    return DropdownMenuItem<Drzave>(
                      value: dod,
                      child: Text(dod.nazivDrzave!),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (dod) {
                    setState(() {
                      _selectedValue = dod!;
                    });
                  }),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
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
                    koros.korisnickoIme = _korisnickoImeController.text;
                    koros.password = _passwordController.text;
                    koros.passwordPotvrda = _passwordPotvrdaController.text;
                  });

                  await _korisniciRegistracijaProvider.insertKupca(koros);

                  int broj = 4;
                  for (int i = 3; i >= 0; i--) {
                    broj = broj - 1;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Uspješno ste registrovani....$broj'),
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
                    kupos.brojLKPasosa = _brojLKPasosaController.text;
                    kupos.adresa = _adresaController.text;
                    kupos.grad = _gradController.text;
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
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Nisu sva polja popunjena.'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: Text("Sačuvaj"),
            ),
          ],
        ),
      ),
    );
  }
}
