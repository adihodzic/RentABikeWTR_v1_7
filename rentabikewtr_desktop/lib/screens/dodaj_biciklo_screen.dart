import 'dart:convert';
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
import 'package:rentabikewtr_desktop/model/drzave.dart';
import 'package:rentabikewtr_desktop/model/korisniciDetalji.dart';
import 'package:rentabikewtr_desktop/model/korisniciPregled.dart';
import 'package:rentabikewtr_desktop/model/korisniciUpsert.dart';
import 'package:rentabikewtr_desktop/model/modeliBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/poslovnicePregled.dart';
import 'package:rentabikewtr_desktop/model/proizvodjaciBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/statusiPregled.dart';
import 'package:rentabikewtr_desktop/model/tipoviBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodici.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodiciUpsert.dart';
import 'package:rentabikewtr_desktop/model/velicineBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/providers/bicikliPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/bicikli_detalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/bicikli_provider.dart';
import 'package:rentabikewtr_desktop/providers/drzave_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisnici_provider.dart';
import 'package:rentabikewtr_desktop/providers/modeliBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/poslovnicePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/proizvodjaciBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/tipoviBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_desktop/providers/velicineBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_bicikli_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';
import 'package:rentabikewtr_desktop/widgets/menuAdmin.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class DodajBicikloScreen extends StatefulWidget {
  DodajBicikloScreen({super.key});

  @override
  State<DodajBicikloScreen> createState() => _DodajBicikloScreenState();
}

class _DodajBicikloScreenState extends State<DodajBicikloScreen> {
  TextEditingController _imeController = TextEditingController();

  TextEditingController _nazivBiciklaController = TextEditingController();
  TextEditingController _cijenaBiciklaController = TextEditingController();
  TextEditingController _bojaController = TextEditingController();
  //TextEditingController _slikaController = TextEditingController();
  TextEditingController _nazivModelaController = TextEditingController();
  TextEditingController _nazivTipaController = TextEditingController();
  TextEditingController _nazivProizvodjacaController = TextEditingController();
  TextEditingController _nazivPoslovniceController = TextEditingController();
  TextEditingController _godinaProizvodnjeController = TextEditingController();
  TextEditingController _nazivVelicineController = TextEditingController();
  TextEditingController _nabavnaCijenaController = TextEditingController();
  TextEditingController _nazivDrzaveController = TextEditingController();
  TextEditingController _vrstaRamaController = TextEditingController();

//   List<KorisniciPregled> korisniciPregled = [];

  DateTime? dateTime = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  //TextEditingController _passwordPotvrdaController = TextEditingController();

  //BicikliPregled? argumentsB; //-- ako koristimo prosljeđivanje objekta

  List<KorisniciPregled> korisniciPregled = [];
  File? _imageFile;
  String? slika; //moram zbog izmjene slike...da bi se na InitState primijenila
  String? novaSlika;
  final int _maxFileSize = 250 * 1024; // 250 KB slika

  List<Drzave>? drzave = [];
  Drzave? _selectedDrzava;
  Drzave? _selectedValue;
  String? _nazivDrzave;
  //Drzave _selectedDrzava = Drzave();
  int korisnikid = 0;
  int drzavaid = 0;
  var dateReg = DateTime.now();
  int? turistickiVodicid;
  DrzaveProvider? _drzaveProvider = null;

  BicikliProvider? _bicikliProvider = null;
  ModeliBiciklaPregledProvider? _modeliBiciklaPregledProvider = null;
  TipoviBiciklaPregledProvider? _tipoviBiciklaPregledProvider = null;
  ProizvodjaciBiciklaPregledProvider? _proizvodjaciBiciklaPregledProvider =
      null;
  PoslovnicePregledProvider? _poslovnicePregledProvider = null;
  VelicineBiciklaPregledProvider? _velicineBiciklaPregledProvider = null;

  // KorisniciProvider? _korisniciProvider = null;
  // KorisniciDetaljiProvider? _korisniciDetaljiProvider = null;
  // KorisniciPregledProvider? _korisniciPregledProvider = null;
  //KorisniciUpsert? korisnik;
  BicikliPregled? currentBic;
  List<Bicikli> bicevi = [];
  Bicikli? bic;

  List<ModeliBiciklaPregled> modeli = [];
  ModeliBiciklaPregled? model;

  ModeliBiciklaPregled? _selectedModel;
  ModeliBiciklaPregled? _selectedValueM;
  String? _nazivModela;

  List<TipoviBiciklaPregled> tipovi = [];
  TipoviBiciklaPregled? tip;
  TipoviBiciklaPregled? _selectedTip;
  TipoviBiciklaPregled? _selectedValueT;
  String? _nazivTipa;

