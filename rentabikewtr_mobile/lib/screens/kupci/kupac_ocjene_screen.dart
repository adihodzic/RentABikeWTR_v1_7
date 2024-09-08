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
import '../../model/ocjene.dart';
import '../../model/rezervacije.dart';
import '../../model/rezervacijePregled.dart';
import '../../model/turistRute.dart';
import '../../model/turistickiVodici.dart';
import '../../providers/korisniciProfil_provider.dart';
import '../../providers/ocjene_provider.dart';
import '../../providers/turistRute_provider.dart';
import '../../utils/util.dart';
import '../../widgets/master_screen.dart';
import '../rezervacije/rezervacija_korak1_screen.dart';
import 'kupac_mojeRezervacije_details_screen.dart';
import 'kupac_pocetna_screen.dart';

class KupacOcjeneScreen extends StatefulWidget {
  static const String routeName = "/ocjene";
  final MojeRezervacijeArguments args;

  KupacOcjeneScreen({Key? key, required this.args}) : super(key: key);
  //
  @override
  State<KupacOcjeneScreen> createState() => _KupacOcjeneScreenState();
}

class _KupacOcjeneScreenState extends State<KupacOcjeneScreen> {
  bool hasShownSnackBar = false;
  //bool _isLoading = false;
  String title = "Ocjena bicikla";
  List<Ocjene> data = [];
  Ocjene? ocj;
  int ocjenaID = 0;
  var oc = 0;
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
  OcjeneProvider? _ocjeneProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    _ocjeneProvider = context.read<OcjeneProvider>();
    ocj =
        Ocjene(ocjena: null, datumOcjene: null, biciklID: null, kupacID: null);
    //loadOcjene();

    // Timer(Duration(seconds: 2), () {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //loadSlika();
    //loadTV();
    //loadTR();
    // });
  }

  String selected = "";
  List checkListItems = [
    {
      "id": 1,
      "value": false,
      "title": "Loše",
    },
    {
      "id": 2,
      "value": false,
      "title": "Zadovoljava",
    },
    {
      "id": 3,
      "value": false,
      "title": "Dobro",
    },
    {
      "id": 4,
      "value": false,
      "title": "Vrlo dobro",
    },
    {
      "id": 5,
      "value": false,
      "title": "Odlično",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final _ocjeneProvider = Provider.of<OcjeneProvider>(context);
    return MasterScreenWidget(
      argumentsKor: widget.args.argumentsKor!,
      //backgroundColor: Colors.white,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                HeaderWidget(
                  title: title,
                ),
              ]),
              Column(
                children: List.generate(
                  checkListItems.length,
                  (index) => FormField<bool>(
                    initialValue: checkListItems[index]["value"],
                    validator: (value) {
                      if (checkListItems
                          .every((item) => item["value"] == false)) {
                        if (!hasShownSnackBar) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Odaberite ocjenu...'),
                                backgroundColor: Colors.red),
                          );
                          setState(() {
                            hasShownSnackBar = true;
                          });
                        }
                        return '';
                      }
                      return null;
                    },
                    builder: (FormFieldState<bool> state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SwitchListTile(
                            activeColor: Colors.amber,
                            activeTrackColor: Colors.cyan,
                            inactiveThumbColor: Colors.blueGrey.shade600,
                            inactiveTrackColor: Colors.grey.shade400,
                            splashRadius: 50.0,
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            title: Text(
                              checkListItems[index]["title"],
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                              ),
                            ),
                            value: checkListItems[index]["value"],
                            onChanged: (value) {
                              setState(() {
                                for (var element in checkListItems) {
                                  element["value"] = false;
                                }
                                checkListItems[index]["value"] = value;
                                oc = index + 1;

                                ocj!.datumOcjene = DateTime.now();
                                ocj!.biciklID =
                                    widget.args.argumentsBic!.biciklID;
                                ocj!.kupacID =
                                    widget.args.argumentsKor!.korisnikId;

                                selected =
                                    "${checkListItems[index]["id"]}, ${checkListItems[index]["title"]}, ${checkListItems[index]["value"]}";
                              });
                              // if (checkListItems
                              //     .every((item) => item["value"] == false)) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       content: Text('Odaberite ocjenu...'),
                              //       backgroundColor: Colors.red,
                              //     ),
                              //   );
                              // }

                              // Update FormField state
                              state.didChange(value);
                              //validacija forme
                              //validateForm();
                            },
                          ),
                          // if (checkListItems
                          //     .every((item) => item["value"] == false))
                          //   // ScaffoldMessenger.of(context).showSnackBar(
                          //   //   SnackBar(
                          //   //       content: Text('Odaberite ocjenu...'),
                          //   //       backgroundColor: Colors.red),
                          //   // );

                          // if (state.hasError)
                          //   Padding(
                          //     padding: const EdgeInsets.only(left: 16.0),
                          //     child: Text(
                          //       state.errorText ?? '',
                          //       style: TextStyle(
                          //         color: Colors.red,
                          //         fontSize: 12.0,
                          //       ),
                          //     ),
                          //   ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 100.0),
              // Text(
              //   selected,
              //   style: const TextStyle(
              //     fontSize: 22.0,
              //     color: Colors.black,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
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
                                child: Text("Potvrdi ocjenu",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  var check = await _handleFormSubmission();
                                  if (check == true) {
                                    await _ocjeneProvider.insert(this.ocj);
                                  } else {
                                    throw Exception();
                                  }

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Uspješno ste izvršili ocjenjivanje...'),
                                        backgroundColor:
                                            Color.fromARGB(255, 42, 25, 194)),
                                  );

                                  await Navigator.pushReplacementNamed(
                                      context, KupacPocetnaScreen.routeName,
                                      arguments: widget.args.argumentsKor);
                                } catch (e) {
                                  await ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                        content: Text('Došlo je do greške...'),
                                        backgroundColor: Colors.red),
                                  );
                                }
                                ;
                              }
                              ;
                            }),
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

  Future<bool> _handleFormSubmission() async {
    if (this.ocj != null) {
      setState(() {
        this.ocj!.ocjena = this.oc;
      });
      return true;
    } else {
      return false;
    }
  }
}
