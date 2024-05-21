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
  bool _isLoading = false;
  late String slika;
  late Bicikli bic;
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

    Timer(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      //loadSlika();
      //loadTV();
      //loadTR();
    });
  }

  // void loadTR() async {
  //   if (widget.dataRez.turistRutaID != null) {
  //     ruta = await _turistRuteProvider?.getById(widget.dataRez.turistRutaID!);
  //   }
  // }

  // void loadTV() async {
  //   if (widget.dataRez.turistickiVodicID != null) {
  //     vodic = await _turistickiVodiciProvider
  //         ?.getById(widget.dataRez.turistickiVodicID!);
  //   }
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Rezervacija"), // $widget.dataRez.rezervacijaId"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                // First child in the Row for the name and the
                // Release date information.
                Expanded(
                  // Name and Release date are in the same column
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Code to create the view for name.
                      Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Original Name: Datum izdavanja treba da bude ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Code to create the view for release date.
                      Container(
                        height: 200,
                        width: 100,
                        //child: _buildProductCardList(),

                        child: imageFromBase64String(
                            widget.args.argumentsBic!.slika!),
                      ),
                      //Center(
                      //     child: ElevatedButton(
                      //   child: Text("Rezervacija bicikla"),
                      //   onPressed: () {
                      //     Navigator.pushNamed(
                      //         context, "${KupacPocetnaScreen.routeName}",
                      //         arguments: kor);
                      //   },
                      // )),
                      ElevatedButton(
                        onPressed: () async {
                          await Navigator.pushNamed(
                              context, "${KupacOcjeneScreen.routeName}",
                              arguments: widget.args);
                        },
                        child: Text("Ocijeni biciklo"),
                      ),
                    ],
                  ),
                ),
                // Icon to indicate the rating.
                new Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
                //new Text('${bic.voteAverage}'),
              ],
            ),
          ),
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
