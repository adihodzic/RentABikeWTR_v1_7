import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/model/modeliBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/poziviDezurnomVoziluPregled.dart';
import 'package:rentabikewtr_desktop/model/proizvodjaciBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/tipoviBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/turistRutePregled.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodici.dart';
import 'package:rentabikewtr_desktop/providers/bicikliPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/modeliBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/poziviDezurnomVoziluPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/proizvodjaciBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/tipoviBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistRutePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/bicikli_detalji_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/poziviDezurnomVozilu_detalji_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/screens/turistRute_detalji_screen.dart';
import 'package:rentabikewtr_desktop/screens/vodici_detalji_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class ListaPoziviDezurnomVoziluScreen extends StatefulWidget {
  const ListaPoziviDezurnomVoziluScreen({super.key});

  @override
  State<ListaPoziviDezurnomVoziluScreen> createState() =>
      _ListaPoziviDezurnomVoziluScreenState();
}

class _ListaPoziviDezurnomVoziluScreenState
    extends State<ListaPoziviDezurnomVoziluScreen> {
  PoziviDezurnomVoziluPregledProvider? _poziviDezurnomVoziluPregledProvider =
      null;
  //TuristickiVodiciPregledProvider? _turistickiVodiciPregledProvider = null;
  //CartProvider? _cartProvider = null;

  TextEditingController _searchController = TextEditingController();
  TextEditingController _dateOdController = TextEditingController();
  TextEditingController _dateDoController = TextEditingController();

  List<PoziviDezurnomVoziluPregled> data = [];
  PoziviDezurnomVoziluPregled? poz;
  PoziviDezurnomVoziluPregled? dataResult;
  List<PoziviDezurnomVoziluPregled> _dataList = [];
  DateTime dateTime = DateTime.now();
  DateTime dateTime2 = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _poziviDezurnomVoziluPregledProvider =
        context.read<PoziviDezurnomVoziluPregledProvider>();

    // _cartProvider = context.read<CartProvider>();
    print("called initState");
    //loadData();
  }

  // Future loadData() async {
  //   var tmpData = await _poziviDezurnomVoziluPregledProvider?.get(null);
  //   setState(() {
  //     data = tmpData!;
  //   });
  // }

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
                  child: MenuRadnik(),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.white,
                      //constraints: BoxConstraints(maxWidth: 800, maxHeight: 400),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(children: [
                            // Image.network("https://www.fit.ba/content/public/images/og-image.jpg", height: 100, width: 100,),
                            Image.asset(
                              "assets/images/logo.jpg",
                              height: 200,
                              width: 500,
                            ),
                            SizedBox(
                              height: 50,
                            ),

                            Text(
                              "RentABikeWTR -Evidencija poziva",
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
                                          width: 180,
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: _dateOdController,
                                            onTap: _selectDateOd,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Datum početni",
                                                hintText: 'Odaberite datum'),
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
                                          height: 150,
                                          width: 180,
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: _dateDoController,
                                            onTap: _selectDateDo,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Datum krajnji",
                                                hintText: 'Odaberite datum'),
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
                                            child: Text("Izlistaj pozive"),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                try {
                                                  await _handleFormSubmission();

                                                  await _showDialog(
                                                      context,
                                                      'Success',
                                                      'Pregledajte pozive');
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
                            _buildDataListView()
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

//

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
                  'PozivID',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            // const DataColumn(
            //   label: Expanded(
            //     child: Text(
            //       'Vise detalja',
            //       style: TextStyle(fontStyle: FontStyle.italic),
            //     ),
            //   ),
            // ),
            // const DataColumn(
            //   label: Expanded(
            //     child: Text(
            //       'Nesreća',
            //       style: TextStyle(fontStyle: FontStyle.italic),
            //     ),
            //   ),
            // ),
            // const DataColumn(
            //   label: Expanded(
            //     child: Text(
            //       'Zahtjev klijenta',
            //       style: TextStyle(fontStyle: FontStyle.italic),
            //     ),
            //   ),
            // ),
            // // const DataColumn(
            // //   label: Expanded(
            // //     child: Text(
            // //       'Tip bicikla',
            // //       style: TextStyle(fontStyle: FontStyle.italic),
            // //     ),
            // //   ),
            // // ),
            // const DataColumn(
            //   label: Expanded(
            //     child: Text(
            //       'Kvar',
            //       style: TextStyle(fontStyle: FontStyle.italic),
            //     ),
            //   ),
            // ),
            // const DataColumn(
            //   label: Expanded(
            //     child: Text(
            //       'Loše vrijeme',
            //       style: TextStyle(fontStyle: FontStyle.italic),
            //     ),
            //   ),
            // ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Datum poziva',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Vrijeme poziva',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Vozilo',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Vodič',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Poslovnica',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: data
                  .map((PoziviDezurnomVoziluPregled e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PoziviDezurnomVoziluDetaljiScreen(
                                          argumentsP: e,
                                        ),
                                      ),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(
                                e.pozivDezurnomVoziluId?.toString() ?? "")),
                            // DataCell(Text(e.viseDetalja ?? "")),
                            // DataCell(Text(e.nesreca! ? "Da" : "Ne")),
                            // DataCell(Text(e.zahtjevKlijenta! ? "Da" : "Ne")),
                            // DataCell(Text(e.kvar! ? "Da" : "Ne")),
                            // DataCell(
                            //     Text(e.losiVremenskiUslovi! ? "Da" : "Ne")),
                            DataCell(Text(DateFormat('dd-MM-yyyy')
                                .format(e.datumPoziva!))),
                            DataCell(Text(
                                DateFormat('hh:mm').format(e.vrijemePoziva!))),
                            DataCell(Text(e.nazivDezurnogVozila ?? "")),
                            DataCell(Text(e.naziv ?? "")),
                            DataCell(Text(e.nazivPoslovnice ?? "")),
                          ]))
                  .toList() ??
              []),
    ));
  }

  Future<void> _handleSubmissionError(e) async {
    await _showDialog(context, 'Error', 'Došlo je do greške!');
  }

  Future<void> _handleFormSubmission() async {
    try {
      var tmpData;
      // var data = await _rezervacijeBiciklDostupniProvider!
      //     .getRezervacijeDostupni(DateTime.parse(_dateController.text));

      DateFormat format = DateFormat("yyyy-MM-dd");

      DateTime datum = format.parse(dateTime.toIso8601String());
      DateTime datum2 = format.parse(dateTime2.toIso8601String());
      if (datum2.isAfter(datum)) {
        tmpData = await _poziviDezurnomVoziluPregledProvider!
            .getPoziviPregled(datum, datum2);
      } else
        throw Exception();

//var bicikli= await _bicikliDostupniProvider.getByIds
      print('Fetched data: $data'); // Debugging line

      setState(() {
        data = tmpData;
        //_dataList = data; // as List<PoziviDezurnomVoziluPregled>;
        //var suma = dataResult!.ukupnaSuma;

        _buildDataListView();
      });

      //_buildDataListView();
    } catch (e) {
      // Handle the error here if needed
      print('Error fetching data: $e');
      _showDialog(context, "Error",
          "Došlo je do greške string is not subtype of num"); // Debugging line
    }
  }

  _selectDateOd() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2020),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      _dateOdController.text = DateFormat('dd-MM-yyyy').format(dateTime);
    }
  }

  _selectDateDo() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime2,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2020),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime2 = picked;
      //assign the chosen date to the controller
      _dateDoController.text = DateFormat('dd-MM-yyyy').format(dateTime2);
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
