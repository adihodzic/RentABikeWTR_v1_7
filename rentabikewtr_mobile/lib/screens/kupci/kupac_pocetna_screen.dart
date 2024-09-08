//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rentabikewtr_mobile/main.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/model/mojProfilArguments.dart';
import 'package:rentabikewtr_mobile/model/turistickiVodici.dart';
import 'package:rentabikewtr_mobile/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_details_screen.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_list_screen.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_mojeRezervacije_details_screen.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_mojeRezervacije_screen.dart';
import 'package:rentabikewtr_mobile/screens/rezervacije/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_mobile/widgets/kupac_drawer.dart';
import 'package:rentabikewtr_mobile/widgets/master_screen.dart';
import 'package:rentabikewtr_mobile/widgets/header_widget.dart';

import '../../model/bicikli.dart';
import '../../model/korisnici.dart';
import '../../model/kupci.dart';
//import '../../model/kupciSearch.dart';
//import '../../providers/kupciSearch_provider.dart';
import '../../model/kupciProfil.dart';
import '../../providers/bicikli_provider.dart';
import '../../providers/kupciProfil_provider.dart';
import '../../providers/kupci_provider.dart';
import 'kupac_mojProfil_screen.dart';

class KupacPocetnaScreen extends StatefulWidget {
  static const String routeName = "/kupac_pocetna";
  KupacPocetnaScreen({Key? key, required this.argumentsKor}) : super(key: key);
  final KorisniciProfil argumentsKor;

  @override
  State<KupacPocetnaScreen> createState() => _KupacPocetnaScreenState();
}

class _KupacPocetnaScreenState extends State<KupacPocetnaScreen> {
  KupciProfil? argumentsKupci;
  KorisniciProfil? korisnik;
  String? title = "Kupac portal - Dobro došli";

  //KupciProfilProvider? _kupciProfilProvider;
  TuristickiVodiciProvider? _vodiciProvider;

  int currentIndex = 0;

  //BicikliProvider? _bicikliProvider;
  MojProfilArguments? argumentsMojProfil;

  @override
  void initState() {
    korisnik = widget.argumentsKor;
    // TODO: implement initState
    super.initState();
    //_bicikliProvider = context.read<BicikliProvider>();
    // _cartProvider = context.read<CartProvider>();
    print("called initState");
    // loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        argumentsKor: widget.argumentsKor,
        // appBar: AppBar(title: Text("RentABikeWTR")),
        // drawer: KupacDrawer(
        //   argumentsKor: korisnik!,
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
        child: SingleChildScrollView(
          child: Column(children: [
            HeaderWidget(
              title: title!,
            ),
            //_buildHeader(),
            SizedBox(
              height: 40,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(6, 57, 133, 1),
                            Color.fromRGBO(143, 148, 251, .6)
                          ])),
                      child: InkWell(
                        onTap: () async => Navigator.pushNamed(
                            context, BicikliListScreen.routeName,
                            arguments: korisnik),
                        child: Column(children: [
                          SizedBox(
                            height: 16,
                          ),
                          Icon(Icons.pedal_bike),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Bicikli pregled",
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                        // child: Center(
                        //     child: Text(
                        //   "Bicikli pregled",
                        //   style: TextStyle(color: Colors.white),
                        // )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(6, 57, 133, 1),
                            Color.fromRGBO(143, 148, 251, .6)
                          ])),
                      child: InkWell(
                        onTap: () async => Navigator.pushNamed(
                            context, KupacMojProfilScreen.routeName,
                            arguments: widget.argumentsKor),
                        child: Column(children: [
                          SizedBox(
                            height: 16,
                          ),
                          Icon(Icons.man_2),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Moj profil",
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                        // child: Center(
                        //     child: Text(
                        //   "Bicikli pregled",
                        //   style: TextStyle(color: Colors.white),
                        // )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(6, 57, 133, 1),
                            Color.fromRGBO(143, 148, 251, .6)
                          ])),
                      child: InkWell(
                        onTap: () async => Navigator.pushNamed(
                            context, KupacMojeRezervacijeScreen.routeName,
                            arguments: widget.argumentsKor),
                        child: Column(children: [
                          SizedBox(
                            height: 16,
                          ),
                          Icon(Icons.book_online),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Moje rezervacije",
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                        // child: Center(
                        //     child: Text(
                        //   "Bicikli pregled",
                        //   style: TextStyle(color: Colors.white),
                        // )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(6, 57, 133, 1),
                            Color.fromRGBO(143, 148, 251, .6)
                          ])),
                      child: InkWell(
                        onTap: () async => Navigator.pushNamedAndRemoveUntil(
                            context, HomePage.routeName, (route) => false),
                        child: Column(children: [
                          SizedBox(
                            height: 16,
                          ),
                          Icon(Icons.logout),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Odjava",
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                        // child: Center(
                        //     child: Text(
                        //   "Bicikli pregled",
                        //   style: TextStyle(color: Colors.white),
                        // )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ));
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     currentIndex = index;
  //   });
  //   if (currentIndex == 0) {
  //     Navigator.pushNamed(context, KupacPocetnaScreen.routeName,
  //         arguments: widget.argumentsKor);
  //   } else if (currentIndex == 1) {
  //     Navigator.pushNamed(context, KupacMojeRezervacijeScreen.routeName,
  //         arguments: widget.argumentsKor);
  //     // } else if (currentIndex == 2) {
  //     //   Navigator.pushNamed(context, KupacMojeRezervacijeDetailsScreen.routeName);
  //     // }
  //   }
  // }

  // Future<void>? loadKupacArgument() async {
//   Widget _buildHeader() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Text(
//         title!,
//         style: TextStyle(
//             color: Color.fromARGB(233, 120, 180, 229),
//             fontSize: 30,
//             fontWeight: FontWeight.w600),
//       ),
//     );
//   }
}
