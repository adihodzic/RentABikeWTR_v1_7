import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:image/image.dart' as img;

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/bicikli.dart';
import 'package:rentabikewtr_desktop/model/bicikliDetalji.dart';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/model/dezurnaVozilaPregled.dart';
import 'package:rentabikewtr_desktop/model/drzave.dart';
import 'package:rentabikewtr_desktop/model/korisniciDetalji.dart';
import 'package:rentabikewtr_desktop/model/korisniciPregled.dart';
import 'package:rentabikewtr_desktop/model/korisniciUpsert.dart';
import 'package:rentabikewtr_desktop/model/modeliBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/poslovnicePregled.dart';
import 'package:rentabikewtr_desktop/model/poziviDezurnomVozilu.dart';
import 'package:rentabikewtr_desktop/model/poziviDezurnomVoziluPregled.dart';
import 'package:rentabikewtr_desktop/model/proizvodjaciBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/statusiPregled.dart';
import 'package:rentabikewtr_desktop/model/tipoviBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/turistRute.dart';
import 'package:rentabikewtr_desktop/model/turistRuteDetalji.dart';
import 'package:rentabikewtr_desktop/model/turistRutePregled.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodici.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodiciUpsert.dart';
import 'package:rentabikewtr_desktop/model/velicineBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/providers/bicikliPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/bicikli_detalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/bicikli_provider.dart';
import 'package:rentabikewtr_desktop/providers/dezurnaVozilaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/drzave_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisnici_provider.dart';
import 'package:rentabikewtr_desktop/providers/modeliBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/poslovnicePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/poziviDezurnomVozilu_provider.dart';
import 'package:rentabikewtr_desktop/providers/proizvodjaciBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/tipoviBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistRutePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistRute_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_desktop/providers/velicineBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_bicikli_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_poziviDezurnomVozilu_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_turistRute_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';
import 'package:rentabikewtr_desktop/widgets/menuAdmin.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class DodajPozivDezurnomVoziluScreen extends StatefulWidget {
  DodajPozivDezurnomVoziluScreen({super.key});

  @override
  State<DodajPozivDezurnomVoziluScreen> createState() =>
      _DodajPozivDezurnomVoziluScreenState();
}

