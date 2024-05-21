import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/model/mojProfilArguments.dart';
import 'package:rentabikewtr_mobile/utils/util.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rentabikewtr_mobile/main.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_list_screen.dart';

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

  KorisniciProfil? korosProfil; // = KorisniciProfil();
  List<KupciProfil> dataKupci = [];
  KupciProfil? kuposProfil;
  //late Kupci? kupos;
  Kupci? kupos;
  //
  //Kupci? kupciData = Kupci();
  Drzave? _selectedValue;
  int drzavaid = 0;
  var dateReg = DateTime.now();

  //Drzave _selectedValue = Drzave(); - ovako izbacuje gresku should be exactly one item, or two or zero..na dropdown-u
  List<Drzave> data = [];
  //List<Kupci> dataKupci = [];
  Drzave? dod;

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
    var tmpKupac = await _kupciProfilProvider!
        .getById(7); //widget.argumentsKor.korisnikId!);
    //kupos = await _kupciProvider.getById(widget.argumentsKor.korisnikId ?? 1)
    //as Kupci;
    //nisam await-ao kupce i zato mi se javljala greska
    //null check operator on null value!!!!!!!!!!!!!!!!!
    setState(() {
      kuposProfil = tmpKupac;
      // kuposProfil = tmpKupac as KupciProfil;
    });
  }

  @override
  Widget build(BuildContext context) {
    //GETBYID definitivno ne moze ici na initial state...
    if (kuposProfil != null) {
      _brojLKPasosaController.text = kuposProfil!.brojLKPasosa!;
      _gradController.text = kuposProfil!.grad!;
      _adresaController.text = kuposProfil!.adresa!;
    }

    return Scaffold(
      appBar:
          AppBar(title: Text('Moj profil'), automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                readOnly: true, // korisnicko ime kupac ne moze promijeniti
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

            // Container(
            //   padding: EdgeInsets.all(8),
            //   child: DropdownButton<Drzave>(
            //       //hint: Text("Odaberite državu"),
            //       value: _selectedValue,
            //       // = _drzaveProvider.getById(widget.argumentsKor.drzavaID!) as Drzave,
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
            SizedBox(
              height: 30,
            ),

            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  setState(() {
                    //koros!.datumRegistracije = DateTime.now();
                    widget.argumentsKor.aktivan = true;
                    //koros!.drzavaID = _selectedValue!.drzavaID;
                    // //koros.nazivDrzave = dod!.nazivDrzave;  -- samo treba ID drzave
                    // //Authorization.username = _usernameController.text;
                    widget.argumentsKor.email = _emailController.text;
                    widget.argumentsKor.ime = _imeController.text;
                    widget.argumentsKor.prezime = _prezimeController.text;
                    widget.argumentsKor.telefon = _telefonController.text;
                    widget.argumentsKor.drzavaID = drzavaid;
                    widget.argumentsKor.datumRegistracije = dateReg;
                    var password = _passwordController.text;
                    var passwordPotvrda = _passwordPotvrdaController.text;
                    if (password != null) {
                      widget.argumentsKor.password = _passwordController.text;
                      widget.argumentsKor.passwordPotvrda =
                          _passwordPotvrdaController.text;
                    }
                    if (password != passwordPotvrda) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Lozinke moraju biti iste!!! Unesite ponovo lozinku...'),
                            backgroundColor: Color.fromARGB(255, 177, 43, 77)),
                      );
                    }

                    kuposProfil!.adresa = _adresaController.text;
                    kuposProfil!.brojLKPasosa = _brojLKPasosaController.text;
                    kuposProfil!.grad = _gradController.text;

                    // koros!.ulogaID = 4;
                    // koros!.korisnickoIme = _korisnickoImeController.text;
                    // kupos = _bicikliProvider
                    //     .getById(widget.mojProfilArguments.argumentsKor!.korisnikId!) as Bicikli;

                    //koros.password = _passwordController.text;
                    //koros.passwordPotvrda = _passwordPotvrdaController.text;
                  });

                  await _korisniciProfilUpdateProvider.update(
                      widget.argumentsKor.korisnikId!, widget.argumentsKor);

                  int broj = 4;
                  for (int i = 3; i >= 0; i--) {
                    broj = broj - 1;
                  }
                  await _kupciProfilProvider?.update(
                      widget.argumentsKor.korisnikId!, kuposProfil!);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Uspješno ste izmijenili svoj profil!!! Učitavanje aplikacije...'),
                        backgroundColor: Colors.blue),
                  );

                  await Navigator.pushReplacementNamed(
                      context, KupacPocetnaScreen.routeName,
                      arguments: widget.argumentsKor);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Došlo je do greške.'),
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
