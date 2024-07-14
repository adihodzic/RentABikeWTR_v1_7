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
import 'package:rentabikewtr_desktop/screens/rezervacija_final_korak5_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';

class RezervacijaKupacKorak4Screen extends StatefulWidget {
  //final ScreenArgumentsR arguments;
  RezervacijeBiciklDostupni? argumentsB;
  TuristRutePregled? argumentsT;
  TuristickiVodici? argumentsV;
  DateTime? datumPretrage;
  RezervacijaKupacKorak4Screen(
      {Key? key,
      required this.argumentsB,
      this.argumentsT,
      this.argumentsV,
      required this.datumPretrage})
      : super(key: key);

  @override
  State<RezervacijaKupacKorak4Screen> createState() =>
      _RezervacijaKupacKorak4ScreenState();
}

class _RezervacijaKupacKorak4ScreenState
    extends State<RezervacijaKupacKorak4Screen> {
  TextEditingController _nazivBiciklaController = TextEditingController();
  TextEditingController _korisnikController = TextEditingController();
  TextEditingController _velicinaBiciklaController = TextEditingController();
  TextEditingController _bojaController = TextEditingController();
  TextEditingController _nazivTipaBiciklaController = TextEditingController();
  TextEditingController _nazivProizvodjacaController = TextEditingController();
  TextEditingController _nazivModelaController = TextEditingController();
  TextEditingController _cijenaVodicaController = TextEditingController();
  TextEditingController _cijenaRuteController = TextEditingController();

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
  // = TimeOfDay(hour: 18, minute: 0);
  // String? stringVrijeme;
  // String? stringVrijeme2;
  DateTime? pickedDate = DateTime.now();
  TextEditingController _datumPretrageController = TextEditingController();
  //REZERVACIJE TuristRute - checkBox...
//List<RezervacijeBiciklDostupni> data = [];
  //List<RezervacijeBiciklDostupni> _dataList = [];
  //RezervacijeUpsert? argumentsKor; //-- ako koristimo prosljeđivanje objekta
  RezervacijeBiciklDostupni? _biciklDostupni;
  List<TuristRutePregled> turistRute = [];
  TuristRutePregled? _selectedTuristRuta;
  TuristRutePregledProvider? _turistRutePregledProvider = null;

  List<KorisniciPregled> data = [];
  List<KorisniciPregled> _dataList = [];
  KorisniciRezervacijePregledProvider? _korisniciRezervacijePregledProvider =
      null;
  KorisniciPregledProvider? _korisniciPregledProvider = null;

  KupciProvider? _kupciProvider = null;

  List<Drzave>? drzave = [];
  Drzave? _selectedDrzava;
  DrzaveProvider? _drzaveProvider = null;

  List<TuristickiVodici>? turistickiVodici = [];
  TuristickiVodici? _selectedTuristickiVodic;
  TuristickiVodiciPregledProvider? _turistickiVodiciPregledProvider = null;
  Image? slikaTuristRute;
  // TuristickiVodiciDetaljiProvider? _turistickiVodiciDetaljiProvider = null;
  // KorisniciProvider? _korisniciProvider = null;
  // KorisniciDetaljiProvider? _korisniciDetaljiProvider = null;
  // KorisniciPregledProvider? _korisniciPregledProvider = null;
  // //KorisniciUpsert? korisnik;
  // KorisniciDetalji? currentUser;
  // KorisniciDetalji? korisnikDetalji;
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

    _drzaveProvider = context.read<DrzaveProvider>();
    _turistickiVodiciPregledProvider =
        context.read<TuristickiVodiciPregledProvider>();
    _turistRutePregledProvider = context.read<TuristRutePregledProvider>();
    _korisniciPregledProvider = context.read<KorisniciPregledProvider>();
    _korisniciRezervacijePregledProvider =
        context.read<KorisniciRezervacijePregledProvider>();
    _kupciProvider = context.read<KupciProvider>();

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
      // _cijenaVodicaController.text =
      //     _selectedTuristickiVodic!.cijenaVodica.toString();
      //_cijenaRuteController.text = _selectedTuristRuta!.cijenaRute.toString();

      // stringVrijeme2 = vrijeme2!.format(context).toString();
      _biciklDostupni = widget.argumentsB!;
      var biciklid = widget.argumentsB!.biciklID;
      _nazivBiciklaController.text = widget.argumentsB!.nazivBicikla!;
      //_velicinaBiciklaController=widget.argumentsB!.nazv
      _nazivTipaBiciklaController.text = widget.argumentsB!.nazivTipa!;
      _nazivProizvodjacaController.text = widget.argumentsB!.nazivProizvodjaca!;
      _nazivModelaController.text = widget.argumentsB!.nazivModela!;
      _bojaController.text = widget.argumentsB!.boja!;
      //_cijenaVodicaController.text = null;
      datumPre = widget.datumPretrage!;
      _datumPretrageController.text =
          DateFormat('dd-MM-yyyy').format(datumPre!);
      _selectedTuristRuta = widget.argumentsT;
      _selectedTuristickiVodic = widget.argumentsV;
    });
  }

  // Future loadData() async {
  //   var tmpData = await _drzaveProvider?.get();
  //   var tmpkorisniciPregled = await _korisniciPregledProvider?.get();
  //   setState(() {
  //     drzave = tmpData!;
  //     korisniciPregled = tmpkorisniciPregled!;
  //   });
  // }
  //var datumRegistracije= _DatePickerContreo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Menu(context),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      constraints:
                          BoxConstraints(maxWidth: 800, maxHeight: 800),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(children: [
                            // Image.network("https://www.fit.ba/content/public/images/og-image.jpg", height: 100, width: 100,),
                            Image.asset(
                              "assets/images/logo.jpg",
                              height: 50,
                              width: 500,
                            ),
                            SizedBox(
                              height: 50,
                            ),

                            Text(
                              "RentABikeWTR -Rezervacija-kupac",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Color.fromARGB(255, 11, 7, 255)),
                            ),
                            Flexible(
                              child: Container(
                                constraints: BoxConstraints(
                                    minWidth: 100,
                                    maxWidth: 800,
                                    minHeight: 100,
                                    maxHeight: 120),
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 300,
                                          child: TextFormField(
                                            readOnly: false,
                                            controller: _korisnikController,
                                            //onTap: _selectDate,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Pretraga kupaca",
                                                hintText:
                                                    'Korisničko ime, ime, prezime'),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Ovo je obavezno polje.';
                                              } else {
                                                return null;
                                              }
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                        ),
                                        Container(
                                          width: 200,
                                          height: 50,
                                          child: ElevatedButton(
                                            child: Text("Izlistaj kupce"),
                                            onPressed: () async {
                                              if (_formKey!.currentState!
                                                  .validate()) {
                                                try {
                                                  await _handleFormSubmission();

                                                  await _showDialog(
                                                      context,
                                                      'Success',
                                                      'Pregledajte kupce');
                                                  //   await Navigator.of(
                                                  //           context)
                                                  //       .push(MaterialPageRoute(
                                                  //           builder:
                                                  //               (context) =>
                                                  //                   AdminPortalScreen()));
                                                } catch (e) {
                                                  await _handleSubmissionError(
                                                      e);
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            _buildDataListView(),
                          ]),
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
                            padding:
                                const EdgeInsets.fromLTRB(100, 16, 100, 30),
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
          ],
        ),
      ),
    );
  }

  Widget _buildDataListView() {
    //KorisniciProvider? _korProvider = null;
    //List<Korisnici> data1 = [];

    return Expanded(
        child: SingleChildScrollView(
      child: DataTable(
          columns: [
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Korisničko ime',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Ime',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            // const DataColumn(
            //   label: Expanded(
            //     child: Text(
            //       'Datum izdavanja',
            //       style: TextStyle(fontStyle: FontStyle.italic),
            //     ),
            //   ),
            // ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Prezime',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            // const DataColumn(
            //   label: Expanded(
            //     child: Text(
            //       'Tip bicikla',
            //       style: TextStyle(fontStyle: FontStyle.italic),
            //     ),
            //   ),
            // ),
            // const DataColumn(
            //   label: Expanded(
            //     child: Text(
            //       'Naziv proizvođača',
            //       style: TextStyle(fontStyle: FontStyle.italic),
            //     ),
            //   ),
            // ),
          ],
          rows: _dataList
                  .map((KorisniciPregled e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RezervacijaFinalKorak5Screen(
                                          argumentsK: e,
                                          argumentsB: _biciklDostupni,
                                          argumentsT: _selectedTuristRuta,
                                          argumentsV: _selectedTuristickiVodic,
                                          datumPretrage: datumPre,
                                        ),
                                      ),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.korisnickoIme?.toString() ?? "")),
                            DataCell(Text(e.ime?.toString() ?? "")),
                            // DataCell(Text(DateFormat('dd-MM-yyyy')
                            //     .format(e.datumIzdavanja as DateTime))),
                            //DataCell(Text(formatNumber(e.cijenaBicikla))),
                            DataCell(Text(e.prezime.toString() ?? "")),
                            // DataCell(
                            //     Text(e.nazivProizvodjaca?.toString() ?? "")),

                            //DataCell(Text(formatNumber(e.cijena))),
                            // DataCell(e.slika != ""
                            //     ? Container(
                            //         width: 100,
                            //         height: 100,
                            //         child: imageFromBase64String(e.slika!),
                            //       )
                            //     : Text(""))
                          ]))
                  .toList() ??
              []),
    ));
  }

