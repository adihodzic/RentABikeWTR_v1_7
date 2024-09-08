import 'dart:async';
import 'dart:collection';
import 'dart:convert';
//import 'dart:html';
//import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/model/detalji.dart';
import 'package:rentabikewtr_mobile/model/mojeRezervacijeArguments.dart';
import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';
import 'package:rentabikewtr_mobile/providers/detalji_provider.dart';
import 'package:rentabikewtr_mobile/providers/rezervacijeKupac_provider.dart';
import 'package:rentabikewtr_mobile/providers/rezervacije_provider.dart';
import 'package:rentabikewtr_mobile/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_mobile/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:rentabikewtr_mobile/widgets/header_widget.dart';
//import 'package:provider/provider.dart';

//import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';

import '../../model/korisniciProfil.dart';
import '../../model/rezervacije.dart';
import '../../model/rezervacijePregled.dart';
import '../../model/turistRute.dart';
import '../../model/turistickiVodici.dart';
import '../../providers/korisniciProfil_provider.dart';
import '../../providers/turistRute_provider.dart';
import '../../utils/util.dart';
import '../../widgets/master_screen.dart';
import '../rezervacije/rezervacija_korak1_screen.dart';
import 'kupac_ocjene_screen.dart';
import 'kupac_pocetna_screen.dart';

class KupacMojeRezervacijeDetailsScreen extends StatefulWidget {
  static const String routeName = "/rezervacije_details";
  final MojeRezervacijeArguments args;

  KupacMojeRezervacijeDetailsScreen({Key? key, required this.args})
      : super(key: key);
  //
  @override
  State<KupacMojeRezervacijeDetailsScreen> createState() =>
      _KupacMojeRezervacijeDetailsScreenState();
}

