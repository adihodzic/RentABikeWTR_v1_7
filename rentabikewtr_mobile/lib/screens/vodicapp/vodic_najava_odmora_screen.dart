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
import 'package:rentabikewtr_mobile/model/najavaOdmora.dart';

import '../../model/lokacijeOdmora.dart';
import '../../providers/lokacijeOdmora_provider.dart';
import '../../providers/najavaOdmora_provider.dart';
import 'vodic_pocetna_screen.dart'; // or flutter_spinbox.dart for both

class VodicNajavaOdmoraScreen extends StatefulWidget {
  static const String routeName = "/najava_odmora";
  NajavaOdmora najos = NajavaOdmora(
      datumOdmora: DateTime.now(),
      pocetakOdmora: null,
      zavrsetakOdmora: null,
      napitakKolicina: null,
      launchPaketKolicina: null,
      lokacijaOdmoraID: null,
      turistickiVodicID: null);

  VodicNajavaOdmoraScreen({Key? key}) : super(key: key);

  @override
  State<VodicNajavaOdmoraScreen> createState() =>
      _VodicNajavaOdmoraScreenState();
}

class _VodicNajavaOdmoraScreenState extends State<VodicNajavaOdmoraScreen> {
  List<LokacijeOdmora> data = [];

  late LokacijeOdmoraProvider _lokacijeOdmoraProvider;
  late NajavaOdmoraProvider _najavaOdmoraProvider;
  LokacijeOdmora? _selectedValue;
  TimeOfDay time = TimeOfDay(hour: 00, minute: 30);
  TimeOfDay time2 = TimeOfDay(hour: 01, minute: 00);
  TimeOfDay? pickedTime2;
  TimeOfDay? pickedTime;
  TextEditingController timeinput = TextEditingController();
  TextEditingController timeinput2 = TextEditingController();
  double napkol = 0;
  double lpkol = 0;
  //text editing controller for text field
  @override
  void initState() {
    widget.najos = NajavaOdmora(
        //najavaOdmoraId;
        datumOdmora: DateTime.now(),
        pocetakOdmora: null,
        zavrsetakOdmora: null,
        napitakKolicina: 5,
        launchPaketKolicina: 5,
        lokacijaOdmoraID: null,
        turistickiVodicID: null);

    timeinput.text = "";
    timeinput2.text = ""; //set the initial value of text field
    _lokacijeOdmoraProvider = context.read<LokacijeOdmoraProvider>();
    _najavaOdmoraProvider = context.read<NajavaOdmoraProvider>();
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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
        child: Column(
          children: [
            SizedBox(height: 40),
            //Text("${time.hour.toString()}:${time.minute.toString()}"),
            TextField(
              controller: timeinput, //editing controller of this TextField
              decoration: InputDecoration(
                  icon: Icon(Icons.timer), //icon of text field
                  labelText: "Vrijeme početka odmora" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                pickedTime = await showTimePicker(
                  initialTime: time,
                  context: context,
                ) as TimeOfDay; //morao sam uraditi cast da bih izbjegao gresku za tip Future<TimeOfDay?>

                if (pickedTime != null) {
                  print(pickedTime!.format(context)); //output 10:51 PM
                  String formattedTime = pickedTime!.format(context);

                  //converting to DateTime so that we can further format on different pattern.
                  //print(parsedTime); //output 1970-01-01 22:53:00.000
                  // String formattedTime =
                  //     DateFormat('HH:mm:ss').format(parsedTime);
                  print(formattedTime); //output 14:59:00
                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                  setState(() {
                    timeinput.text =
                        formattedTime; //set the value of text field.
                  });
                } else {
                  print("Time is not selected");
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: timeinput2, //editing controller of this TextField
              decoration: InputDecoration(
                  icon: Icon(Icons.timer), //icon of text field
                  labelText: "Vrijeme završetka odmora" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                pickedTime2 = await showTimePicker(
                  initialTime: time2,
                  context: context,
                ) as TimeOfDay; //morao sam uraditi cast da bih izbjegao gresku za tip Future<TimeOfDay?>

                if (pickedTime2 != null) {
                  print(pickedTime2!.format(context)); //output 10:51 PM
                  String formattedTime2 = pickedTime2!.format(context);

                  //converting to DateTime so that we can further format on different pattern.
                  //print(parsedTime); //output 1970-01-01 22:53:00.000
                  // String formattedTime =
                  //     DateFormat('HH:mm:ss').format(parsedTime);
                  print(formattedTime2); //output 14:59:00
                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                  setState(() {
                    timeinput2.text =
                        formattedTime2; //set the value of text field.
                  });
                } else {
                  print("Time is not selected");
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text("Napitak za osvježenje - količina",
                style: TextStyle(fontSize: 15)),

            Container(
                //padding: EdgeInsets.fromLTRB(100, 20, 100, 20),//vec sam postavio na parent container-u
                child: Column(
              children: [
                SpinBox(
                  // Ovo sam uradio da smanjim dimezije sirine SpinBox-a (stavio sam ga u container)
                  min: 1,
                  max: 20,
                  value: widget.najos.napitakKolicina!
                      .toDouble(), //ovo je inicijalna vrijednost spinbox-a
                  //moze se napisati i broj npr. 5
                  //onChanged: (value) => print(value),
                  onChanged: (value) {
                    //ako nema promjene value bude 0.0, pa sam kasnije stavio default vrijednost za napkol=5.0
                    napkol = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Launch paket - količina", style: TextStyle(fontSize: 15)),
                SpinBox(
                  // Ovo sam uradio da smanjim dimezije sirine SpinBox-a (stavio sam ga u container)
                  min: 1,
                  max: 20,
                  value: widget.najos.launchPaketKolicina!
                      .toDouble(), //ovo je inicijalna vrijednost spinbox-a
                  //onChanged: (value) => print(value),
                  onChanged: (value) {
                    //vrijedi isto kao i za napkol, ako nema promejena onda je vrijednost 0.0
                    lpkol = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton<LokacijeOdmora>(
                    hint: Text("Odaberite lokaciju odmora"),
                    value: _selectedValue,
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: data.map<DropdownMenuItem<LokacijeOdmora>>(
                        (LokacijeOdmora lod) {
                      return DropdownMenuItem<LokacijeOdmora>(
                        value: lod,
                        child: Text(lod.naziv!),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (lod) {
                      setState(() {
                        _selectedValue = lod!;
                      });
                    }),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(

                    //makeReservation();
                    onPressed: () async {
                      try {
                        var now = DateTime.now();
                        widget.najos.datumOdmora = now;

                        widget.najos.pocetakOdmora = DateTime(
                            now.year,
                            now.month,
                            now.day,
                            pickedTime!.hour,
                            pickedTime!.minute);

                        widget.najos.zavrsetakOdmora = DateTime(
                            now.year,
                            now.month,
                            now.day,
                            pickedTime2!.hour,
                            pickedTime2!.minute);
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
                            4; //prepraviti da bude trenutni korisnik profil
                        //await _rezervacijeProvider.insert(widget.rezos);

                        await _najavaOdmoraProvider.insert(widget.najos);

                        Navigator.pushNamed(
                          context,
                          "${VodicPocetnaScreen.routeName}",
                        );
                        ////////////////////////
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text("Potvrda najave"),
                                  //content: Text(e.toString()),
                                  content: Text(
                                      "Uspješno ste izvršili najavu odmora: \n Početak: ${pickedTime!.format(context)},\n Završetak: ${pickedTime2!.format(context)},\n Količina napitaka: ${napkol.toInt()}, \n Količina launch paketa: ${lpkol.toInt()}, \nLokacija odmora: ${_selectedValue!.naziv} !!!"),
                                  actions: [
                                    TextButton(
                                      child: Text("Ok"),
                                      onPressed: () => Navigator.pop(context),
                                    )
                                  ],
                                ));
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Morate popuniti sva polja!!!'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: Text("Slanje podataka"))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
