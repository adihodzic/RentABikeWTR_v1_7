import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/model/rezervacijePregled.dart';
import 'package:rentabikewtr_desktop/providers/bicikliPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/rezervacijeBicikl_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/widgets/menuAdmin.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class RezervacijaAdminListaRezervacijaScreen extends StatefulWidget {
  const RezervacijaAdminListaRezervacijaScreen({super.key});

  @override
  State<RezervacijaAdminListaRezervacijaScreen> createState() =>
      _RezervacijaAdminListaRezervacijaScreenState();
}

class _RezervacijaAdminListaRezervacijaScreenState
    extends State<RezervacijaAdminListaRezervacijaScreen> {
  BicikliPregledProvider? _bicikliPregledProvider = null;
  RezervacijeBiciklProvider? _rezervacijeBiciklProvider = null;
  //CartProvider? _cartProvider = null;
  BicikliPregled? bic;
  List<BicikliPregled> data = [];
  List<RezervacijePregled> dataRezervacije = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bicikliPregledProvider = context.read<BicikliPregledProvider>();
    _rezervacijeBiciklProvider = context.read<RezervacijeBiciklProvider>();

    // _cartProvider = context.read<CartProvider>();
    print("called initState");
    loadData();
    loaddataRezervacije();
  }

  Future loadData() async {
    var tmpData = await _bicikliPregledProvider?.get(null);
    setState(() {
      data = tmpData!;
    });
  }

  Future loaddataRezervacije() async {
    //var id = widget.argumentsKor.korisnikId as int;

    var tmpDataRez = await _rezervacijeBiciklProvider!.get();
    setState(() {
      if (tmpDataRez != null) {
        dataRezervacije = tmpDataRez;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          "RentABikeWTR -Lista rezervacija!!!",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(255, 11, 7, 255)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //_buildSearch(),
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
                  'RezervacijaID',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Datum izdavanja',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            // const DataColumn(
            //   label: Expanded(
            //     child: Text(
            //       'KupacID',
            //       style: TextStyle(fontStyle: FontStyle.italic),
            //     ),
            //   ),
            // ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Naziv bicikla',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
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
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Prezime',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: dataRezervacije
                  .map((RezervacijePregled e) => DataRow(
                          // onSelectChanged: (selected) => {
                          //       if (selected == true)
                          //         {
                          //           Navigator.of(context).push(
                          //             MaterialPageRoute(
                          //               builder: (context) =>
                          //                   ListaKorisniciScreen(
                          //                       //korisnik: e,
                          //                       ),
                          //             ),
                          //           )
                          //         }
                          //     },
                          cells: [
                            DataCell(Text(e.rezervacijaId?.toString() ?? "")),
                            DataCell(Text(DateFormat('dd.MM.yyyy')
                                .format(e.datumIzdavanja!))),
                            //DataCell(Text(e.biciklID?.toString() ?? "")),
                            //DataCell(Text(e.kupacID?.toString() ?? "")),
                            DataCell(Text(e.nazivBicikla?.toString() ?? "")),
                            DataCell(Text(e.korisnickoIme?.toString() ?? "")),
                            DataCell(Text(e.ime?.toString() ?? "")),
                            DataCell(Text(e.prezime?.toString() ?? "")),

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
}
  ///////////////////////////////////////////////////////////////////
  // String loadBicikliSlika(RezervacijePregled x) {
  //   //Bicikli bici;
  //   var result = data.firstWhere((bic) => bic.biciklId == x.biciklID);

  //   return result.slika!;
  // }

  // Bicikli loadBic(RezervacijePregled x) {
  //   //Bicikli bici;
  //   var result = data.firstWhere((bic) => bic.biciklId == x.biciklID);

  //   return result;
  // }

//   MenuBar Menu(BuildContext context) {
//     return MenuBar(
//       children: <Widget>[
//         SubmenuButton(
//           menuChildren: <Widget>[
//             MenuItemButton(
//               onPressed: () async {
//                 showAboutDialog(
//                   context: context,
//                   applicationName: 'Potrebno napraviti profil korisnika',
//                   applicationVersion: '1.7.',
//                 );
//               },
//               child: const MenuAcceleratorLabel('Profil korisnika'),
//             ),
//             MenuItemButton(
//               onPressed: () {
//                 showAboutDialog(
//                   context: context,
//                   applicationName: 'RentABikeWTR',
//                   applicationVersion: '1.7.',
//                 );
//               },
//               child: const MenuAcceleratorLabel('&O aplikaciji'),
//             ),
//             MenuItemButton(
//               onPressed: () async {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => MyMaterialApp(),
//                   ),
//                 );
//               },
//               child: const MenuAcceleratorLabel('&Odjava'),
//             ),
//           ],
//           child: const MenuAcceleratorLabel('&Glavni meni'),
//         ),
//         SubmenuButton(
//           menuChildren: <Widget>[],
//           child: const MenuAcceleratorLabel('&Admin portal'),
//         ),
//         SubmenuButton(
//           menuChildren: <Widget>[
//             MenuItemButton(
//               onPressed: () async {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => ListaKorisniciScreen(),
//                   ),
//                 );
//               },
//               child: const MenuAcceleratorLabel('Lista korisnika'),
//             ),
//             MenuItemButton(
//               onPressed: () async {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => DodajKorisnikaScreen(),
//                   ),
//                 );
//               },
//               child: const MenuAcceleratorLabel('Dodaj korisnika'),
//             ),
//           ],
//           child: const MenuAcceleratorLabel('&Korisnici'),
//         ),
//         SubmenuButton(
//           menuChildren: <Widget>[
//             MenuItemButton(
//               onPressed: () async {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => ListaVodiciScreen(),
//                   ),
//                 );
//               },
//               child: const MenuAcceleratorLabel('Lista vodica'),
//             ),
//             MenuItemButton(
//               onPressed: () async {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => DodajVodicaScreen(),
//                   ),
//                 );
//               },
//               child: const MenuAcceleratorLabel('Dodaj vodica'),
//             ),
//           ],
//           child: const MenuAcceleratorLabel('&Vodici'),
//         ),
//         SubmenuButton(
//           menuChildren: <Widget>[
//             MenuItemButton(
//               onPressed: () async {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => RezervacijaListaRezervacijaScreen(),
//                   ),
//                 );
//               },
//               child: const MenuAcceleratorLabel('Lista rezervacija'),
//             ),
//             MenuItemButton(
//               onPressed: () async {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => RezervacijaKorak1Screen(),
//                   ),
//                 );
//               },
//               child: const MenuAcceleratorLabel('Dodaj rezervaciju'),
//             ),
//           ],
//           child: const MenuAcceleratorLabel('&Rezervacije'),
//         ),
//         SubmenuButton(
//           menuChildren: <Widget>[
//             MenuItemButton(
//               onPressed: () async {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         PeriodicniIzvjestajRezervacijeScreen(),
//                   ),
//                 );
//               },
//               child: const MenuAcceleratorLabel('Periodicni izvjestaj'),
//             ),
//           ],
//           child: const MenuAcceleratorLabel('&Izvjestaji'),
//         ),
//       ],
//     );
//   }
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
