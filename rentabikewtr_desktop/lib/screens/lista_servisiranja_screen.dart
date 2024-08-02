import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/bicikli.dart';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/model/dezurnaVozilaPregled.dart';
import 'package:rentabikewtr_desktop/model/modeliBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/proizvodjaciBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/rezervniDijeloviPregled.dart';
import 'package:rentabikewtr_desktop/model/servisiranjaPregled.dart';
import 'package:rentabikewtr_desktop/model/tipoviBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/turistRutePregled.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodici.dart';
import 'package:rentabikewtr_desktop/providers/bicikliPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/dezurnaVozilaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/modeliBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/proizvodjaciBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/rezervniDijeloviPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/servisiranjaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/tipoviBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistRutePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/bicikli_detalji_screen.dart';
import 'package:rentabikewtr_desktop/screens/dezurnaVozila_detalji_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/screens/servisiranja_detalji_screen.dart';
import 'package:rentabikewtr_desktop/screens/turistRute_detalji_screen.dart';
import 'package:rentabikewtr_desktop/screens/vodici_detalji_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class ListaServisiranjaScreen extends StatefulWidget {
  const ListaServisiranjaScreen({super.key});

  @override
  State<ListaServisiranjaScreen> createState() =>
      _ListaServisiranjaScreenState();
}

class _ListaServisiranjaScreenState extends State<ListaServisiranjaScreen> {
  ServisiranjaPregledProvider? _servisiranjaPregledProvider = null;
  BicikliPregledProvider? _bicikliPregledProvider = null;
  RezervniDijeloviPregledProvider? _rezervniDijeloviPregledProvider = null;
  //TuristickiVodiciPregledProvider? _turistickiVodiciPregledProvider = null;
  //CartProvider? _cartProvider = null;
  List<ServisiranjaPregled> data = [];
  List<ServisiranjaPregled> _dataList = [];
  RezervniDijeloviPregled? dio;
  List<BicikliPregled> bicikli = [];
  BicikliPregled? _selectedBic;
  //TextEditingController _biciklIDController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  GlobalKey<FormState>? _formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey();
    _servisiranjaPregledProvider = context.read<ServisiranjaPregledProvider>();
    _bicikliPregledProvider = context.read<BicikliPregledProvider>();
    _rezervniDijeloviPregledProvider =
        context.read<RezervniDijeloviPregledProvider>();
    // _cartProvider = context.read<CartProvider>();
    print("called initState");
    loadData();
  }

  Future loadData() async {
    var tmpData = await _servisiranjaPregledProvider!
        .getServisiranjaPregled(null); //provjeriti
    var tmpBicikli = await _bicikliPregledProvider?.get();
    setState(() {
      data = tmpData as List<ServisiranjaPregled>;
      bicikli = tmpBicikli!;
    });
  }

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
                  flex: 2,
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
                            "RentABikeWTR -Lista servisiranja za biciklo",
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
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 30, 16, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 180,
                                        child: DropdownButtonFormField<
                                            BicikliPregled>(
                                          decoration: InputDecoration(
                                            labelText: 'Odaberite biciklo',
                                            border: OutlineInputBorder(),
                                          ),
                                          value: _selectedBic,
                                          onChanged:
                                              (BicikliPregled? newValue) {
                                            setState(() {
                                              _selectedBic = newValue;
                                            });
                                          },
                                          items:
                                              bicikli.map((BicikliPregled b) {
                                            return DropdownMenuItem<
                                                BicikliPregled>(
                                              value: b,
                                              child: Text(b.nazivBicikla!),
                                            );
                                          }).toList(),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Odaberite biciklo';
                                            }
                                            return null;
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
                                          child: Text("Izlistaj servisiranja"),
                                          onPressed: () async {
                                            if (_formKey!.currentState!
                                                .validate()) {
                                              try {
                                                await _handleFormSubmission();

                                                await _showDialog(
                                                    context,
                                                    'Success',
                                                    'Pregledajte listu servisiranja');
                                                //   await Navigator.of(
                                                //           context)
                                                //       .push(MaterialPageRoute(
                                                //           builder:
                                                //               (context) =>
                                                //                   AdminPortalScreen()));
                                              } catch (e) {
                                                await _handleSubmissionError(e);
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

//                 var tmpdata = await _servisiranjaPregledProvider?.get();

//                 setState(() {
//                   data = tmpdata!;
//                 });

//                 print("data: ${data[0].servisiranjeId}");
//               },
//               child: Text("Pretraga")),
//           SizedBox(
//             width: 8,
//           ),
// //           ElevatedButton(
// //               onPressed: () async {
// //                 Navigator.of(context).push(
// //                   MaterialPageRoute(
// //                     builder: (context) => DodajKorisnikaScreen(//ovo su bili detalji u originalu
// //                       product: null,
// //                     ),
// //                   ),
// //                 );
// //                 print("data: ${data.result[0].naziv}");
// //               },
// //               child: Text("Dodaj"))
//         ],
//       ),
//     );
//   }

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
                  'ID',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Opis kvara',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Datum servisiranja',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Komentar servisera',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Naziv bicikla',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: data
                  .map((ServisiranjaPregled e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ServisiranjaDetaljiScreen(
                                          argumentsS: e,
                                        ),
                                      ),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.servisiranjeId?.toString() ?? "")),
                            DataCell(Text(e.opisKvara ?? "")),
                            DataCell(Text(DateFormat('dd-MM-yyyy')
                                .format(e.datumServisiranja!))),
                            DataCell(Text(e.komentarServisera ?? "")),
                            DataCell(Text(e.nazivBicikla ?? "")),
                            // // DataCell(Text(e.nazivTipa ?? "")),
                            //DataCell(Text())
                          ]))
                  .toList() ??
              []),
    ));
  }

  Future<void> _handleFormSubmission() async {
    try {
      // var data = await _rezervacijeBiciklDostupniProvider!
      //     .getRezervacijeDostupni(DateTime.parse(_dateController.text));
      //var bicid = _selectedBic!.biciklId!;
      var temporarydata = await _servisiranjaPregledProvider!
          .getServisiranjaPregled(_selectedBic!.biciklId!);

      setState(() {
//var bicikli= await _bicikliDostupniProvider.getByIds
        print('Fetched data: $data'); // Debugging line
        data = temporarydata as List<ServisiranjaPregled>;
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

  Future<void> _handleSubmissionError(e) async {
    await _showDialog(context, 'Error', 'Došlo je do greške!');
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
