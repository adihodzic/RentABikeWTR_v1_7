import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_mobile/model/dezurnaVozila.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/model/poziviDezurnomVozilu.dart';
import 'package:rentabikewtr_mobile/providers/dezurnaVozila_provider.dart';
import 'package:rentabikewtr_mobile/widgets/header_widget.dart';
import 'package:rentabikewtr_mobile/widgets/masterVodic_screen.dart';

import '../../model/poslovnice.dart';
import '../../providers/poslovnice_provider.dart';
import '../../providers/poziviDezurnomVozilu_provider.dart';
import 'vodic_pocetna_screen.dart';

class VodicPozivDezurnomVoziluScreen extends StatefulWidget {
  static const String routeName = "/dezurno_vozilo";
  final KorisniciProfil argumentsKor;
  const VodicPozivDezurnomVoziluScreen({Key? key, required this.argumentsKor})
      : super(key: key);

  @override
  State<VodicPozivDezurnomVoziluScreen> createState() =>
      _VodicPozivDezurnomVoziluScreenState();
}

class _VodicPozivDezurnomVoziluScreenState
    extends State<VodicPozivDezurnomVoziluScreen> {
  String title = "Poziv dežurnom vozilu";
  bool zahtjevKlijenta = false;
  bool kvar = false;
  bool nesreca = false;
  bool losiVremenskiUslovi = false;
  List<Poslovnice> dataPos = [];
  List<DezurnaVozila> dataDV = [];
  DezurnaVozila? dv;
  PoziviDezurnomVozilu pozos = PoziviDezurnomVozilu(
      viseDetalja: null,
      nesreca: null,
      zahtjevKlijenta: null,
      kvar: null,
      losiVremenskiUslovi: null,
      datumPoziva: DateTime.now(),
      vrijemePoziva: null,
      dezurnoVoziloID: null,
      turistickiVodicID: null,
      poslovnicaID: null);
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController detaljinput = TextEditingController();
  late PoslovniceProvider _poslovniceProvider;
  late DezurnaVozilaProvider _dezurnaVozilaProvider;
  late PoziviDezurnomVoziluProvider _poziviDezurnomVoziluProvider;
  //var now = DateTime.now();

  TimeOfDay vrijeme = TimeOfDay.fromDateTime(DateTime.now());
  DateTime datum = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //DateTime datum = DateTime.now(),

  @override
  void initState() {
    pozos = PoziviDezurnomVozilu(
        //najavaOdmoraId;
        viseDetalja: null,
        nesreca: false,
        zahtjevKlijenta: true,
        kvar: false,
        losiVremenskiUslovi: false,
        datumPoziva: DateTime.now(),
        vrijemePoziva: DateTime.now(),
        dezurnoVoziloID: null,
        turistickiVodicID: null,
        poslovnicaID: null);
    pozos.datumPoziva = DateTime.now();
    pozos.vrijemePoziva = DateTime.now();

    DateTime now = DateTime.now();
    datum = DateTime(now.day, now.month, now.year);
    var formatter = DateFormat(
        'dd.MM.yyyy'); //za ovo se mora ukljuciti intl/intl.dart package
    var timeFormatter = DateFormat('HH:mm:ss');
    dateinput.text = formatter.format(now);
    timeinput.text =
        timeFormatter.format(now); //set the initial value of text field
    _poslovniceProvider = context.read<PoslovniceProvider>();
    _dezurnaVozilaProvider = context.read<DezurnaVozilaProvider>();
    _poziviDezurnomVoziluProvider =
        context.read<PoziviDezurnomVoziluProvider>();
    loadDataPos();
    loadDataDV();
    super.initState();
  }

  Future loadDataPos() async {
    var tmpData = await _poslovniceProvider.get(null);
    setState(() {
      dataPos = tmpData;
    });
  }

  Future loadDataDV() async {
    var tmpData = await _dezurnaVozilaProvider.get(null);
    setState(() {
      dataDV = tmpData;
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
            Column(
              children: [
                Card(
                  elevation: 10,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20.0),
                  // ),
                  color: Color.fromARGB(255, 246, 249, 252),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Razlog poziva:',
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20.0),
                  // ),
                  color: Color.fromARGB(255, 246, 249, 252),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          child: const Text(
                            'Nesreća:',
                            style: TextStyle(fontSize: 15, color: Colors.blue),
                          ),
                        ),
                        Switch(
                          // thumb color (round icon)
                          activeColor: Colors.amber,
                          activeTrackColor: Colors.cyan,
                          inactiveThumbColor: Colors.blueGrey.shade600,
                          inactiveTrackColor: Colors.grey.shade400,
                          splashRadius: 50.0,
                          // boolean variable value
                          value: pozos.nesreca!,
                          // changes the state of the switch
                          onChanged: (value) =>
                              setState(() => pozos.nesreca = value),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20.0),
                  // ),
                  color: Color.fromARGB(255, 246, 249, 252),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          child: const Text(
                            'Kvar:',
                            style: TextStyle(fontSize: 15, color: Colors.blue),
                          ),
                        ),
                        Switch(
                          // thumb color (round icon)
                          activeColor: Colors.amber,
                          activeTrackColor: Colors.cyan,
                          inactiveThumbColor: Colors.blueGrey.shade600,
                          inactiveTrackColor: Colors.grey.shade400,
                          splashRadius: 50.0,
                          // boolean variable value
                          value: pozos.kvar!,
                          // changes the state of the switch
                          onChanged: (value) =>
                              setState(() => pozos.kvar = value),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20.0),
                  // ),
                  color: Color.fromARGB(255, 246, 249, 252),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          child: const Text(
                            'Zahtjev klijenta:',
                            style: TextStyle(fontSize: 15, color: Colors.blue),
                          ),
                        ),
                        Switch(
                          // thumb color (round icon)
                          activeColor: Colors.amber,
                          activeTrackColor: Colors.cyan,
                          inactiveThumbColor: Colors.blueGrey.shade600,
                          inactiveTrackColor: Colors.grey.shade400,
                          splashRadius: 50.0,
                          // boolean variable value
                          value: pozos.zahtjevKlijenta!,
                          // changes the state of the switch
                          onChanged: (value) =>
                              setState(() => pozos.zahtjevKlijenta = value),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20.0),
                  // ),
                  color: Color.fromARGB(255, 246, 249, 252),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          child: const Text(
                            'Loši vremenski uslovi:',
                            style: TextStyle(fontSize: 15, color: Colors.blue),
                          ),
                        ),
                        //SizedBox(width: 100),
                        Switch(
                          // thumb color (round icon)
                          activeColor: Colors.amber,
                          activeTrackColor: Colors.cyan,
                          inactiveThumbColor: Colors.blueGrey.shade600,
                          inactiveTrackColor: Colors.grey.shade400,
                          splashRadius: 50.0,
                          // boolean variable value
                          value: pozos.losiVremenskiUslovi!,
                          // changes the state of the switch
                          onChanged: (value) =>
                              setState(() => pozos.losiVremenskiUslovi = value),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 30,
            // ),
            // Container(
            //   height: 400,
            //   child: GridView(
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount:
            //             2, // bio je 1 ovo je broj osa (kolona ili redova)
            //         childAspectRatio: 4 / 3,
            //         crossAxisSpacing: 5, // bilo je 20
            //         mainAxisSpacing: 5), //bilo je 30
            //     //scrollDirection: Axis.vertical,
            //     children: [
            //       Text("Nesreća: "),
            //       Switch(
            //         // thumb color (round icon)
            //         activeColor: Colors.amber,
            //         activeTrackColor: Colors.cyan,
            //         inactiveThumbColor: Colors.blueGrey.shade600,
            //         inactiveTrackColor: Colors.grey.shade400,
            //         splashRadius: 50.0,
            //         // boolean variable value
            //         value: pozos.nesreca!,
            //         // changes the state of the switch
            //         onChanged: (value) => setState(() => pozos.nesreca = value),
            //       ),
            //       Text("Kvar: "),
            //       Switch(
            //         // thumb color (round icon)
            //         activeColor: Colors.amber,
            //         activeTrackColor: Colors.cyan,
            //         inactiveThumbColor: Colors.blueGrey.shade600,
            //         inactiveTrackColor: Colors.grey.shade400,
            //         splashRadius: 50.0,
            //         // boolean variable value
            //         value: pozos.kvar!,
            //         // changes the state of the switch
            //         onChanged: (value) => setState(() => pozos.kvar = value),
            //       ),
            //       Text("Zahtjev klijenta: "),
            //       Switch(
            //         // thumb color (round icon)
            //         activeColor: Colors.amber,
            //         activeTrackColor: Colors.cyan,
            //         inactiveThumbColor: Colors.blueGrey.shade600,
            //         inactiveTrackColor: Colors.grey.shade400,
            //         splashRadius: 50.0,
            //         // boolean variable value
            //         value: pozos.zahtjevKlijenta!,
            //         // changes the state of the switch
            //         onChanged: (value) =>
            //             setState(() => pozos.zahtjevKlijenta = value),
            //       ),
            //       Text("Loši vremenski uslovi: "),
            //       Switch(
            //         // thumb color (round icon)
            //         activeColor: Colors.amber,
            //         activeTrackColor: Colors.cyan,
            //         inactiveThumbColor: Colors.blueGrey.shade600,
            //         inactiveTrackColor: Colors.grey.shade400,
            //         splashRadius: 50.0,
            //         // boolean variable value
            //         value: pozos.losiVremenskiUslovi!,
            //         // changes the state of the switch
            //         onChanged: (value) =>
            //             setState(() => pozos.losiVremenskiUslovi = value),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 30,
            //),
            Card(
              elevation: 10,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(20.0),
              //),
              color: Color.fromARGB(255, 246, 249, 252),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: false,
                  controller: detaljinput,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Više detalja...",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: 'Unesite više detalja...',
                    counterText: "", //sakriven counter od maxLength
                    suffixIcon: Icon(Icons.text_format),
                    suffixIconColor: Color.fromRGBO(239, 247, 5, 0.98),
                  ),
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                  maxLength: 50,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo je obavezno polje.';
                    } else if (value.characters.length < 3) {
                      return 'Mora da sadrži minimalno 3(tri) karaktera.';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),

            // SizedBox(
            //   height: 30,
            // ),
            Card(
              elevation: 10,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(20.0),
              //),
              color: Color.fromARGB(255, 246, 249, 252),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: dateinput, //editing controller of this TextField
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    labelText: "Datum poziva: ",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: '',
                    counterText: "", //sakriven counter od maxLength
                    suffixIcon: Icon(Icons.timer),
                    suffixIconColor:
                        Color.fromRGBO(239, 247, 5, 0.98), //label text of field
                  ),
                  readOnly: true,
                ),
              ),
            ),
            Card(
              elevation: 10,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(20.0),
              //),
              color: Color.fromARGB(255, 246, 249, 252),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: timeinput, //editing controller of this TextField
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

                    labelText: "Vrijeme poziva: ",
                    labelStyle: TextStyle(color: Colors.blue),
                    hintText: '',
                    counterText: "", //sakriven counter od maxLength
                    suffixIcon: Icon(Icons.timer),
                    suffixIconColor:
                        Color.fromRGBO(239, 247, 5, 0.98), //label text of field
                  ),
                  readOnly: true,
                ),
              ),
            ),
            // TextField(
            //   controller: timeinput, //editing controller of this TextField
            //   decoration: InputDecoration(
            //       icon: Icon(Icons.timer), //icon of text field
            //       labelText: "Vrijeme poziva: " //label text of field
            //       ),
            //   readOnly: true,
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
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        child: Center(
                            child: Text("Slanje podataka",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              var now = DateTime.now();
                              pozos.datumPoziva = now;

                              pozos.vrijemePoziva = DateTime(now.year,
                                  now.month, now.day, now.hour, now.minute);

                              // pozos.kvar = kvar;
                              // pozos.nesreca = nesreca;
                              // pozos.losiVremenskiUslovi = losiVremenskiUslovi;
                              // pozos.zahtjevKlijenta = zahtjevKlijenta;
                              pozos.viseDetalja = detaljinput.text;
                              pozos.dezurnoVoziloID = 1; // potrebno uraditi
                              pozos.poslovnicaID = 1;
                              pozos.turistickiVodicID = 4;
                              if ((pozos.kvar! &&
                                      pozos.zahtjevKlijenta! &&
                                      pozos.losiVremenskiUslovi! &&
                                      pozos.nesreca!) ==
                                  false) {
                                pozos.zahtjevKlijenta = true;
                              }

                              //dv!.dezurnoVoziloId = pozos.dezurnoVoziloID;

                              await _poziviDezurnomVoziluProvider.insert(pozos);

                              String kvara = "";
                              String zahtjeva = "";
                              String vremena = "";
                              String nesrece = "";

                              if (pozos.kvar == true) kvara = "kvara";
                              if (pozos.nesreca == true) nesrece = "nesreće";
                              if (pozos.losiVremenskiUslovi == true)
                                vremena = "vremena";
                              if (pozos.zahtjevKlijenta == true)
                                zahtjeva = "zahtjeva klijenta";

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: Text("Potvrda najave"),
                                        //content: Text(e.toString()),
                                        content: Text(
                                            "Uspješno ste izvršili poziv: \n Vrijeme: ${timeinput.text},\n Razlog: Usljed... *$kvara*$nesrece*$zahtjeva*$vremena !!!"),
                                        actions: [
                                          TextButton(
                                            child: Text("Ok"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          )
                                        ],
                                      ));
                              await Navigator.pushNamed(
                                context,
                                "${VodicPocetnaScreen.routeName}",
                                arguments: widget.argumentsKor,
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Morate popuniti sva polja!!!'),
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
            ),
          ],
        )),
      ),
    );
  }
}
