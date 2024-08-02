import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/model/proizvodjaciBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/tipoviBiciklaPregled.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodici.dart';
import 'package:rentabikewtr_desktop/providers/bicikliPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/proizvodjaciBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/tipoviBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/bicikli_detalji_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/screens/vodici_detalji_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class ListaProizvodjaciBiciklaScreen extends StatefulWidget {
  const ListaProizvodjaciBiciklaScreen({super.key});

  @override
  State<ListaProizvodjaciBiciklaScreen> createState() =>
      _ListaProizvodjaciBiciklaScreenState();
}

class _ListaProizvodjaciBiciklaScreenState
    extends State<ListaProizvodjaciBiciklaScreen> {
  ProizvodjaciBiciklaPregledProvider? _proizvodjaciBiciklaPregledProvider =
      null;
  TuristickiVodiciPregledProvider? _turistickiVodiciPregledProvider = null;
  //CartProvider? _cartProvider = null;
  List<ProizvodjaciBiciklaPregled> data = [];
  TuristickiVodici? bic;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _proizvodjaciBiciklaPregledProvider =
        context.read<ProizvodjaciBiciklaPregledProvider>();
    // _cartProvider = context.read<CartProvider>();
    print("called initState");
    loadData();
  }

  Future loadData() async {
    var tmpData = await _proizvodjaciBiciklaPregledProvider?.get(null);
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
                          "RentABikeWTR -Lista proizvođača bicikla",
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

                var tmpdata = await _proizvodjaciBiciklaPregledProvider?.get();

                setState(() {
                  data = tmpdata!;
                });

                print("data: ${data[0].nazivProizvodjaca}");
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
                  'ProizvodjacBiciklaID',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Naziv proizvođača bicikla',
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
            // const DataColumn(
            //   label: Expanded(
            //     child: Text(
            //       'Model',
            //       style: TextStyle(fontStyle: FontStyle.italic),
            //     ),
            //   ),
            // ),
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
            //       'Slika',
            //       style: TextStyle(fontStyle: FontStyle.italic),
            //     ),
            //   ),
            // ),
          ],
          rows: data
                  .map((ProizvodjaciBiciklaPregled e) => DataRow(
                          // onSelectChanged: (selected) => {
                          //       if (selected == true)
                          //         {
                          //           Navigator.of(context).push(
                          //             MaterialPageRoute(
                          //               builder: (context) =>
                          //                   BicikliDetaljiScreen(
                          //                 argumentsB: e,
                          //               ),
                          //             ),
                          //           )
                          //         }
                          //     },
                          cells: [
                            DataCell(
                                Text(e.proizvodjacBiciklaId?.toString() ?? "")),
                            DataCell(Text(e.nazivProizvodjaca ?? "")),
                            // DataCell(Text(e.nazivModela ?? "")),
                            // DataCell(Text(e.nazivTipa ?? "")),
                            //DataCell(Text())
                            //DataCell(Text(formatNumber(e.cijena))),
                            // DataCell(e.slika != ""
                            //     ? Container(
                            //         width: 100,
                            //         height: 100,
                            //         child: imageFromBase64String(e.slika ?? ""),
                            //       )
                            //     : Text(""))
                          ]))
                  .toList() ??
              []),
    ));
  }
}
