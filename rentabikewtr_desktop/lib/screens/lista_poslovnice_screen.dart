import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/model/poslovnicePregled.dart';
import 'package:rentabikewtr_desktop/providers/poslovnicePregled_provider.dart';
import 'package:rentabikewtr_desktop/screens/poslovnice_detalji_screen.dart';
import 'package:rentabikewtr_desktop/widgets/menuRadnik.dart';

class ListaPoslovniceScreen extends StatefulWidget {
  const ListaPoslovniceScreen({super.key});

  @override
  State<ListaPoslovniceScreen> createState() => _ListaPoslovniceScreenState();
}

class _ListaPoslovniceScreenState extends State<ListaPoslovniceScreen> {
  PoslovnicePregledProvider? _poslovnicePregledProvider = null;

  List<PoslovnicePregled> data = [];
  PoslovnicePregled? poslovnica;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _poslovnicePregledProvider = context.read<PoslovnicePregledProvider>();
    // _cartProvider = context.read<CartProvider>();
    print("called initState");
    loadData();
  }

  Future loadData() async {
    var tmpData = await _poslovnicePregledProvider?.get(null);
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
                          "RentABikeWTR -Lista poslovnica",
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
                  'ID',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Naziv poslovnice',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'e-mail',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Adresa',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Broj telefona',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: data
                  .map((PoslovnicePregled e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PoslovniceDetaljiScreen(
                                          argumentsP: e,
                                        ),
                                      ),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.poslovnicaId?.toString() ?? "")),
                            DataCell(Text(e.nazivPoslovnice ?? "")),
                            DataCell(Text(e.emailKontakt ?? "")),
                            DataCell(Text(e.adresa ?? "")),
                            DataCell(Text(e.brojTelefona ?? "")),
                            // DataCell(Text(e.cijenaRute.toString())),
                            // // DataCell(Text(e.nazivTipa ?? "")),
                            //DataCell(Text())
                          ]))
                  .toList() ??
              []),
    ));
  }
}
