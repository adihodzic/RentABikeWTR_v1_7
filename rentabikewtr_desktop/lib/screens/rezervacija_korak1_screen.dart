import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/rezervacijeBiciklDostupni.dart';
import 'package:rentabikewtr_desktop/model/rezervacijePregled.dart';
import 'package:rentabikewtr_desktop/model/screenArgumentsR.dart';
import 'package:rentabikewtr_desktop/providers/rezervacijeBiciklDostupni_provider.dart';
import 'package:rentabikewtr_desktop/providers/rezervacijeBicikl_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak2_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';
import 'package:rentabikewtr_desktop/widgets/menuAdmin.dart';

class RezervacijaKorak1Screen extends StatefulWidget {
  RezervacijaKorak1Screen({super.key});

  @override
  State<RezervacijaKorak1Screen> createState() =>
      _RezervacijaKorak1ScreenState();
}

class _RezervacijaKorak1ScreenState extends State<RezervacijaKorak1Screen> {
  TextEditingController _dateController = TextEditingController();
  RezervacijeBiciklDostupniProvider? _rezervacijeBiciklDostupniProvider;
  List<RezervacijeBiciklDostupni> data = [];
  List<RezervacijeBiciklDostupni> _dataList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  ScreenArgumentsR? argumentsR;
  RezervacijeBiciklDostupni? argumentsB;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _rezervacijeBiciklDostupniProvider =
        context.read<RezervacijeBiciklDostupniProvider>();
    // _cartProvider = context.read<CartProvider>();
    print("called initState");
    //loadData();
  }

  // Future loadData() async {
  //   var tmpData = await _rezervacijeBiciklDostupniProvider?.get(null);
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
                  child: MenuAdmin(),
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
                              "RentABikeWTR -Rezervacija-korak 1",
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
                                            controller: _dateController,
                                            onTap: _selectDate,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Datum rezervacije",
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
                                            child: Text(
                                                "Izlistaj dostupne bicikle"),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                try {
                                                  await _handleFormSubmission();

                                                  await _showDialog(
                                                      context,
                                                      'Success',
                                                      'Pregledajte dostupne bicikle');
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
                  'BiciklID',
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
                  'Cijena',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Tip bicikla',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Naziv proizvođača',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: _dataList
                  .map((RezervacijeBiciklDostupni e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RezervacijaKorak2Screen(
                                          argumentsB: e,
                                          datumPretrage: dateTime!,
                                        ),
                                      ),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.biciklID?.toString() ?? "")),
                            DataCell(Text(e.nazivBicikla?.toString() ?? "")),
                            // DataCell(Text(DateFormat('dd-MM-yyyy')
                            //     .format(e.datumIzdavanja as DateTime))),
                            DataCell(Text(formatNumber(e.cijenaBicikla))),
                            DataCell(Text(e.nazivTipa?.toString() ?? "")),
                            DataCell(
                                Text(e.nazivProizvodjaca?.toString() ?? "")),

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
      var datum = dateTime.toIso8601String();
      var data = await _rezervacijeBiciklDostupniProvider!
          .getRezervacijeDostupni(datum);
//var bicikli= await _bicikliDostupniProvider.getByIds
      print('Fetched data: $data'); // Debugging line

      setState(() {
        _dataList = data as List<RezervacijeBiciklDostupni>;
        _buildDataListView();
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

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      _dateController.text = DateFormat('dd-MM-yyyy').format(dateTime);
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

// MenuBar Menu(BuildContext context) {
//   return MenuBar(
//     children: <Widget>[
//       SubmenuButton(
//         menuChildren: <Widget>[
//           MenuItemButton(
//             onPressed: () async {
//               showAboutDialog(
//                 context: context,
//                 applicationName: 'Potrebno napraviti profil korisnika',
//                 applicationVersion: '1.7.',
//               );
//             },
//             child: const MenuAcceleratorLabel('Profil korisnika'),
//           ),
//           MenuItemButton(
//             onPressed: () {
//               showAboutDialog(
//                 context: context,
//                 applicationName: 'RentABikeWTR',
//                 applicationVersion: '1.7.',
//               );
//             },
//             child: const MenuAcceleratorLabel('&O aplikaciji'),
//           ),
//           MenuItemButton(
//             onPressed: () async {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => MyMaterialApp(),
//                 ),
//               );
//             },
//             child: const MenuAcceleratorLabel('&Odjava'),
//           ),
//         ],
//         child: const MenuAcceleratorLabel('&Glavni meni'),
//       ),
//       SubmenuButton(
//         menuChildren: <Widget>[],
//         child: const MenuAcceleratorLabel('&Admin portal'),
//       ),
//       SubmenuButton(
//         menuChildren: <Widget>[
//           MenuItemButton(
//             onPressed: () async {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => ListaKorisniciScreen(),
//                 ),
//               );
//             },
//             child: const MenuAcceleratorLabel('Lista korisnika'),
//           ),
//           MenuItemButton(
//             onPressed: () async {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => DodajKorisnikaScreen(),
//                 ),
//               );
//             },
//             child: const MenuAcceleratorLabel('Dodaj korisnika'),
//           ),
//         ],
//         child: const MenuAcceleratorLabel('&Korisnici'),
//       ),
//       SubmenuButton(
//         menuChildren: <Widget>[
//           MenuItemButton(
//             onPressed: () async {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => ListaVodiciScreen(),
//                 ),
//               );
//             },
//             child: const MenuAcceleratorLabel('Lista vodica'),
//           ),
//           MenuItemButton(
//             onPressed: () async {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => DodajVodicaScreen(),
//                 ),
//               );
//             },
//             child: const MenuAcceleratorLabel('Dodaj vodica'),
//           ),
//         ],
//         child: const MenuAcceleratorLabel('&Vodici'),
//       ),
//       SubmenuButton(
//         menuChildren: <Widget>[
//           MenuItemButton(
//             onPressed: () async {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => RezervacijaListaRezervacijaScreen(),
//                 ),
//               );
//             },
//             child: const MenuAcceleratorLabel('Lista rezervacija'),
//           ),
//           MenuItemButton(
//             onPressed: () async {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => RezervacijaKorak1Screen(),
//                 ),
//               );
//             },
//             child: const MenuAcceleratorLabel('Dodaj rezervaciju'),
//           ),
//         ],
//         child: const MenuAcceleratorLabel('&Rezervacije'),
//       ),
//       SubmenuButton(
//         menuChildren: <Widget>[
//           MenuItemButton(
//             onPressed: () async {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => PeriodicniIzvjestajRezervacijeScreen(),
//                 ),
//               );
//             },
//             child: const MenuAcceleratorLabel('Periodicni izvjestaj'),
//           ),
//         ],
//         child: const MenuAcceleratorLabel('&Izvjestaji'),
//       ),
//     ],
//   );
// }

// class MenuAcceleratorApp extends StatelessWidget {
//   const MenuAcceleratorApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(useMaterial3: true),
//       home: Shortcuts(
//         shortcuts: <ShortcutActivator, Intent>{
//           const SingleActivator(LogicalKeyboardKey.keyT, control: true):
//               VoidCallbackIntent(() {
//             debugDumpApp();
//           }),
//         },
//         child: const Scaffold(body: SafeArea(child: AdminPortalScreen())),
//       ),
//     );
//   }
// }
