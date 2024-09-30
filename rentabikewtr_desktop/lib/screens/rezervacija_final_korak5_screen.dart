import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/drzave.dart';
import 'package:rentabikewtr_desktop/model/korisniciDetalji.dart';
import 'package:rentabikewtr_desktop/model/korisniciPregled.dart';
import 'package:rentabikewtr_desktop/model/korisniciUpsert.dart';
import 'package:rentabikewtr_desktop/model/rezervacije.dart';
import 'package:rentabikewtr_desktop/model/rezervacijeBiciklDostupni.dart';
import 'package:rentabikewtr_desktop/model/screenArgumentsR.dart';
import 'package:rentabikewtr_desktop/model/turistRutePregled.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodici.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodiciUpsert.dart';
import 'package:rentabikewtr_desktop/providers/drzave_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciRezervacijePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisnici_provider.dart';
import 'package:rentabikewtr_desktop/providers/kupci_provider.dart';
import 'package:rentabikewtr_desktop/providers/rezervacije_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistRutePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class RezervacijaFinalKorak5Screen extends StatefulWidget {
  //final ScreenArgumentsR arguments;
  RezervacijeBiciklDostupni? argumentsB;
  TuristRutePregled? argumentsT;
  TuristickiVodici? argumentsV;
  DateTime? datumPretrage;
  KorisniciPregled argumentsK;
  RezervacijaFinalKorak5Screen(
      {Key? key,
      required this.argumentsB,
      this.argumentsT,
      this.argumentsV,
      required this.datumPretrage,
      required this.argumentsK})
      : super(key: key);

  @override
  State<RezervacijaFinalKorak5Screen> createState() =>
      _RezervacijaFinalKorak5ScreenState();
}

