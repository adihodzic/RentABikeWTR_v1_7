import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/model/bicikliPregled.dart';
import 'package:rentabikewtr_desktop/model/rezervacijePregled.dart';
import 'package:rentabikewtr_desktop/providers/bicikliPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/rezervacijeBicikl_provider.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class RezervacijaListaRezervacijaScreen extends StatefulWidget {
  const RezervacijaListaRezervacijaScreen({super.key});

  @override
  State<RezervacijaListaRezervacijaScreen> createState() =>
      _RezervacijaListaRezervacijaScreenState();
}

class _RezervacijaListaRezervacijaScreenState
    extends State<RezervacijaListaRezervacijaScreen> {
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RezervacijaKorak1Screen(),
                                    ),
                                  );
                                  print("data: ${data[0].nazivBicikla}");
                                },
                                child: Text("Dodaj"))
                          ],
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
                  .map((RezervacijePregled e) => DataRow(cells: [
                        DataCell(Text(DateFormat('dd.MM.yyyy')
                            .format(e.datumIzdavanja!))),
                        //DataCell(Text(e.biciklID?.toString() ?? "")),
                        //DataCell(Text(e.kupacID?.toString() ?? "")),
                        DataCell(Text(e.nazivBicikla?.toString() ?? "")),
                        DataCell(Text(e.korisnickoIme?.toString() ?? "")),
                        DataCell(Text(e.ime?.toString() ?? "")),
                        DataCell(Text(e.prezime?.toString() ?? "")),
                      ]))
                  .toList() ??
              []),
    ));
  }
}
  ///////////////////////////////////////////////////////////////////
  



