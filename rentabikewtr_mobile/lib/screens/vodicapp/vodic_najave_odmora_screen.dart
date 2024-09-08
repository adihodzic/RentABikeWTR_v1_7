//import 'dart:html';

// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; //Zbog time picker-a
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/model/najaveOdmora.dart';
import 'package:rentabikewtr_mobile/widgets/header_widget.dart';
import 'package:rentabikewtr_mobile/widgets/masterVodic_screen.dart';

import '../../model/lokacijeOdmora.dart';
import '../../providers/lokacijeOdmora_provider.dart';
import '../../providers/najaveOdmora_provider.dart';
import 'vodic_pocetna_screen.dart'; // or flutter_spinbox.dart for both

class VodicNajaveOdmoraScreen extends StatefulWidget {
  static const String routeName = "/najave_odmora";
  final KorisniciProfil argumentsKor;
  NajaveOdmora najos = NajaveOdmora(
      datumOdmora: DateTime.now(),
      pocetakOdmora: null,
      zavrsetakOdmora: null,
      napitakKolicina: 5,
      launchPaketKolicina: 5,
      lokacijaOdmoraID: null,
      turistickiVodicID: null);

  VodicNajaveOdmoraScreen({Key? key, required this.argumentsKor})
      : super(key: key);

  @override
  State<VodicNajaveOdmoraScreen> createState() =>
      _VodicNajaveOdmoraScreenState();
}

class _VodicNajaveOdmoraScreenState extends State<VodicNajaveOdmoraScreen> {
  String title = "Najava odmora";
  List<LokacijeOdmora> data = [];

  late LokacijeOdmoraProvider _lokacijeOdmoraProvider;
  late NajaveOdmoraProvider _najaveOdmoraProvider;
  LokacijeOdmora? _selectedValue;
  TimeOfDay time = TimeOfDay(hour: 00, minute: 30);
  TimeOfDay time2 = TimeOfDay(hour: 01, minute: 00);

  TextEditingController _timeinputController = TextEditingController();
  TextEditingController _timeinput2Controller = TextEditingController();
  double napkol = 0;
  double lpkol = 0;
  //text editing controller for text field
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget.najos = NajaveOdmora(
        //najavaOdmoraId;
        datumOdmora: DateTime.now(),
        pocetakOdmora: null,
        zavrsetakOdmora: null,
        napitakKolicina: 5,
        launchPaketKolicina: 5,
        lokacijaOdmoraID: null,
        turistickiVodicID: null);