class _KupacMojeRezervacijeDetailsScreenState
    extends State<KupacMojeRezervacijeDetailsScreen> {
  String title = "Rezervacija";
  bool _isLoading = false;
  bool isVisible = false;
  late String slika;
  late Bicikli bic;
  TextEditingController _nazivVodicaController = TextEditingController();
  TextEditingController _cijenaUslugeController = TextEditingController();
  TextEditingController _datumIzdavanjaController = TextEditingController();
  // RezervacijePregled? dataRez;
  KorisniciProfil? kor;
  TuristickiVodici? vodic;
  TuristRute? ruta;
  BicikliProvider? _bicikliProvider;
  RezervacijeKupacProvider? _rezervacijeKupacProvider;
  TuristickiVodiciProvider? _turistickiVodiciProvider;
  TuristRuteProvider? _turistRuteProvider;
  KorisniciProfilProvider? _korisniciProfilProvider;

  @override
  void initState() {
    super.initState();
    _bicikliProvider = Provider.of<BicikliProvider>(context,
        listen: false); //ovo mi je vazan red za inic providera
    _turistickiVodiciProvider =
        Provider.of<TuristickiVodiciProvider>(context, listen: false);
    _korisniciProfilProvider =
        Provider.of<KorisniciProfilProvider>(context, listen: false);
    _turistRuteProvider =
        Provider.of<TuristRuteProvider>(context, listen: false);
    _rezervacijeKupacProvider = context.read<RezervacijeKupacProvider>();
    //loadBic();
    loadData();

    Timer(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      //loadSlika();
      //loadTV();
      //loadTR();
    });
  }

  void loadData() async {
    _cijenaUslugeController.text =
        widget.args.rezPregled!.cijenaUsluge.toString();
    _datumIzdavanjaController.text = DateFormat('dd-MM-yyyy')
        .format(widget.args.rezPregled!.datumIzdavanja!);
    if (widget.args.rezPregled!.turistickiVodicID != null) {
      vodic = await _turistickiVodiciProvider
          ?.getById(widget.args.rezPregled!.turistickiVodicID!);

      ruta = await _turistRuteProvider
          ?.getById(widget.args.rezPregled!.turistRutaID!);
      setState(() {
        isVisible = true;
        _nazivVodicaController.text = vodic!.naziv!;
      });
    }
  }

  // void loadTV() async {
  //   if (widget.args.rezPregled!.turistickiVodicID != null) {
  //     vodic = await _turistickiVodiciProvider
  //         ?.getById(widget.args.rezPregled!.turistickiVodicID!);
  //   }
  //   setState(() {
  //     _cijenaUslugeController.text=
  //   });
  // }

  // Future<void> loadBic() async {
  //   var tmpBic = await _bicikliProvider?.getById(widget.dataRez.biciklID!);
  //   setState(() {
  //     bic = tmpBic!;
  //     bic.slika = tmpBic.slika!;
  //     slika = bic.slika!;
  //     if (slika != null) {
  //       _isLoading = true;
  //     }
  //   });
  // }

  // void loadKor() async {
  //   kor = await _korisniciProfilProvider?.getById(widget.dataRez.korisnikID!);
  // }

  @override
  Widget build(BuildContext context) {
    //Visibility(visible: this._isLoading, child: CircularProgressIndicator());
    //if (slika == null) return loadSlika();
    return MasterScreenWidget(
      argumentsKor: widget.args.argumentsKor!,
      child: ListView(
        children: <Widget>[
          HeaderWidget(title: title),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      //Container je bio ili SizedBox
                      height: 100, //bio je height
                      width: 150, //bio je width i kasnije 100

                      child: imageFromBase64String(
                          widget.args.argumentsBic!.slika!)),
                ),
                //ovo je bilo prije x.slika!
              ),
              Center(child: Text(widget.args.argumentsBic!.nazivBicikla!)),
              SizedBox(
                height: 20,
              ),
              if (isVisible)
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        //Container je bio ili SizedBox
                        height: 100, //bio je height
                        width: 150, //bio je width i kasnije 100

                        child: imageFromBase64String(ruta!.slikaRute!)),
                  ),
                  //ovo je bilo prije x.slika!
                ),
              if (isVisible) Center(child: Text(ruta!.naziv!)),
              SizedBox(
                height: 20,
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
                    controller: _datumIzdavanjaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Datum preuzimanja",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: '',
                      suffixIcon: Icon(Icons.calendar_view_day),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              if (isVisible)
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
                      controller: _nazivVodicaController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Naziv vodiča",
                        labelStyle: TextStyle(color: Colors.blue),
                        hintText: '',
                        suffixIcon: Icon(Icons.person),
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
                    controller: _cijenaUslugeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Cijena",
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: '',
                      suffixIcon: Icon(Icons.wallet),
                      suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                    ),
                    style: TextStyle(
                      color: Colors.blue,
                    ),
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
                                child: Text("Ocijeni biciklo",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                            onTap: () async {
                              //if (_formKey.currentState!.validate()) {
                              try {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => KupacOcjeneScreen(
                                      args: MojeRezervacijeArguments(
                                          widget.args.rezPregled,
                                          widget.args.argumentsKor,
                                          widget.args.argumentsBic),
                                    ),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Došlo je do greške'),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                            //},
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Container(
          //   padding: const EdgeInsets.all(32.0),
          //   child: Row(
          //     children: [
          //       // First child in the Row for the name and the
          //       // Release date information.
          //       Expanded(
          //         // Name and Release date are in the same column
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             // Code to create the view for name.
          //             Container(
          //               padding: const EdgeInsets.only(bottom: 8.0),
          //               child: Text(
          //                 "Original Name: Datum izdavanja treba da bude ",
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ),

          //             // Code to create the view for release date.
          //             Container(
          //               height: 200,
          //               width: 100,
          //               //child: _buildProductCardList(),

          //               child: imageFromBase64String(
          //                   widget.args.argumentsBic!.slika!),
          //             ),
          //             //Center(
          //             //     child: ElevatedButton(
          //             //   child: Text("Rezervacija bicikla"),
          //             //   onPressed: () {
          //             //     Navigator.pushNamed(
          //             //         context, "${KupacPocetnaScreen.routeName}",
          //             //         arguments: kor);
          //             //   },
          //             // )),
          //           ],
          //         ),
          //       ),
          //       // Icon to indicate the rating.
          //       new Icon(
          //         Icons.star,
          //         color: Colors.red[500],
          //       ),
          //       //new Text('${bic.voteAverage}'),
          //     ],
          //   ),
          // ),
          //ElevatedButton(
          //     padding: const EdgeInsets.all(32.0),
          //     child: new Text(movie.overview,
          //       softWrap: true,
          //     )
          //)
        ],
      ),
    );
  }

  // String loadSlika() {
  //   if (bic.slika != null) {
  //     return bic.slika!;
  //   } else {
  //     this._isLoading = true;
  //     return bic.slika!;
  //   }
  // }
}
