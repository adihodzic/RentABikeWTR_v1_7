import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:image/image.dart' as img;

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:rentabikewtr_desktop/model/bicikliDesktopPregled.dart';
import 'package:rentabikewtr_desktop/model/bicikliDetalji.dart';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/model/drzave.dart';

import 'package:rentabikewtr_desktop/model/korisniciPregled.dart';

import 'package:rentabikewtr_desktop/model/modeliBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/poslovnicePregled.dart';
import 'package:rentabikewtr_desktop/model/proizvodjaciBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/tipoviBiciklaPregled.dart';

import 'package:rentabikewtr_desktop/providers/bicikli_detalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/drzave_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisnici_provider.dart';
import 'package:rentabikewtr_desktop/providers/modeliBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/poslovnicePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/proizvodjaciBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/tipoviBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/screens/lista_bicikli_screen.dart';

import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';

import 'package:rentabikewtr_desktop/utils/util.dart';

import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class BicikliDetaljiScreen extends StatefulWidget {
  final BicikliDesktopPregled argumentsB;
  const BicikliDetaljiScreen({Key? key, required this.argumentsB})
      : super(key: key);

  @override
  State<BicikliDetaljiScreen> createState() => _BicikliDetaljiScreenState();
}

class _BicikliDetaljiScreenState extends State<BicikliDetaljiScreen> {
  TextEditingController _nazivBiciklaController = TextEditingController();
  TextEditingController _cijenaBiciklaController = TextEditingController();
  TextEditingController _bojaController = TextEditingController();
  //TextEditingController _slikaController = TextEditingController();
  TextEditingController _nazivModelaController = TextEditingController();
  TextEditingController _nazivTipaController = TextEditingController();
  TextEditingController _nazivProizvodjacaController = TextEditingController();
  TextEditingController _nazivPoslovniceController = TextEditingController();
  TextEditingController _godinaProizvodnjeController = TextEditingController();
  //TextEditingController _nazivVelicineController = TextEditingController();
  TextEditingController _nabavnaCijenaController = TextEditingController();
  TextEditingController _nazivDrzaveController = TextEditingController();
  TextEditingController _vrstaRamaController = TextEditingController();

  //TextEditingController _passwordController = TextEditingController();
  //TextEditingController _datumProizvodnjeController = TextEditingController();
  DateTime? pickedDate = DateTime.now();
  TextEditingController _date2Controller = TextEditingController();
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

  BicikliDetaljiProvider? _bicikliDetaljiProvider = null;
  ModeliBiciklaPregledProvider? _modeliBiciklaPregledProvider = null;
  TipoviBiciklaPregledProvider? _tipoviBiciklaPregledProvider = null;
  ProizvodjaciBiciklaPregledProvider? _proizvodjaciBiciklaPregledProvider =
      null;
  PoslovnicePregledProvider? _poslovnicePregledProvider = null;

  KorisniciProvider? _korisniciProvider = null;
  KorisniciDetaljiProvider? _korisniciDetaljiProvider = null;
  KorisniciPregledProvider? _korisniciPregledProvider = null;
  //KorisniciUpsert? korisnik;
  BicikliPregled? currentBic;
  List<BicikliDetalji> bicevi = [];
  BicikliDetalji? bic;

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

  @override
  void initState() {
    _formKey = GlobalKey();
    slika = widget.argumentsB.slika;
    _bicikliDetaljiProvider = context.read<BicikliDetaljiProvider>();
    _tipoviBiciklaPregledProvider =
        context.read<TipoviBiciklaPregledProvider>();
    _modeliBiciklaPregledProvider =
        context.read<ModeliBiciklaPregledProvider>();
    _proizvodjaciBiciklaPregledProvider =
        context.read<ProizvodjaciBiciklaPregledProvider>();
    _poslovnicePregledProvider = context.read<PoslovnicePregledProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _korisniciPregledProvider = context.read<KorisniciPregledProvider>();
    _korisniciDetaljiProvider = context.read<KorisniciDetaljiProvider>();

    _drzaveProvider = context.read<DrzaveProvider>();

    _korisniciDetaljiProvider = context.read<KorisniciDetaljiProvider>();

    loadBicikliDetalji(); //moram ovdje postaviti prije nego sto budem koristio argumentsKor
    setState(() {});
    super.initState();
  }