  List<ProizvodjaciBiciklaPregled> proizvodjaci = [];
  ProizvodjaciBiciklaPregled? proizvodjac;

  ProizvodjaciBiciklaPregled? _selectedProizvodjac;
  ProizvodjaciBiciklaPregled? _selectedValuePr;
  String? _nazivProizvodjaca;

  PoslovnicePregled? poslovnica;
  List<PoslovnicePregled> poslovnice = [];

  PoslovnicePregled? _selectedPoslovnica;
  PoslovnicePregled? _selectedValuePos;
  String? _nazivPoslovnice;

  int? statusID = 1;

  List<VelicineBiciklaPregled> velicine = [];
  VelicineBiciklaPregled? velicina;

  VelicineBiciklaPregled? _selectedVelicina;
  VelicineBiciklaPregled? _selectedValueV;
  String? _nazivVelicine;

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
    _defaultImage();
    //slika = widget.argumentsB.slika;
    _bicikliProvider = context.read<BicikliProvider>();
    _tipoviBiciklaPregledProvider =
        context.read<TipoviBiciklaPregledProvider>();
    _modeliBiciklaPregledProvider =
        context.read<ModeliBiciklaPregledProvider>();
    _proizvodjaciBiciklaPregledProvider =
        context.read<ProizvodjaciBiciklaPregledProvider>();
    _poslovnicePregledProvider = context.read<PoslovnicePregledProvider>();
    //_statusiPregledProvider = context.read<StatusiPregledProvider>();
    _velicineBiciklaPregledProvider =
        context.read<VelicineBiciklaPregledProvider>();
    // _korisniciDetaljiProvider = context.read<KorisniciDetaljiProvider>();

    _drzaveProvider = context.read<DrzaveProvider>();

    bic = Bicikli(
      poslovnicaID: null,
      nazivBicikla: null,
      cijenaBicikla: null,
      boja: null,
      slika: null,
      modelBiciklaID: null,
      tipBiciklaID: null,
      proizvodjacBiciklaID: null,
      drzavaID: null,
      nabavnaCijena: null,
      vrstaRama: null,
      godinaProizvodnje: null,
      statusID: null,
      velicinaBiciklaID: null,
      datumOtpisa: null,
    );