/////////////////////////////////////////////////////////////////////////////////
  Future<void> _handleFormSubmission() async {
    try {
      // var data = await _rezervacijeBiciklDostupniProvider!
      //     .getRezervacijeDostupni(DateTime.parse(_dateController.text));
      // var datum = dateTime.toIso8601String();
      var data = await _korisniciRezervacijePregledProvider!
          .getKupci(_korisnikController.text);
      //     .getRezervacijeDostupni(datum);
//var bicikli= await _bicikliDostupniProvider.getByIds
      //print('Fetched data: $data'); // Debugging line

      setState(() {
        _dataList = data as List<KorisniciPregled>;

        // _buildDataListView();
      });

      //_buildDataListView();
    } catch (e) {
      // Handle the error here if needed
      print('Error fetching data: $e');
      _showDialog(context, "Error",
          "Došlo je do greške string is not subtype of num"); // Debugging line
    }
    // setState(() async {
    //   var data = await _rezervacijeBiciklDostupniProvider!
    //       .getRezervacijeDostupni(_dateController.text as DateTime);
    //   _buildDataListView();
    //    print('Fetched data: $data'); // Debugging line
    // });

    //_updateKorisnikData();

    // await _rezervacijePregledProvider?.getRezervacijeDostupni(RezervacijePregled());
    // // currentUser = await _korisniciDetaljiProvider
    // //     ?.getProfilKorisnika(korisnikDetalji!.korisnickoIme!);
    // await _showDialog(
    //     context, 'Success', 'Učitavaju se podaci za novog korisnika...');
    // // _updateTuristickiVodicData();
    // await _turistickiVodiciDetaljiProvider?.patch(
    //     turistickiVodicid!, turistickiVodicDetalji);
  }

  // void _updateKorisnikData() {
  //   setState(() {
  //     korisnikDetalji!.korisnikId = korisnikid;
  //     korisnikDetalji!.aktivan = true;
  //     if (_selectedValue != null) {
  //       korisnikDetalji!.drzavaID = _selectedValue!.drzavaID;
  //     } else {
  //       korisnikDetalji!.drzavaID = _selectedDrzava!.drzavaID;
  //     }

  //     korisnikDetalji!.ime = _imeController.text;
  //     korisnikDetalji!.prezime = _prezimeController.text;
  //     korisnikDetalji!.telefon = _telefonController.text;
  //     korisnikDetalji!.ulogaID = 3;
  //     korisnikDetalji!.aktivan = true;
  //     // dupliEmail = isPostojeciEmail(_emailController.text);
  //     // if (!dupliEmail) {
  //     korisnikDetalji!.email = _emailController.text;
  //     // }

  //     korisnikDetalji!.korisnickoIme = _korisnickoImeController.text;

  //     korisnikDetalji!.ime = _imeController.text;
  //     korisnikDetalji!.prezime = _prezimeController.text;
  //     korisnikDetalji!.telefon = _telefonController.text;
  //     korisnikDetalji!.ulogaID = 3;

  //     turistickiVodicDetalji!.naziv = _nazivController.text;
  //     turistickiVodicDetalji!.jezik = _jezikController.text;

  //     // Print the value of _cijenaController.text for debugging
  //     print('Cijena text: ${_cijenaController.text}');

  //     // Ensure proper parsing and handle errors
  //     double? parsedCijena = double.tryParse(_cijenaController.text);
  //     if (parsedCijena != null) {
  //       // Print the parsed value for debugging
  //       print('Parsed Cijena: $parsedCijena');

  //       // Assign the parsed double to cijena
  //       turistickiVodicDetalji!.cijenaVodica = parsedCijena;
  //     } else {
  //       // Handle invalid input if needed
  //       turistickiVodicDetalji!.cijenaVodica = 0.0;
  //     }

  //     // Print the final value of cijena for debugging
  //     print('Final Cijena: ${turistickiVodicDetalji!.cijenaVodica}');
  //     print('Final naziv:${turistickiVodicDetalji!.naziv} ');
  //     print('Final jezik:${turistickiVodicDetalji!.jezik} ');
  //   });
  // }

  Future<void> _handleSubmissionError(e) async {
    await _showDialog(context, 'Error', 'Došlo je do greške!');
  }

  // _selectDate() async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: dateTime,
  //       initialDatePickerMode: DatePickerMode.day,
  //       firstDate: DateTime.now(),
  //       lastDate: DateTime(2101));
  //   if (picked != null) {
  //     dateTime = picked;
  //     //assign the chosen date to the controller
  //     _dateController.text = DateFormat('dd-MM-yyyy').format(dateTime);
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

