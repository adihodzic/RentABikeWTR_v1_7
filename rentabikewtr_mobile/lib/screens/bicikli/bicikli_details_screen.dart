import 'dart:collection';
import 'dart:convert';
//import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/model/detalji.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';
import 'package:rentabikewtr_mobile/providers/detalji_provider.dart';
import 'package:rentabikewtr_mobile/providers/rezervacije_provider.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_mojeRezervacije_screen.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_pocetna_screen.dart';
import 'package:rentabikewtr_mobile/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:rentabikewtr_mobile/widgets/header_widget.dart';
import 'package:rentabikewtr_mobile/widgets/kupac_drawer.dart';
//import 'package:provider/provider.dart';

//import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';

import '../../utils/util.dart';
import '../../widgets/master_screen.dart';
import '../rezervacije/rezervacija_korak1_screen.dart';

class BicikliDetailsScreen extends StatefulWidget {
  Bicikli argumentsB; //-- ako koristimo prosljeđivanje objekta
  KorisniciProfil argumentsK;
  DateTime argumentsDate;

  BicikliDetailsScreen(
      {Key? key,
      required this.argumentsB,
      required this.argumentsK,
      required this.argumentsDate})
      : super(key: key);
  static const String routeName = "/bicikli_details";

  @override
  State<BicikliDetailsScreen> createState() => _BicikliDetailsScreenState();
}

class _BicikliDetailsScreenState extends State<BicikliDetailsScreen> {
  String? title;
  int currentIndex = 0;
  TextEditingController _bojaController = TextEditingController();
  TextEditingController _modelBiciklaController = TextEditingController();
  TextEditingController _tipBiciklaController = TextEditingController();
  TextEditingController _vrstaRamaController = TextEditingController();
  TextEditingController _nazivProizvodjacaController = TextEditingController();
  TextEditingController _cijenaBiciklaController = TextEditingController();
  TextEditingController _nazivPoslovniceController = TextEditingController();