class _RezervacijaFinalKorak5ScreenState
    extends State<RezervacijaFinalKorak5Screen> {
  TextEditingController _nazivBiciklaController = TextEditingController();
  TextEditingController _korisnickoImeController = TextEditingController();
  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _velicinaBiciklaController = TextEditingController();
  TextEditingController _bojaController = TextEditingController();
  TextEditingController _nazivTipaBiciklaController = TextEditingController();
  TextEditingController _nazivProizvodjacaController = TextEditingController();
  TextEditingController _nazivModelaController = TextEditingController();
  TextEditingController _nazivVodicaController = TextEditingController();
  TextEditingController _nazivTuristRuteController = TextEditingController();
  TextEditingController _cijenaUslugeController = TextEditingController();

  TextEditingController _statusBiciklaController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();
//SLIKA
  //TextEditingController _passwordController = TextEditingController();
  TextEditingController _datePickerController = TextEditingController();
  TextEditingController _vrijemePreuzimanjaPickerController =
      TextEditingController();

  TextEditingController _vrijemeVracanjaPickerController =
      TextEditingController();
  DateTime? datumPre;
  TimeOfDay? vrijeme; //= TimeOfDay(hour: 9, minute: 0);
  TimeOfDay? vrijeme2;
  bool isTRutaRez = false;
  String search = "";
  bool statusPlacanja = true;
  // = TimeOfDay(hour: 18, minute: 0);
  // String? stringVrijeme;
  // String? stringVrijeme2;
  DateTime? pickedDate = DateTime.now();
  TextEditingController _datumPretrageController = TextEditingController();
  //REZERVACIJE TuristRute - checkBox...
//List<RezervacijeBiciklDostupni> data = [];
  //List<RezervacijeBiciklDostupni> _dataList = [];
  //RezervacijeUpsert? argumentsKor; //-- ako koristimo prosljeđivanje objekta
  List<TuristRutePregled> turistRute = [];
  TuristRutePregled? _selectedTuristRuta;
  TuristRutePregledProvider? _turistRutePregledProvider = null;

  List<KorisniciPregled> data = [];
  List<KorisniciPregled> _dataList = [];
  KorisniciRezervacijePregledProvider? _korisniciRezervacijePregledProvider =
      null;
  KorisniciPregledProvider? _korisniciPregledProvider = null;

  KupciProvider? _kupciProvider = null;
  Rezervacije? rezervacija;
  RezervacijeProvider? _rezervacijeProvider = null;

  List<Drzave>? drzave = [];
  Drzave? _selectedDrzava;
  DrzaveProvider? _drzaveProvider = null;

  List<TuristickiVodici>? turistickiVodici = [];
  TuristickiVodici? _selectedTuristickiVodic;
  TuristickiVodiciPregledProvider? _turistickiVodiciPregledProvider = null;
  Image? slikaTuristRute;
  // TuristickiVodiciDetaljiProvider? _turistickiVodiciDetaljiProvider = null;
  // KorisniciProvider? _korisniciProvider = null;
  KorisniciDetaljiProvider? _korisniciDetaljiProvider = null;
  // KorisniciPregledProvider? _korisniciPregledProvider = null;
  // //KorisniciUpsert? korisnik;
  KorisniciDetalji? currentUser;
  KorisniciDetalji? currentOperater;
  KorisniciDetalji? korisnikDetalji;
  // TuristickiVodici? turistickiVodicDetalji;
  // TuristickiVodiciUpsert? turistickiVodic;
  GlobalKey<FormState>? _formKey;
  //bool isEmail(String input) => EmailValidator.validate(input);
  bool isEmail(String input) {
    if (EmailValidator.validate(input)) {
      return true;
    } else {
      return false;
    }
  }

  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);
  bool isCijena(String input) {
    // This regular expression allows numbers like 1, 1.0, 12.34, 123.456, etc.
    final RegExp regex = RegExp(r'^\d+(\.\d+)?$');
    return regex.hasMatch(input);
  } // potrebno za validaciju

  bool dupliEmail = true;
  bool duploKorIme = true;

  //TextEditingController _date = TextEditingController();

  @override
  void initState() {
    _formKey = GlobalKey();
    _rezervacijeProvider = context.read<RezervacijeProvider>();
    _korisniciDetaljiProvider = context.read<KorisniciDetaljiProvider>();

    _drzaveProvider = context.read<DrzaveProvider>();
    _turistickiVodiciPregledProvider =
        context.read<TuristickiVodiciPregledProvider>();
    _turistRutePregledProvider = context.read<TuristRutePregledProvider>();
    _korisniciPregledProvider = context.read<KorisniciPregledProvider>();
    _korisniciRezervacijePregledProvider =
        context.read<KorisniciRezervacijePregledProvider>();
    _kupciProvider = context.read<KupciProvider>();

    rezervacija = Rezervacije(
        datumIzdavanja: null,
        vrijemePreuzimanja: null,
        vrijemeVracanja: null,
        statusPlacanja: true,
        cijenaUsluge: null,
        biciklID: null,
        turistickiVodicID: null,
        turistRutaID: null,
        kupacID: null,
        korisnikID: null);

    // _turistickiVodiciDetaljiProvider =
    //     context.read<TuristickiVodiciDetaljiProvider>();

    // _turistickiVodiciDetaljiProvider =
    //     Provider.of<TuristickiVodiciDetaljiProvider>(context,
    //       listen: false); //ovo mi je vazan red za inic providera
    loadData();
    loadRezervacijeBiciklDostupniDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {
      //DateTime? pickedDate = DateTime.now();
      //_datePickerController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    });
    super.initState();
  }

  Future loadData() async {
    var tmpData = await _drzaveProvider?.get();
    var tmpVodiciData = await _turistickiVodiciPregledProvider?.get();
    var tmpTuristRute = await _turistRutePregledProvider?.get();
    var tmpKorisnici = await _korisniciPregledProvider?.get();
    var tmpPretragaKupci = await _korisniciRezervacijePregledProvider?.get();

    setState(() {
      drzave = tmpData!;
      turistickiVodici = tmpVodiciData!;
      turistRute = tmpTuristRute!;
    });
  }

  Future<void> loadRezervacijeBiciklDostupniDetalji() async {
    setState(() async {
      currentUser = await _korisniciDetaljiProvider
          ?.getProfilKorisnika(widget.argumentsK.korisnickoIme!);
      currentOperater = await _korisniciDetaljiProvider
          ?.getProfilKorisnika(Authorization.username!);
      _imeController.text = widget.argumentsK.ime!;
      _prezimeController.text = widget.argumentsK.prezime!;
      _korisnickoImeController.text = widget.argumentsK.korisnickoIme!;

      var biciklid = widget.argumentsB!.biciklID;
      String? nazivVodica = widget.argumentsV?.naziv;
      String? nazivTuristRute = widget.argumentsT?.naziv;
      num cijena = 0.0;

      _nazivBiciklaController.text = widget.argumentsB!.nazivBicikla!;
      if (widget.argumentsV == null) {
        _nazivVodicaController.text = "Nije rezervisan vodič";
      } else {
        _nazivVodicaController.text = nazivVodica!;
      }
      if (widget.argumentsT == null) {
        _nazivTuristRuteController.text = "Nije rezervisana turist ruta";
      } else {
        _nazivTuristRuteController.text = nazivTuristRute!;
      }

      if (widget.argumentsT == null) {
        cijena = widget.argumentsB!.cijenaBicikla!;
      } else {
        cijena = widget.argumentsB!.cijenaBicikla! +
            widget.argumentsT!.cijenaRute! +
            widget.argumentsV!.cijenaVodica!;
      }
      _cijenaUslugeController.text = cijena.toString();

      _nazivTipaBiciklaController.text = widget.argumentsB!.nazivTipa!;
      _nazivProizvodjacaController.text = widget.argumentsB!.nazivProizvodjaca!;
      _nazivModelaController.text = widget.argumentsB!.nazivModela!;
      _bojaController.text = widget.argumentsB!.boja!;

      datumPre = widget.datumPretrage!;
      _datumPretrageController.text =
          DateFormat('dd-MM-yyyy').format(datumPre!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: MenuRadnik(),
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/logo.jpg",
                            height: 50,
                            width: 500,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "RentABikeWTR -Rezervacija-finalni korak",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 11, 7, 255)),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth: 300,
                                      minHeight: 100,
                                      maxHeight: 400),
                                  // width: 300,
                                  // height: 450,
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Color.fromARGB(255, 246, 249, 252),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 30, 16, 10),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _imeController,
                                            readOnly: true,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Ime",
                                                hintText: ''),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          TextFormField(
                                            controller: _prezimeController,
                                            readOnly: true,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Prezime",
                                                hintText: ''),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            controller:
                                                _korisnickoImeController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Korisničko ime",
                                                hintText: ''),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          TextFormField(
                                            controller: _cijenaUslugeController,
                                            readOnly: true,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Cijena",
                                                hintText: ''),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 160,
                              // ),
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth: 300,
                                      minHeight: 100,
                                      maxHeight: 300),
                                  // width: 300,
                                  // height: 300,
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Color.fromARGB(255, 246, 249, 252),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 30, 16, 10),
                                      child: Column(
                                        children: [
                                          //Text("Status plaćanja (Plaćeno):",
                                          //    textAlign: TextAlign.start),
                                          TextFormField(
                                            initialValue:
                                                "Status plaćanja (Plaćeno):",
                                            //controller: _cijenaUslugeController,
                                            decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                //labelText: "Cijena usluge",
                                                hintText: '10.0'),
                                            //maxLength: 20,
                                          ),

                                          RadioListTile<bool>(
                                            title: const Text('Da'),
                                            value: true,
                                            groupValue: statusPlacanja,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                statusPlacanja = value!;
                                              });
                                            },
                                          ),
                                          RadioListTile<bool>(
                                            title: const Text('Ne'),
                                            value: false,
                                            groupValue: statusPlacanja,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                statusPlacanja = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth: 300,
                                      minHeight: 100,
                                      maxHeight: 450),
                                  width: 300,
                                  height: 450,
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Color.fromARGB(255, 246, 249, 252),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 30, 16, 30),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            readOnly: true,
                                            controller: _nazivBiciklaController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Naziv bicikla",
                                                hintText: ''),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            controller: _nazivVodicaController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "Naziv vodiča",
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            controller:
                                                _nazivTuristRuteController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "Naziv turist rute",
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          SizedBox(height: 30),
                                          Row(children: [
                                            Flexible(
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  minWidth: 120,
                                                  maxWidth: 120,
                                                  //minHeight: 100,
                                                  //maxHeight: 450
                                                ),
                                                //width: 120,
                                                child: ElevatedButton(
                                                  child: Text("Nazad ..."),
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            Flexible(
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  minWidth: 120,
                                                  maxWidth: 120,
                                                  //minHeight: 100,
                                                  //maxHeight: 450
                                                ),
                                                //width: 120,
                                                child: ElevatedButton(
                                                  child: Text("Snimi"),
                                                  onPressed: () async {
                                                    if (_formKey!.currentState!
                                                        .validate()) {
                                                      try {
                                                        await _handleFormSubmission();
                                                        await _showDialog(
                                                            context,
                                                            'Success',
                                                            'Uspješno ste izvršili rezervaciju');
                                                        await Navigator.of(
                                                                context)
                                                            .push(MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        RezervacijaListaRezervacijaScreen()));
                                                      } catch (e) {
                                                        await _handleSubmissionError(
                                                            e);
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,

                    //constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
                    child: Center(
                      child: Card(
                        color: Color.fromARGB(255, 78, 11, 212),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(100, 16, 100, 30),
                          child: Column(children: [
                            Image.asset(
                              "assets/images/logo6.jpg",
                              height: 400,
                              width: 400,
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

/////////////////////////////////////////////////////////////////////////
  Future<void> _handleFormSubmission() async {
    _updateRezervacijaData();
    await _rezervacijeProvider?.insert(rezervacija);
    await _showDialog(
        context, 'Success', 'Učitavaju se podaci za novu rezervaciju...');
  }

  void _updateRezervacijaData() {
    setState(() {
      if (currentUser != null) {
        rezervacija!.kupacID = currentUser?.korisnikId;
      }

      rezervacija!.statusPlacanja = statusPlacanja;

      print('Cijena text: ${_cijenaUslugeController.text}');

      double? parsedCijena = double.tryParse(_cijenaUslugeController.text);
      if (parsedCijena != null) {
        print('Parsed Cijena: $parsedCijena');

        rezervacija!.cijenaUsluge = parsedCijena;
      } else {
        rezervacija!.cijenaUsluge = 0.0;
      }

      rezervacija!.datumIzdavanja = widget.datumPretrage!;

      rezervacija!.biciklID = widget.argumentsB!.biciklID;
      if (widget.argumentsT != null) {
        rezervacija!.turistRutaID = widget.argumentsT!.turistRutaId;
      }
      if (widget.argumentsV != null) {
        rezervacija!.turistickiVodicID = widget.argumentsV!.turistickiVodicId;
      }

      //Kombinuje se datum rezervacije sa vremenom preuzimanja i vremenom vraćanja
      int year = datumPre!.year;
      int month = datumPre!.month;
      int day = datumPre!.day;
      String stringTime = "09:00";
      String stringTime2 = "18:00";
      DateFormat timeFormat = DateFormat("hh:mm");
      DateTime time = timeFormat.parse(stringTime);
      DateTime time2 = timeFormat.parse(stringTime2);

      DateTime combinedDateTime =
          DateTime(year, month, day, time.hour, time.minute);
      DateTime combinedDateTime2 =
          DateTime(year, month, day, time2.hour, time2.minute);

      rezervacija!.vrijemeVracanja = combinedDateTime2;
      rezervacija!.vrijemePreuzimanja = combinedDateTime;
      if (currentOperater != null) {
        rezervacija!.korisnikID = currentOperater!.korisnikId;
      }
    });
  }

  Future<void> _handleSubmissionError(e) async {
    await _showDialog(context, 'Error', 'Došlo je do greške!');
    print('Greška koja se desi: $e');
  }

  // void validateController() {
  //   if (!_formKey!.currentState!.validate()) {
  //     _showDialog(context, 'Error', 'Pogrešan unos pokušajte ponovo');
  //     // value is false.. textFields are rebuilt in order to show errorLabels
  //     return;
  //   } else {
  //     _showDialog(context, 'Success', 'Uspješno ste kreirali rezervaciju');
  //   }
  // }

  Future<void> _showDialog(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