  Future<void> loadBicikliDetalji() async {
    var biciklid = widget.argumentsB.biciklID;
    var tmpBiciklDetalji = await _bicikliDetaljiProvider?.getById(biciklid!);

    var tmpData = await _drzaveProvider?.get();
    var tmpModeli = await _modeliBiciklaPregledProvider?.get();
    var tmpTipovi = await _tipoviBiciklaPregledProvider?.get();
    var tmpProizvodjaci = await _proizvodjaciBiciklaPregledProvider?.get();
    var tmpPoslovnice = await _poslovnicePregledProvider?.get();

    var tmpSelectedDrzava =
        await _drzaveProvider?.getById(tmpBiciklDetalji!.drzavaID!);
    var tmpSelectedTip = await _tipoviBiciklaPregledProvider
        ?.getById(tmpBiciklDetalji!.tipBiciklaID!);
    var tmpSelectedModel = await _modeliBiciklaPregledProvider
        ?.getById(tmpBiciklDetalji!.modelBiciklaID!);
    var tmpSelectedProizvodjac = await _proizvodjaciBiciklaPregledProvider
        ?.getById(tmpBiciklDetalji!.proizvodjacBiciklaID!);
    var tmpSelectedPoslovnica = await _poslovnicePregledProvider
        ?.getById(tmpBiciklDetalji!.poslovnicaID!);

    setState(() {
      bic = tmpBiciklDetalji;

      drzave = tmpData;
      _selectedDrzava = tmpSelectedDrzava;
      _nazivDrzave = _selectedDrzava!.nazivDrzave;

      modeli = tmpModeli!;
      _selectedModel = tmpSelectedModel;
      _nazivModela = _selectedModel!.nazivModela;

      tipovi = tmpTipovi!;
      _selectedTip = tmpSelectedTip;
      _nazivTipa = _selectedTip!.nazivTipa;

      proizvodjaci = tmpProizvodjaci!;
      _selectedProizvodjac = tmpSelectedProizvodjac;
      _nazivProizvodjaca = _selectedProizvodjac!.nazivProizvodjaca;

      poslovnice = tmpPoslovnice!;
      _selectedPoslovnica = tmpSelectedPoslovnica;
      _nazivPoslovnice = _selectedPoslovnica!.nazivPoslovnice;

      // poslovnica = tmpPoslovnica;
      _nazivBiciklaController.text = widget.argumentsB.nazivBicikla!;
      _cijenaBiciklaController.text = bic!.cijenaBicikla!.toString();
      _bojaController.text = bic!.boja!;

      _godinaProizvodnjeController.text =
          DateFormat('dd-MM-yyyy').format(bic!.godinaProizvodnje!);
      _vrstaRamaController.text = bic!.vrstaRama!;
      _nazivPoslovniceController.text = bic!.poslovnicaID!.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        //autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          Container(
                            height: 70,
                            width: 500,
                            child: imageFromBase64String(slika ?? ""),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // _imageFile == null
                          //     ? Text('No image selected.')
                          //     : Image.file(_imageFile!),
                          // SizedBox(height: 20),

                          Text(
                            "RentABikeWTR -Uredi detalje bicikla",
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
                                      maxHeight: 420),
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
                                            readOnly: true,
                                            controller: _nazivBiciklaController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Naziv bicikla",
                                                hintText: 'Unesite naziv'),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Naziv je obavezno polje.';
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
                                              hintText: '$_nazivModela',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedValueM,
                                            //value: _selectedValue,
                                            onChanged: (ModeliBiciklaPregled?
                                                newValue) {
                                              setState(() {
                                                _selectedValueM =
                                                    newValue ?? _selectedModel!;
                                                _nazivBiciklaController.text =
                                                    "${_selectedProizvodjac!.nazivProizvodjaca}" +
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
                                              hintText: '$_nazivTipa',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedValueT,
                                            //value: _selectedValue,
                                            onChanged: (TipoviBiciklaPregled?
                                                newValue) {
                                              setState(() {
                                                _selectedValueT =
                                                    newValue ?? _selectedTip!;
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
                                          ),
                                          SizedBox(
                                            height: 35,
                                          ),
                                          TextFormField(
                                            controller: _vrstaRamaController,
                                            decoration: const InputDecoration(
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
                                                return 'Minimalno 3(tri) karaktera.';
                                              } else {
                                                return null;
                                              }
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
                                      maxHeight: 350),
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
                                          TextFormField(
                                            controller: _bojaController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Boja",
                                                hintText: 'Unesite boju'),
                                            maxLength: 20,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Boja je obavezno polje.';
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
                                              hintText: '$_nazivProizvodjaca',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedValuePr,
                                            //value: _selectedValue,
                                            onChanged:
                                                (ProizvodjaciBiciklaPregled?
                                                    newValue) {
                                              setState(() {
                                                _selectedValuePr = newValue ??
                                                    _selectedProizvodjac!;
                                                _nazivBiciklaController.text =
                                                    "${newValue!.nazivProizvodjaca}" +
                                                        " " +
                                                        "${_selectedModel!.nazivModela}";
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
                                          ),
                                          SizedBox(
                                            height: 35,
                                          ),
                                          TextFormField(
                                            controller:
                                                _cijenaBiciklaController,
                                            decoration: const InputDecoration(
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
                                          SizedBox(height: 5),
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
                                      maxHeight: 420),
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
                                          16, 30, 16, 30),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            readOnly: true,
                                            controller:
                                                _godinaProizvodnjeController,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Godina proizvodnje",
                                                hintText: ''),
                                            maxLength: 20,
                                            // validator: (value) {
                                            //   if (value == null || value.isEmpty) {
                                            //     return 'E-mail je obavezno polje';
                                            //   } else if (!isEmail(value)) {
                                            //     return 'Pravilno unesite e-mail.';
                                            //     //   } else if (isPostojeciEmail(
                                            //     //       value)) {
                                            //     //     return 'Email već postoji!';
                                            //   } else {
                                            //     return null;
                                            //   }
                                            // },
                                            // autovalidateMode:
                                            //     AutovalidateMode.onUserInteraction,
                                          ),
                                          //SizedBox(height: 20),
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
                                              hintText: '$_nazivPoslovnice',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedValuePos,
                                            //value: _selectedValue,
                                            onChanged:
                                                (PoslovnicePregled? newValue) {
                                              setState(() {
                                                _selectedValuePos = newValue ??
                                                    _selectedPoslovnica!;
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
                                          ),

                                          SizedBox(
                                            height: 16,
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
                                              hintText: '$_nazivDrzave',
                                              border: OutlineInputBorder(),
                                            ),
                                            value: _selectedValue,
                                            //value: _selectedValue,
                                            onChanged: (Drzave? newValue) {
                                              setState(() {
                                                _selectedValue = newValue ??
                                                    _selectedDrzava!;
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
                                          ),

                                          SizedBox(height: 70),
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
                                                    Navigator.of(context).pop(
                                                        // MaterialPageRoute(
                                                        //   builder: (context) =>
                                                        //       ListaVodiciScreen(),
                                                        // ),
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
        ]),
      ),
    );
  }

  // MenuBar MenuAdmin(BuildContext context) => MenuAdmin(context);

  // dynamic MenuMenu(BuildContext context) => MenuBar(context);

/////////////////////////////////////////////////////////////////////////
  Future<void> _handleFormSubmission() async {
    _updateKorisnikData();

    // await _korisniciDetaljiProvider?.patch(korisnikid, korisnikDetalji);
    // currentUser = await _korisniciDetaljiProvider
    //     ?.getProfilKorisnika(korisnikDetalji!.korisnickoIme!);
    await _showDialog(context, 'Success', 'Učitavaju se podaci za biciklo...');
    // _updateTuristickiVodicData();
    await _bicikliDetaljiProvider?.patch(bic!.biciklId!, bic!);
  }

  void _updateKorisnikData() {
    setState(() {
      bic!.nazivBicikla = _nazivBiciklaController.text;
      bic!.boja = _bojaController.text;
      bic!.vrstaRama = _vrstaRamaController.text;
      double? parsedCijena = double.tryParse(_cijenaBiciklaController.text);
      if (parsedCijena != null) {
        // Print the parsed value for debugging
        bic!.cijenaBicikla = parsedCijena;
        print('Parsed Cijena: $parsedCijena');
      } else {
        //     // Handle invalid input if needed
        bic!.cijenaBicikla = 0.0;
      }
      if (novaSlika != null) {
        bic!.slika = novaSlika;
      }

      //   korisnikDetalji!.aktivan = true;
      if (_selectedValue != null) {
        bic!.drzavaID = _selectedValue!.drzavaID;
      } else {
        bic!.drzavaID = _selectedDrzava!.drzavaID;
      }
      if (_selectedValueM != null) {
        bic!.modelBiciklaID = _selectedValueM!.modelBiciklaId;
      } else {
        bic!.modelBiciklaID = _selectedModel!.modelBiciklaId;
      }
      if (_selectedValueT != null) {
        bic!.tipBiciklaID = _selectedValueT!.tipBiciklaId;
      } else {
        bic!.tipBiciklaID = _selectedTip!.tipBiciklaId;
      }

      if (_selectedValueT != null) {
        bic!.tipBiciklaID = _selectedValueT!.tipBiciklaId;
      } else {
        bic!.tipBiciklaID = _selectedTip!.tipBiciklaId;
      }

      if (_selectedValuePr != null) {
        bic!.proizvodjacBiciklaID = _selectedValuePr!.proizvodjacBiciklaId;
      } else {
        bic!.proizvodjacBiciklaID = _selectedProizvodjac!.proizvodjacBiciklaId;
      }
      if (_selectedValuePos != null) {
        bic!.poslovnicaID = _selectedValuePos!.poslovnicaId;
      } else {
        bic!.poslovnicaID = _selectedPoslovnica!.poslovnicaId;
      }

      print('Final Cijena: ${bic!.cijenaBicikla}');
      print('Final naziv:${bic!.nazivBicikla} ');
      print('Final ModelBiciklaId:${bic!.modelBiciklaID.toString()} ');
    });
  }

  Future<void> _handleSubmissionError(e) async {
    await _showDialog(context, 'Error', 'Došlo je do greške!');
    print('Greška koja se desi: $e');
  }

  void validateController() {
    if (!_formKey!.currentState!.validate()) {
      _showDialog(context, 'Error', 'Pogrešan unos pokušajte ponovo');
      // value is false.. textFields are rebuilt in order to show errorLabels
      return;
    } else {
      _showDialog(context, 'Success', 'Uspješno ste editovali biciklo');
    }
    // action WHEN values are valid
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

//Ovo je ako hoću DateTime.now da imam na TextEditingController-u
  onTapFunctionNow({required BuildContext context}) async {
    DateTime? pickedDate = DateTime.now();
    _date2Controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
  }

//Ovdje omogućavamo da se klikom na textformField unese datum
  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(2015),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    _date2Controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
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