    _timeinputController.text = "00:30 AM";
    _timeinput2Controller.text =
        "01:00 AM"; //set the initial value of text field
    _lokacijeOdmoraProvider = context.read<LokacijeOdmoraProvider>();
    _najaveOdmoraProvider = context.read<NajaveOdmoraProvider>();
    loadData();
    super.initState();
  }

  Future loadData() async {
    var tmpData = await _lokacijeOdmoraProvider.get(null);
    setState(() {
      data = tmpData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterVodicScreenWidget(
      argumentsKor: widget.argumentsKor,
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

            SizedBox(height: 40),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color.fromARGB(255, 246, 249, 252),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<LokacijeOdmora>(
                    decoration: InputDecoration(
                      hintText: "Odaberite lokaciju odmora",
                      hintStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(),
                    ),

                    // style: TextStyle(color: Colors.blue)),
                    value: _selectedValue,
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: data.map<DropdownMenuItem<LokacijeOdmora>>(
                        (LokacijeOdmora lod) {
                      return DropdownMenuItem<LokacijeOdmora>(
                        value: lod,
                        child: Text(lod.naziv!,
                            style: TextStyle(color: Colors.blue)),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Odaberite lokaciju';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (lod) {
                      setState(() {
                        _selectedValue = lod!;
                      });
                    }),
              ),
            ),
            SizedBox(
              height: 10,
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
                  controller: _timeinputController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Vrijeme početka odmora",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: 'Unesite vrijeme',
                    suffixIcon: Icon(Icons.timer),
                    suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                  ),
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                  onTap: () async {
                    _selectTime();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Odaberite datum rezervacije.';
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
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  controller:
                      _timeinput2Controller, //editing controller of this TextField
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),

                    labelText: "Vrijeme završetka odmora",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: 'Unesite vrijeme',
                    suffixIcon: Icon(Icons.timer),
                    suffixIconColor:
                        Color.fromRGBO(239, 247, 5, 0.98), //label text of field
                  ),
                  style: TextStyle(
                    color: Colors.blue,
                  ),

                  onTap: () async {
                    _selectTime2();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Odaberite datum rezervacije.';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),

            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color.fromARGB(255, 246, 249, 252),
              //padding: EdgeInsets.fromLTRB(100, 20, 100, 20),//vec sam postavio na parent container-u
              child: Padding(
                padding: const EdgeInsets.all(8.0),

                child: Column(children: [
                  // //Text("Napitak za osvježenje - količina",
                  //     style: TextStyle(fontSize: 15, color: Colors.blue)),
                  SpinBox(
                    decoration: InputDecoration(
                        labelText: "Napitak za osvježenje - količina",
                        labelStyle: TextStyle(color: Colors.blue)),
                    // Ovo sam uradio da smanjim dimezije sirine SpinBox-a (stavio sam ga u container)
                    min: 1,
                    max: 20,
                    value: (widget.najos.napitakKolicina!).toDouble(),
                    //.toDouble(), //ovo je inicijalna vrijednost spinbox-a
                    //moze se napisati i broj npr. 5
                    //onChanged: (value) => print(value),
                    onChanged: (value) {
                      //ako nema promjene value bude 0.0, pa sam kasnije stavio default vrijednost za napkol=5.0
                      napkol = value;
                    },
                  ),
                ]),

                // SizedBox(
                //   height: 20,
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
                child: Column(
                  children: [
                    // Text("Launch paket - količina",
                    //     style: TextStyle(fontSize: 15, color: Colors.blue)),
                    SpinBox(
                      decoration: InputDecoration(
                          labelText: "Launch paket - količina",
                          labelStyle: TextStyle(color: Colors.blue)),
                      // Ovo sam uradio da smanjim dimezije sirine SpinBox-a (stavio sam ga u container)
                      min: 1,
                      max: 20,
                      value: (widget.najos.launchPaketKolicina!).toDouble(),
                      //.toDouble(), //ovo je inicijalna vrijednost spinbox-a
                      //onChanged: (value) => print(value),
                      onChanged: (value) {
                        //vrijedi isto kao i za napkol, ako nema promejena onda je vrijednost 0.0
                        lpkol = value;
                      },
                    ),
                  ],
                ),
              ),
            ),

            // SizedBox(
            //   height: 30,
            //),
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
                            child: Text("Slanje podataka",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),

                        //makeReservation();
                        onTap: () async {
                          if (_formKey!.currentState!.validate()) {
                            try {
                              var now = DateTime.now();
                              widget.najos.datumOdmora = now;

                              widget.najos.pocetakOdmora = DateTime(now.year,
                                  now.month, now.day, time.hour, time.minute);

                              widget.najos.zavrsetakOdmora = DateTime(now.year,
                                  now.month, now.day, time2.hour, time2.minute);
                              if (widget.najos.pocetakOdmora!
                                  .isAfter(widget.najos.zavrsetakOdmora!)) {
                                throw Exception();
                              }
                              widget.najos.lokacijaOdmoraID =
                                  _selectedValue?.lokacijaOdmoraId;
                              if (napkol == 0.0) {
                                napkol = 5.0;
                              }
                              if (lpkol == 0.0) {
                                lpkol = 5.0;
                              }

                              widget.najos.napitakKolicina = napkol.toInt();
                              widget.najos.launchPaketKolicina = lpkol.toInt();
                              widget.najos.turistickiVodicID =
                                  widget.argumentsKor.korisnikId;
                              // widget.najos.lokacijaOdmoraID =
                              //     _selectedValue?.lokacijaOdmoraId;

                              //4; //prepraviti da bude trenutni korisnik profil
                              //await _rezervacijeProvider.insert(widget.rezos);

                              await _najaveOdmoraProvider.insert(widget.najos);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    'Uspješno ste izvršili najavu odmora!!!'),
                                backgroundColor: Colors.blue,
                              ));

                              await Navigator.pushNamed(
                                context,
                                "${VodicPocetnaScreen.routeName}",
                                arguments: widget.argumentsKor,
                              );
                            } catch (e) {
                              print('Iz konteksta:$e');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    'Provjerite vrijeme početka i završetka odmora!!!'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }

  _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if (picked != null) {
      String formattedTime = picked.format(context);
      time = picked;
      //assign the chosen date to the controller
      _timeinputController.text = formattedTime;
      //await _handleFormSubmission();
    }
  }

  _selectTime2() async {
    final TimeOfDay? picked2 = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if (picked2 != null) {
      String formattedTime2 = picked2.format(context);
      time2 = picked2;
      //assign the chosen date to the controller
      _timeinputController.text = formattedTime2;
      //await _handleFormSubmission();
    }
  }
}