  @override
  void initState() {
    title = widget.argumentsB.nazivBicikla!;
    //_formKey = GlobalKey();
    //slika = widget.argumentsB.slika;
    // _bicikliProvider = context.read<BicikliProvider>();
    // _tipoviBiciklaPregledProvider =
    //     context.read<TipoviBiciklaPregledProvider>();
    // _modeliBiciklaPregledProvider =
    //     context.read<ModeliBiciklaPregledProvider>();
    // _proizvodjaciBiciklaPregledProvider =
    //     context.read<ProizvodjaciBiciklaPregledProvider>();
    // _poslovnicePregledProvider = context.read<PoslovnicePregledProvider>();
    // _korisniciProvider = context.read<KorisniciProvider>();
    // _korisniciPregledProvider = context.read<KorisniciPregledProvider>();
    // _korisniciDetaljiProvider = context.read<KorisniciDetaljiProvider>();

    //_drzaveProvider = context.read<DrzaveProvider>();

    //_korisniciDetaljiProvider = context.read<KorisniciDetaljiProvider>();

    loadBicikliDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {});
    super.initState();
  }

  Future<void> loadBicikliDetalji() async {
    var biciklid = widget.argumentsB.biciklID;

    setState(() {
      Bicikli bic = widget.argumentsB;

      _cijenaBiciklaController.text = bic!.cijenaBicikla!.toString();
      _bojaController.text = bic!.boja!;
      _tipBiciklaController.text = bic!.nazivTipa!;
      _modelBiciklaController.text = bic!.nazivModela!;
      _nazivProizvodjacaController.text = bic!.nazivProizvodjaca!;

      _nazivPoslovniceController.text = bic.nazivPoslovnice!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      argumentsKor: widget.argumentsK,
      // appBar: AppBar(
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Image.asset(
      //         'assets/images/Logo6.JPG',
      //         fit: BoxFit.contain,
      //         height: 32,
      //       ),
      //       Container(
      //           padding: const EdgeInsets.all(8.0), child: Text('RentABikeWTR'))
      //     ],
      //   ),
      // ),
      // appBar: AppBar(
      //   title: Text("RentABikeWTR"),
      // ),
      // drawer: KupacDrawer(
      //   argumentsKor: widget.argumentsK,
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
        child: Column(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              HeaderWidget(
                title: title!,
              ),
            ]),
            // SizedBox(
            //   height: 2,
            // ),
            // Code to create the view for name.
            // Container(
            //   padding: const EdgeInsets.only(bottom: 8.0),
            //   child: Text(
            //     "Original Name: " + widget.argumentsB.nazivBicikla!,
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // Code to create the view for release date.
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                height: 100,
                width: 100,
                child: imageFromBase64String(widget.argumentsB.slika!),
              ),
            ]),

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
                  controller: _modelBiciklaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Model bicikla",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: 'Unesite model',
                    suffixIcon: Icon(Icons.pedal_bike),
                    suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                  ),
                  style: TextStyle(
                    color: Colors.blue,
                  ),
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
                  controller: _tipBiciklaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Tip bicikla",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: 'Unesite tip',
                    suffixIcon: Icon(Icons.pedal_bike),
                    suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                  ),
                  style: TextStyle(
                    color: Colors.blue,
                  ),
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
                  controller: _bojaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Boja",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: 'npr. Vodic-engleski',
                    suffixIcon: Icon(Icons.color_lens),
                    suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                  ),
                  style: TextStyle(
                    color: Colors.blue,
                  ),
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
                  controller: _nazivProizvodjacaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Naziv proizvođača",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: '',
                    suffixIcon: Icon(Icons.factory),
                    suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                  ),
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  controller: _cijenaBiciklaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Cijena",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: '10.0',
                    suffixIcon: Icon(Icons.wallet),
                    suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                  ),
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            // SizedBox(height: 10),

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
                  controller: _nazivPoslovniceController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Naziv poslovnice",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: '',
                    suffixIcon: Icon(Icons.location_pin),
                    suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                  ),
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),

            //SizedBox(height: 20),

            // SizedBox(height: 30),
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
                    // child: Container(
                    //   height: 30,
                    //   margin: EdgeInsets.fromLTRB(5, 10, 0, 10),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(2),
                    //     gradient: LinearGradient(colors: [
                    //       Color.fromRGBO(143, 148, 251, 1),
                    //       Color.fromRGBO(143, 148, 251, .6)
                    //     ]),
                    //   ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0), //prosiren inkWell
                      child: InkWell(
                        child: Center(
                            child: Text("Rezervacija bicikla",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        onTap: () async {
                          try {
                            // await _handleFormSubmission();
                            // await _showDialog(
                            //     context,
                            //     'Success',
                            //     'Uspješno ste editovali detalje bicikla');
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RezervacijaKorak1Screen(
                                      argumentsBic: widget.argumentsB,
                                      argumentsKor: widget.argumentsK,
                                      argumentsDate: widget.argumentsDate,
                                    )));
                          } catch (e) {
                            throw Exception("Došlo je do greške");
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
        // new Container(
        //     padding: const EdgeInsets.all(32.0),
        //     child: new Text(movie.overview,
        //       softWrap: true,
        //     )
        //)
      ),
    );
  }

  // Widget _buildHeader() {
  //   return Container(
  //     // alignment: Alignment.center,
  //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //     child: Text(
  //       widget.argumentsB.nazivBicikla!,
  //       style: TextStyle(
  //           color: Color.fromARGB(233, 120, 180, 229),
  //           fontSize: 30,
  //           fontWeight: FontWeight.w600),
  //     ),
  //   );
  // }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     currentIndex = index;
  //   });
  //   if (currentIndex == 0) {
  //     Navigator.pushNamed(context, KupacPocetnaScreen.routeName,
  //         arguments: widget.argumentsK);
  //   } else if (currentIndex == 1) {
  //     Navigator.pushNamed(context, KupacMojeRezervacijeScreen.routeName,
  //         arguments: widget.argumentsK);
  //     // } else if (currentIndex == 2) {
  //     //   Navigator.pushNamed(context, KupacMojeRezervacijeDetailsScreen.routeName);
  //     // }
  //   }
  // }
}

//////////////////////////////////////////////////////////////////////
