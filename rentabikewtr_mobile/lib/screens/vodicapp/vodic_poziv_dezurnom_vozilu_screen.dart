import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_mobile/model/dezurnaVozila.dart';
import 'package:rentabikewtr_mobile/model/poziviDezurnomVozilu.dart';
import 'package:rentabikewtr_mobile/providers/dezurnaVozila_provider.dart';

import '../../model/poslovnice.dart';
import '../../providers/poslovnice_provider.dart';
import '../../providers/poziviDezurnomVozilu_provider.dart';
import 'vodic_pocetna_screen.dart';

class VodicPozivDezurnomVoziluScreen extends StatefulWidget {
  static const String routeName = "/dezurno_vozilo";
  const VodicPozivDezurnomVoziluScreen({Key? key}) : super(key: key);

  @override
  State<VodicPozivDezurnomVoziluScreen> createState() =>
      _VodicPozivDezurnomVoziluScreenState();
}

class _VodicPozivDezurnomVoziluScreenState
    extends State<VodicPozivDezurnomVoziluScreen> {
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
    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
      child: Column(
        children: [
          const Text(
            'Razlog poziva:',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 400,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      2, // bio je 1 ovo je broj osa (kolona ili redova)
                  childAspectRatio: 4 / 3,
                  crossAxisSpacing: 5, // bilo je 20
                  mainAxisSpacing: 5), //bilo je 30
              //scrollDirection: Axis.vertical,
              children: [
                Text("Nesreća: "),
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
                  onChanged: (value) => setState(() => pozos.nesreca = value),
                ),
                Text("Kvar: "),
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
                  onChanged: (value) => setState(() => pozos.kvar = value),
                ),
                Text("Zahtjev klijenta: "),
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
                Text("Loši vremenski uslovi: "),
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
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: detaljinput,
            keyboardType: TextInputType.multiline,
            minLines: 1, //Normal textInputField will be displayed
            maxLines: 5,
            decoration: InputDecoration(labelText: "Više detalja..."),
            // when user presses enter it will adapt to it
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: dateinput, //editing controller of this TextField
            decoration: InputDecoration(
                icon: Icon(Icons.timer), //icon of text field
                labelText: "Datum poziva: " //label text of field
                ),
            readOnly: true,
          ),
          TextField(
            controller: timeinput, //editing controller of this TextField
            decoration: InputDecoration(
                icon: Icon(Icons.timer), //icon of text field
                labelText: "Vrijeme poziva: " //label text of field
                ),
            readOnly: true,
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                var now = DateTime.now();
                pozos.datumPoziva = now;

                pozos.vrijemePoziva = DateTime(
                    now.year, now.month, now.day, now.hour, now.minute);

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
                Navigator.pushNamed(
                  context,
                  "${VodicPocetnaScreen.routeName}",
                );
                String kvara = "";
                String zahtjeva = "";
                String vremena = "";
                String nesrece = "";

                if (pozos.kvar == true) kvara = "kvara";
                if (pozos.nesreca == true) nesrece = "nesreće";
                if (pozos.losiVremenskiUslovi == true) vremena = "vremena";
                if (pozos.zahtjevKlijenta == true)
                  zahtjeva = "zahtjeva klijenta";

                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text("Potvrda najave"),
                          //content: Text(e.toString()),
                          content: Text(
                              "Uspješno ste izvršili poziv: \n Vrijeme: ${timeinput.text},\n Razlog: Usljed... *$kvara*$nesrece*$zahtjeva*$vremena !!!"),
                          actions: [
                            TextButton(
                              child: Text("Ok"),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        ));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Morate popuniti sva polja!!!'),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: Text("Slanje podataka"),
          ),
        ],
      ),
    ));
  }
}
