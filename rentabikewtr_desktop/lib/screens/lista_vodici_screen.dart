import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodici.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/screens/vodici_detalji_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';

class ListaVodiciScreen extends StatefulWidget {
  const ListaVodiciScreen({super.key});

  @override
  State<ListaVodiciScreen> createState() => _ListaVodiciScreenState();
}

class _ListaVodiciScreenState extends State<ListaVodiciScreen> {
  TuristickiVodiciPregledProvider? _turistickiVodiciPregledProvider = null;
  //CartProvider? _cartProvider = null;
  List<TuristickiVodici> data = [];
  TuristickiVodici? turistickiVodic;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _turistickiVodiciPregledProvider =
        context.read<TuristickiVodiciPregledProvider>();
    // _cartProvider = context.read<CartProvider>();
    print("called initState");
    loadData();
  }

  Future loadData() async {
    var tmpData = await _turistickiVodiciPregledProvider?.get(null);
    setState(() {
      data = tmpData!;
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
                          "RentABikeWTR -Lista vodiča!!!",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Color.fromARGB(255, 11, 7, 255)),
                        ),
                        _buildSearch(),
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

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Naziv"),
              controller: _searchController,
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                print("login proceed");
                //Navigator.of(context).pop();

                var tmpdata = await _turistickiVodiciPregledProvider?.get();

                setState(() {
                  data = tmpdata!;
                });

                print("data: ${data[0].naziv}");
              },
              child: Text("Pretraga")),
          SizedBox(
            width: 8,
          ),
//           ElevatedButton(
//               onPressed: () async {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => DodajKorisnikaScreen(//ovo su bili detalji u originalu
//                       product: null,
//                     ),
//                   ),
//                 );
//                 print("data: ${data.result[0].naziv}");
//               },
//               child: Text("Dodaj"))
        ],
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
                  'Naziv',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Jezik',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Cijena',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: data
                  .map((TuristickiVodici e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            VodiciDetaljiScreen(
                                          argumentsK: e,
                                        ),
                                      ),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.naziv?.toString() ?? "")),
                            DataCell(Text(e.jezik ?? "")),
                            DataCell(Text(formatNumber(e.cijenaVodica) ?? "")),
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
        child: const Scaffold(body: SafeArea(child: AdminPortalScreen())),
      ),
    );
  }
}