class _DodajPozivDezurnomVoziluScreenState
    extends State<DodajPozivDezurnomVoziluScreen> {
  TextEditingController _viseDetaljaController = TextEditingController();
  TextEditingController _datumPozivaController = TextEditingController();
  TextEditingController _vrijemePozivaController = TextEditingController();
  TextEditingController _nazivDezurnogVozilaController =
      TextEditingController();
  TextEditingController _nazivController = TextEditingController();
  TextEditingController _nazivPoslovniceController = TextEditingController();

  PoziviDezurnomVozilu?
      pozivDezurnomVozilu; //-- ako koristimo prosljeđivanje objekta

  PoziviDezurnomVoziluProvider? _poziviDezurnomVoziluProvider = null;
  DezurnaVozilaPregledProvider? _dezurnaVozilaPregledProvider = null;
  TuristickiVodiciPregledProvider? _turistickiVodiciPregledProvider = null;
  PoslovnicePregledProvider? _poslovnicePregledProvider = null;

  List<DezurnaVozilaPregled> dezurnaVozila = [];
  DezurnaVozilaPregled? dezurnoVozilo;
  DezurnaVozilaPregled? _selectedDezurnoVozilo;

  List<TuristickiVodici> turistickiVodici = [];
  TuristickiVodici? turistickiVodic;
  TuristickiVodici? _selectedTuristickiVodic;

  List<PoslovnicePregled> poslovnice = [];
  PoslovnicePregled? poslovnica;
  PoslovnicePregled? _selectedPoslovnica;
  DateTime dateTime = DateTime.now();
  bool isNesreca = false;
  bool isKvar = false;
  bool isLosiVremenskiUslovi = false;
  bool isZahtjevKlijenta = false;
  bool nemaRazloga = false;

  GlobalKey<FormState>? _formKey; // potrebno za validaciju
  //bool isEmail(String input) => EmailValidator.validate(input);
  bool isEmail(String input) {
    if (EmailValidator.validate(input)) {
      // potrebno za validaciju
      return true;
    } else {
      return false;
    }
  }

  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input); // potrebno za validaciju

  bool isCijena(String input) {
    // This regular expression allows numbers like 1, 1.0, 12.34, 123.456, etc.
    final RegExp regex = RegExp(r'^\d+(\.\d+)$');
    return regex.hasMatch(input);
  } // potrebno za validaciju

  bool dupliEmail = true;
  bool duploKorIme = true;

  //TextEditingController _date = TextEditingController();

  @override
  void initState() {
    _formKey = GlobalKey(); // potrebno za validaciju

    //slika = widget.argumentsB.slika;
    _poziviDezurnomVoziluProvider =
        context.read<PoziviDezurnomVoziluProvider>();
    _dezurnaVozilaPregledProvider =
        context.read<DezurnaVozilaPregledProvider>();
    _turistickiVodiciPregledProvider =
        context.read<TuristickiVodiciPregledProvider>();
    _poslovnicePregledProvider = context.read<PoslovnicePregledProvider>();

    pozivDezurnomVozilu = PoziviDezurnomVozilu(
        viseDetalja: null,
        nesreca: false,
        zahtjevKlijenta: false,
        kvar: false,
        losiVremenskiUslovi: false,
        datumPoziva: null,
        vrijemePoziva: null,
        dezurnoVoziloID: null,
        turistickiVodicID: null,
        poslovnicaID: null);

    loadData(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {});
    super.initState();
  }

  Future loadData() async {
    var tmpTuristickiVodiciPregled =
        await _turistickiVodiciPregledProvider?.get();

    var tmpDezurnaVozilaPregled = await _dezurnaVozilaPregledProvider?.get();

    var tmpPoslovnicePregled = await _poslovnicePregledProvider?.get();

    setState(() {
      turistickiVodici = tmpTuristickiVodiciPregled!;
      dezurnaVozila = tmpDezurnaVozilaPregled!;
      poslovnice = tmpPoslovnicePregled!;
      _datumPozivaController.text = DateFormat('dd-MM-yyyy').format(dateTime);
      _vrijemePozivaController.text = DateFormat('hh:mm').format(dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      // potrebno za validaciju

      key: _formKey, // potrebno za validaciju
      child: Column(
        children: <Widget>[
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
                            "RentABikeWTR -Poziv dežurnom vozilu",
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
                                      maxHeight: 360),
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
                                          16, 20, 16, 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              "Vozilo",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 135, 134, 134)),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          DropdownButtonFormField<
                                              DezurnaVozilaPregled>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      16, 0, 16, 0),
                                              hintText:
                                                  'Odaberite dežurno vozilo',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedDezurnoVozilo,
                                            //value: _selectedValue,
                                            onChanged: (DezurnaVozilaPregled?
                                                newValue) {
                                              setState(() {
                                                _selectedDezurnoVozilo =
                                                    newValue;
                                              });
                                            },
                                            items: dezurnaVozila!.map(
                                                (DezurnaVozilaPregled
                                                    dezurnoVozilo) {
                                              //bilo je Drzave drzava
                                              return DropdownMenuItem<
                                                  DezurnaVozilaPregled>(
                                                value: dezurnoVozilo,
                                                //value: drzava,
                                                child: Text(dezurnoVozilo
                                                    .nazivDezurnogVozila!),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Odaberite dežurno vozilo';
                                              }
                                              return null;
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              "Turisticki vodic",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 135, 134, 134)),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          DropdownButtonFormField<
                                              TuristickiVodici>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      16, 0, 16, 0),
                                              hintText:
                                                  'Odaberite turističkog vodiča',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedTuristickiVodic,
                                            //value: _selectedValue,
                                            onChanged:
                                                (TuristickiVodici? newValue) {
                                              setState(() {
                                                _selectedTuristickiVodic =
                                                    newValue;
                                              });
                                            },
                                            items: turistickiVodici.map(
                                                (TuristickiVodici
                                                    turistickiVodic) {
                                              //bilo je Drzave drzava
                                              return DropdownMenuItem<
                                                  TuristickiVodici>(
                                                value: turistickiVodic,
                                                //value: drzava,
                                                child: Text(
                                                    turistickiVodic.naziv!),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Odaberite Vodiča';
                                              }
                                              return null;
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              "Poslovnica",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 135, 134, 134)),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          DropdownButtonFormField<
                                              PoslovnicePregled>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      16, 0, 16, 0),
                                              hintText: 'Odaberite poslovnicu',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedPoslovnica,
                                            //value: _selectedValue,
                                            onChanged:
                                                (PoslovnicePregled? newValue) {
                                              setState(() {
                                                _selectedPoslovnica = newValue;
                                              });
                                            },
                                            items: poslovnice!.map(
                                                (PoslovnicePregled poslovnica) {
                                              //bilo je Drzave drzava
                                              return DropdownMenuItem<
                                                  PoslovnicePregled>(
                                                value: poslovnica,
                                                //value: drzava,
                                                child: Text(poslovnica
                                                    .nazivPoslovnice!),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Odaberite Poslovnicu';
                                              }
                                              return null;
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
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
                                      maxHeight: 360),
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
                                            controller: _viseDetaljaController,
                                            minLines: 1,
                                            maxLines: 3,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Više detalja",
                                                hintText: ''),
                                            maxLength: 100,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Ovo je obavezno polje.';
                                              } else if (value
                                                      .characters.length <
                                                  3) {
                                                return 'Minimalno 3(tri) karaktera.';
                                              } else {
                                                return null;
                                              }
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            controller: _datumPozivaController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Datum poziva",
                                                hintText: ''),
                                            maxLength: 20,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            controller:
                                                _vrijemePozivaController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Vrijeme poziva",
                                                hintText: ''),
                                            maxLength: 20,
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
                                      maxHeight: 360),
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
                                          16, 20, 16, 10),
                                      child: Column(
                                        children: [
                                          CheckboxListTile(
                                              title: Text("Nesreća: "),
                                              value: isNesreca,
                                              onChanged: (cekirano) {
                                                setState(() {
                                                  isNesreca = cekirano!;
                                                });
                                              }),
                                          SizedBox(height: 20),
                                          CheckboxListTile(
                                              title: Text("Kvar: "),
                                              value: isKvar,
                                              onChanged: (cekirano) {
                                                setState(() {
                                                  isKvar = cekirano!;
                                                });
                                              }),
                                          SizedBox(height: 20),
                                          CheckboxListTile(
                                              title: Text("Zahtjev klijenta: "),
                                              value: isZahtjevKlijenta,
                                              onChanged: (cekirano) {
                                                setState(() {
                                                  isZahtjevKlijenta = cekirano!;
                                                });
                                              }),
                                          SizedBox(height: 20),
                                          CheckboxListTile(
                                              title: Text(
                                                  "Loši vremenski uslovi: "),
                                              value: isLosiVremenskiUslovi,
                                              onChanged: (cekirano) {
                                                setState(() {
                                                  isLosiVremenskiUslovi =
                                                      cekirano!;
                                                });
                                              }),
                                          SizedBox(height: 20),
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
                                                  child: Text("Otkaži"),
                                                  onPressed: () async {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ListaPoziviDezurnomVoziluScreen(),
                                                      ),
                                                    );
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
                                                            'Uspješno kreirali poziv dežurnom vozilu!');
                                                        await Navigator.of(
                                                                context)
                                                            .push(MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ListaPoziviDezurnomVoziluScreen()));
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
        ],
      ),
    ));
  }

  Future<void> _handleFormSubmission() async {
    // try{
    _updatePoziviDezurnomVoziluData();
    if (!isKvar && !isNesreca && !isLosiVremenskiUslovi && !isZahtjevKlijenta) {
      nemaRazloga = true;
      throw Exception();
    } else {
      await _poziviDezurnomVoziluProvider?.insert(pozivDezurnomVozilu);

      await _showDialog(context, 'Success',
          'Učitavaju se podaci za poziv dežurnom vozilu...');
    }
    // }catch(e){
    //_showDialog(context, "Greška", e.toString());
    // }
  }

  void _updatePoziviDezurnomVoziluData() {
    setState(() {
      pozivDezurnomVozilu!.viseDetalja = _viseDetaljaController.text;
      pozivDezurnomVozilu!.nesreca = isNesreca;
      pozivDezurnomVozilu!.kvar = isKvar;
      pozivDezurnomVozilu!.losiVremenskiUslovi = isLosiVremenskiUslovi;
      pozivDezurnomVozilu!.zahtjevKlijenta = isZahtjevKlijenta;
      pozivDezurnomVozilu!.dezurnoVoziloID =
          _selectedDezurnoVozilo!.dezurnoVoziloId;
      pozivDezurnomVozilu!.turistickiVodicID =
          _selectedTuristickiVodic!.turistickiVodicId;
      pozivDezurnomVozilu!.poslovnicaID = _selectedPoslovnica!.poslovnicaId;
      pozivDezurnomVozilu!.datumPoziva = dateTime;
      pozivDezurnomVozilu!.vrijemePoziva = dateTime;
    });
  }

  Future<void> _handleSubmissionError(e) async {
    if (nemaRazloga) {
      await _showDialog(context, 'Error', 'Odaberite razlog poziva');
    } else {
      await _showDialog(context, 'Error', 'Došlo je do greške!');
      print('Greška:Poruka o kontekstu greške $e');
    }
  }

  void validateController() {
    if (!_formKey!.currentState!.validate()) {
      _showDialog(context, 'Error', 'Pogrešan unos pokušajte ponovo');
      // value is false.. textFields are rebuilt in order to show errorLabels
      return;
    } else {
      _showDialog(context, 'Success', 'Uspješno ste unijeli poziv');
    }
    // action WHEN values are valid
  }

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