    loadData(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {});
    super.initState();
  }

  Future loadData() async {
    var tmpData = await _drzaveProvider?.get();

    var tmpModeli = await _modeliBiciklaPregledProvider?.get();
    var tmpTipovi = await _tipoviBiciklaPregledProvider?.get();
    var tmpProizvodjaci = await _proizvodjaciBiciklaPregledProvider?.get();
    var tmpPoslovnice = await _poslovnicePregledProvider?.get();
    //var tmpStatusi=await _statusiPregledProvider?.get();
    var tmpvelicineBicikla = await _velicineBiciklaPregledProvider?.get();

    setState(() {
      //DateTime? pickedDate = DateTime.now();
      //_dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      drzave = tmpData!;
      modeli = tmpModeli!;
      tipovi = tmpTipovi!;
      proizvodjaci = tmpProizvodjaci!;
      poslovnice = tmpPoslovnice!;
      velicine = tmpvelicineBicikla!;
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
                          Container(
                            height: 70,
                            width: 500,
                            child: imageFromBase64String(slika ?? ""),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "RentABikeWTR -Dodaj biciklo",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 11, 7, 255)),
                          ),
                          SizedBox(
                            height: 2,
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
                                      maxHeight: 430),
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
                                          16, 10, 16, 10),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            readOnly: true,
                                            controller: _nazivBiciklaController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Naziv bicikla",
                                                hintText:
                                                    'Odaberite proizvođača i model'),
                                            //maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Naziv je obavezno polje.';
                                              } else if (value
                                                      .characters.length <
                                                  3) {
                                                return 'Mora da sadrži minimalno 3(tri) karaktera.';
                                              } else {
                                                return null;
                                              }
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
                                              "Model bicikla",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 135, 134, 134)),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          DropdownButtonFormField<
                                              ModeliBiciklaPregled>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 0, 16, 0),
                                              hintText: 'Odaberite model',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedModel,
                                            //value: _selectedValue,
                                            onChanged: (ModeliBiciklaPregled?
                                                newValue) {
                                              setState(() {
                                                _selectedModel = newValue;
                                                _nazivBiciklaController.text =
                                                    "${_selectedProizvodjac?.nazivProizvodjaca}" +
                                                        " " +
                                                        "${newValue!.nazivModela}";
                                              });
                                            },
                                            items: modeli!.map(
                                                (ModeliBiciklaPregled model) {
                                              //bilo je Drzave drzava
                                              return DropdownMenuItem<
                                                  ModeliBiciklaPregled>(
                                                value: model,
                                                //value: drzava,
                                                child: Text(model.nazivModela!),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Odaberite model';
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
                                              "Tip bicikla",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 135, 134, 134)),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          DropdownButtonFormField<
                                              TipoviBiciklaPregled>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 0, 16, 0),
                                              hintText: 'Odaberite tip',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedTip,
                                            //value: _selectedValue,
                                            onChanged: (TipoviBiciklaPregled?
                                                newValue) {
                                              setState(() {
                                                _selectedTip = newValue;
                                              });
                                            },
                                            items: tipovi!.map(
                                                (TipoviBiciklaPregled tip) {
                                              //bilo je Drzave drzava
                                              return DropdownMenuItem<
                                                  TipoviBiciklaPregled>(
                                                value: tip,
                                                //value: drzava,
                                                child: Text(tip.nazivTipa!),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Odaberite tip';
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
                                              "Naziv proizvođača",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 135, 134, 134)),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          DropdownButtonFormField<
                                              ProizvodjaciBiciklaPregled>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 0, 16, 0),
                                              hintText: 'Odaberite proizvođača',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedValuePr,
                                            //value: _selectedValue,
                                            onChanged:
                                                (ProizvodjaciBiciklaPregled?
                                                    newValue) {
                                              setState(() {
                                                _selectedProizvodjac = newValue;

                                                _nazivBiciklaController.text =
                                                    "${newValue!.nazivProizvodjaca}" +
                                                        " " +
                                                        "${_selectedModel?.nazivModela}";
                                              });
                                            },
                                            items: proizvodjaci!.map(
                                                (ProizvodjaciBiciklaPregled
                                                    proizvodjac) {
                                              //bilo je Drzave drzava
                                              return DropdownMenuItem<
                                                  ProizvodjaciBiciklaPregled>(
                                                value: proizvodjac,
                                                //value: drzava,
                                                child: Text(proizvodjac
                                                    .nazivProizvodjaca!),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Odaberite proizvođača';
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
                              // SizedBox(
                              //   width: 160,
                              // ),
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100,
                                      maxWidth: 300,
                                      minHeight: 100,
                                      maxHeight: 430),
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
                                          16, 10, 16, 10),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _bojaController,
                                            decoration: const InputDecoration(
                                                // errorStyle: TextStyle(
                                                //   fontSize:
                                                //       12.0, // Adjust font size
                                                //   height:
                                                //       0, // Reduces space between field and error text
                                                // ),
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Boja",
                                                hintText:
                                                    'npr. Vodic-engleski'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                const EdgeInsets.all(0.0);
                                                String errorString =
                                                    "Boja je obavezno polje";
                                                return errorString;
                                              } else if (value
                                                      .characters.length <
                                                  3) {
                                                return 'Mora da sadrži minimalno 3(tri) karaktera.';
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
                                            controller: _vrstaRamaController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Vrsta rama",
                                                hintText: 'Unesite vrstu rama'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Vrsta rama je obavezno polje.';
                                              } else if (value
                                                      .characters.length <
                                                  3) {
                                                return 'Mora da sadrži minimalno 3(tri) karaktera.';
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
                                            controller:
                                                _cijenaBiciklaController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Cijena",
                                                hintText: '10.0'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Cijena je obavezno polje.';
                                              } else if (!isCijena(value)) {
                                                return 'Cijena mora biti u formatu broja ##.#.';
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
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              "Veličina bicikla",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 135, 134, 134)),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          DropdownButtonFormField<
                                              VelicineBiciklaPregled>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 0, 16, 0),
                                              hintText: 'Odaberite veličinu',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedVelicina,
                                            //value: _selectedValue,
                                            onChanged: (VelicineBiciklaPregled?
                                                newValue) {
                                              setState(() {
                                                _selectedVelicina = newValue!;
                                              });
                                            },
                                            items: velicine.map(
                                                (VelicineBiciklaPregled
                                                    velicina) {
                                              //bilo je Drzave drzava
                                              return DropdownMenuItem<
                                                  VelicineBiciklaPregled>(
                                                value: velicina,
                                                //value: drzava,
                                                child: Text(
                                                    velicina.nazivVelicine!),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Odaberite veličinu';
                                              }
                                              return null;
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        Colors.grey),
                                                onPressed: _pickImage,
                                                child: Text('Upload slike...'),
                                              ),
                                            ],
                                          )
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
                                      maxHeight: 430),
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
                                          16, 10, 16, 10),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _dateController,
                                            onTap: _selectDate,
                                            maxLength: 20,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 0, 16, 0),
                                              border: OutlineInputBorder(),
                                              labelText: "Godina proizvodnje",
                                              hintText: 'Godina proizvodnje',
                                              // hintText:
                                              //     "Click here to select date"
                                            ),
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller:
                                                _nabavnaCijenaController,
                                            decoration: const InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 0, 16, 0),
                                                border: OutlineInputBorder(),
                                                labelText: "Nabavna cijena",
                                                hintText: '10.0'),
                                            //maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Nabavna cijena je obavezno polje.';
                                              } else if (!isCijena(value)) {
                                                return 'Cijena mora biti u formatu broja ###.# ';
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
                                                  const EdgeInsets.fromLTRB(
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              "Država porijekla",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 135, 134, 134)),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          DropdownButtonFormField<Drzave>(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 0, 16, 0),
                                              hintText: 'Odaberite državu',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedDrzava,
                                            //value: _selectedValue,
                                            onChanged: (Drzave? newValue) {
                                              setState(() {
                                                _selectedDrzava = newValue;
                                              });
                                            },
                                            items: drzave!.map((Drzave drzava) {
                                              //bilo je Drzave drzava
                                              return DropdownMenuItem<Drzave>(
                                                value: drzava,
                                                //value: drzava,
                                                child:
                                                    Text(drzava.nazivDrzave!),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Odaberite državu';
                                              }
                                              return null;
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                          ),
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
                                                            ListaBicikliScreen(),
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
                                                            'Uspješno ste editovali detalje bicikla');
                                                        await Navigator.of(
                                                                context)
                                                            .push(MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ListaBicikliScreen()));
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
    _updateKorisnikData();
    await _bicikliProvider?.insert(bic);

    await _showDialog(
        context, 'Success', 'Učitavaju se podaci za novo biciklo...');
  }

  void _updateKorisnikData() {
    setState(() {
      bic!.statusID = 1;
      bic!.nazivBicikla = _nazivBiciklaController.text;
      bic!.modelBiciklaID = _selectedModel!.modelBiciklaId;
      bic!.tipBiciklaID = _selectedTip!.tipBiciklaId;
      bic!.proizvodjacBiciklaID = _selectedProizvodjac!.proizvodjacBiciklaId!;
      bic!.boja = _bojaController.text;
      bic!.vrstaRama = _vrstaRamaController.text;
      bic!.cijenaBicikla = double.parse(_cijenaBiciklaController.text);
      bic!.nabavnaCijena = double.parse(_nabavnaCijenaController.text);
      bic!.velicinaBiciklaID = _selectedVelicina!.velicinaBiciklaId;
      bic!.slika = slika;

      bic!.godinaProizvodnje = dateTime;
      bic!.poslovnicaID = _selectedPoslovnica!.poslovnicaId;
      bic!.drzavaID = _selectedDrzava!.drzavaID;
    });
  }

  Future<void> _handleSubmissionError(e) async {
    await _showDialog(context, 'Error', 'Došlo je do greške!');
    print('Greška:Poruka o kontekstu greške $e');
  }

  bool isPostojeciEmail(String input) {
    var brojac = 0;
    for (var kor in korisniciPregled) {
      if (input == kor.email) {
        brojac = brojac + 1;
      }
    }
    if (brojac > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isPostojeceKorIme(String input) {
    var brojac = 0;
    for (var kor in korisniciPregled) {
      if (input == kor.korisnickoIme) {
        brojac = brojac + 1;
      }
    }
    if (brojac > 0) {
      return true;
    } else {
      return false;
    }
  }

  void validateController() {
    if (!_formKey!.currentState!.validate()) {
      _showDialog(context, 'Error', 'Pogrešan unos pokušajte ponovo');
      // value is false.. textFields are rebuilt in order to show errorLabels
      return;
    } else {
      _showDialog(context, 'Success', 'Uspješno ste unijeli novo biciklo');
    }
    // action WHEN values are valid
  }

  Future<void> _defaultImage() async {
    File file = File("assets/images/logo.jpg");
    // Check file size
    if (file.lengthSync() < _maxFileSize) {
      String base64Image = base64Encode(file.readAsBytesSync());
      setState(() {
        _imageFile = file;
        novaSlika = base64Image;
        slika = novaSlika; // Save to the Slika string object
      });
    } else {
      _showDialog(
          context, 'Greška', 'Dozvoljen je upload slike, veličine do 250KB');
      return;
    }
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      // Check file size
      if (file.lengthSync() < _maxFileSize) {
        String base64Image = base64Encode(file.readAsBytesSync());
        setState(() {
          _imageFile = file;
          novaSlika = base64Image;
          slika = novaSlika; // Save to the Slika string object
        });
      } else {
        _showDialog(
            context, 'Greška', 'Dozvoljen je upload slike, veličine do 250KB');
        return;
      }
    }
  }

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime!,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime.now());
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      _dateController.text = DateFormat('dd-MM-yyyy').format(dateTime!);
    }
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