// ignore: non_constant_identifier_names
MenuBar Menu(BuildContext context) {
  return MenuBar(
    children: <Widget>[
      SubmenuButton(
        menuChildren: <Widget>[
          MenuItemButton(
            onPressed: () async {
              showAboutDialog(
                context: context,
                applicationName: 'Potrebno napraviti profil korisnika',
                applicationVersion: '1.7.',
              );
            },
            child: const MenuAcceleratorLabel('Profil korisnika'),
          ),
          MenuItemButton(
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'RentABikeWTR',
                applicationVersion: '1.7.',
              );
            },
            child: const MenuAcceleratorLabel('&O aplikaciji'),
          ),
          MenuItemButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyMaterialApp(),
                ),
              );
            },
            child: const MenuAcceleratorLabel('&Odjava'),
          ),
        ],
        child: const MenuAcceleratorLabel('&Glavni meni'),
      ),
      SubmenuButton(
        menuChildren: <Widget>[],
        child: const MenuAcceleratorLabel('&Admin portal'),
      ),
      SubmenuButton(
        menuChildren: <Widget>[
          MenuItemButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ListaKorisniciScreen(),
                ),
              );
            },
            child: const MenuAcceleratorLabel('Lista korisnika'),
          ),
          MenuItemButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DodajKorisnikaScreen(),
                ),
              );
            },
            child: const MenuAcceleratorLabel('Dodaj korisnika'),
          ),
        ],
        child: const MenuAcceleratorLabel('&Korisnici'),
      ),
      SubmenuButton(
        menuChildren: <Widget>[
          MenuItemButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ListaVodiciScreen(),
                ),
              );
            },
            child: const MenuAcceleratorLabel('Lista vodica'),
          ),
          MenuItemButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DodajVodicaScreen(),
                ),
              );
            },
            child: const MenuAcceleratorLabel('Dodaj vodica'),
          ),
        ],
        child: const MenuAcceleratorLabel('&Vodici'),
      ),
      SubmenuButton(
        menuChildren: <Widget>[
          MenuItemButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RezervacijaListaRezervacijaScreen(),
                ),
              );
            },
            child: const MenuAcceleratorLabel('Lista rezervacija'),
          ),
          MenuItemButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RezervacijaKorak1Screen(),
                ),
              );
            },
            child: const MenuAcceleratorLabel('Dodaj rezervaciju'),
          ),
        ],
        child: const MenuAcceleratorLabel('&Rezervacije'),
      ),
      SubmenuButton(
        menuChildren: <Widget>[
          MenuItemButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PeriodicniIzvjestajRezervacijeScreen(),
                ),
              );
            },
            child: const MenuAcceleratorLabel('Periodicni izvjestaj'),
          ),
        ],
        child: const MenuAcceleratorLabel('&Izvjestaji'),
      ),
    ],
  );
}

class MenuAcceleratorApp extends StatelessWidget {
  const MenuAcceleratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          const SingleActivator(LogicalKeyboardKey.keyT, control: true):
              VoidCallbackIntent(() {
            debugDumpApp();
          }),
        },
        child: Scaffold(
          body: SafeArea(
            child: RezervacijaKupacKorak4Screen(
                argumentsB: RezervacijeBiciklDostupni(),
                argumentsT: TuristRutePregled(),
                datumPretrage: DateTime.now()),
          ),
        ),
      ),
    );
  }
}
