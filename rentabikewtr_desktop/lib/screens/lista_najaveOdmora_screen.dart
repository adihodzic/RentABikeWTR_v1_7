import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/model/najaveOdmoraPregled.dart';
import 'package:rentabikewtr_desktop/model/poslovnicePregled.dart';
import 'package:rentabikewtr_desktop/providers/najaveOdmoraPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/poslovnicePregled_provider.dart';
import 'package:rentabikewtr_desktop/screens/poslovnice_detalji_screen.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class ListaNajaveOdmoraScreen extends StatefulWidget {
  const ListaNajaveOdmoraScreen({super.key});

  @override
  State<ListaNajaveOdmoraScreen> createState() =>
      _ListaNajaveOdmoraScreenState();
}

class _ListaNajaveOdmoraScreenState extends State<ListaNajaveOdmoraScreen> {
  NajaveOdmoraPregledProvider? _najaveOdmoraPregledProvider = null;

  List<NajaveOdmoraPregled> data = [];
  NajaveOdmoraPregled? najava;

  DateTime dateTime = DateTime.now();
  DateTime dateTime2 = DateTime.now();
  TextEditingController _dateOdController = TextEditingController();
  TextEditingController _dateDoController = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _najaveOdmoraPregledProvider = context.read<NajaveOdmoraPregledProvider>();
    // _cartProvider = context.read<CartProvider>();
    print("called initState");
    //loadData();
  }

  // Future loadData() async {
  //   var tmpData = await _najaveOdmoraPregledProvider?.getNajavePregled(null);
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
                    flex: 4,
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
                              "RentABikeWTR -Pregled najava",
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
                                            child: Text("Izlistaj najave"),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                try {
                                                  await _handleFormSubmission();

                                                  await _showDialog(
                                                      context,
                                                      'Poruka:',
                                                      'Pregledajte najave');
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

//   Widget _buildSearch() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(labelText: "Naziv"),
//               controller: _searchController,
//             ),
//           ),
//           ElevatedButton(
//               onPressed: () async {
//                 print("login proceed");
//                 //Navigator.of(context).pop();

//                 var tmpdata = await _najaveOdmoraPregledProvider?.get();

//                 setState(() {
//                   data = tmpdata!;
//                 });

//                 print("data: ${data[0].nazivLokacije}");
//               },
//               child: Text("Pretraga")),
//           SizedBox(
//             width: 8,
//           ),
// //
//         ],
//       ),
//     );
//   }

  Widget _buildDataListView() {
    return Expanded(
        child: SingleChildScrollView(
      child: DataTable(
          columns: [
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Datum odmora',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Početak',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Završetak',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Napitak (kom)',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Launch paket  (kom)',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Lokacija',
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
          ],
          rows: data
                  .map((NajaveOdmoraPregled e) => DataRow(
                          // onSelectChanged: (selected) => {
                          //       if (selected == true)
                          //         {
                          //           Navigator.of(context).push(
                          //             MaterialPageRoute(
                          //               builder: (context) =>
                          //                   PoslovniceDetaljiScreen(
                          //                 argumentsP: e,
                          //               ),
                          //             ),
                          //           )
                          //         }
                          //     },
                          cells: [
                            DataCell(Text(DateFormat('dd-MM-yyyy')
                                .format(e.datumOdmora!))),
                            DataCell(Text(
                                DateFormat('hh:mm').format(e.pocetakOdmora!))),
                            DataCell(Text(DateFormat('hh:mm')
                                .format(e.zavrsetakOdmora!))),
                            DataCell(Text(e.napitakKolicina.toString() ?? "0")),
                            DataCell(
                                Text(e.launchPaketKolicina.toString() ?? "0")),
                            DataCell(Text(e.nazivLokacije ?? "")),
                            DataCell(Text(e.nazivVodica ?? "")),
                          ]))
                  .toList() ??
              []),
    ));
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

  Future<void> _handleFormSubmission() async {
    var tmpData;
    DateFormat format = DateFormat("yyyy-MM-dd");

    DateTime datum = format.parse(dateTime.toIso8601String());
    DateTime datum2 = format.parse(dateTime2.toIso8601String());
    if (datum2.isAfter(datum) || (datum2.isAtSameMomentAs(datum))) {
      tmpData =
          await _najaveOdmoraPregledProvider!.getNajavePregled(datum, datum2);
    } else
      throw Exception(());

    print('Fetched data: $data'); // Debugging line

    setState(() {
      data = tmpData;

      _buildDataListView();
    });

    // Handle the error here if needed
  }

  Future<void> _handleSubmissionError(e) async {
    _showDialog(
        context,
        "Greška",
        "Došlo je do greške!" +
            "\n" +
            "Provjerite da li je krajnji datum veći ili jednak početnom!!!"); // Debugging line
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
