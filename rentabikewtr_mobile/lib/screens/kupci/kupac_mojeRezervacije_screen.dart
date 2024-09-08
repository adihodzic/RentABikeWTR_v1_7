import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_details_screen.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_pocetna_screen.dart';
import 'package:rentabikewtr_mobile/widgets/header_widget.dart';
import 'package:rentabikewtr_mobile/widgets/kupac_drawer.dart';
import 'package:rentabikewtr_mobile/widgets/master_screen.dart';

import '../../model/korisniciProfil.dart';
import '../../model/kupci.dart';
import '../../model/mojeRezervacijeArguments.dart';
import '../../model/rezervacije.dart';
import '../../model/rezervacijePregled.dart';
import '../../providers/bicikli_provider.dart';
import '../../providers/kupci_provider.dart';
import '../../providers/rezervacijeKupac_provider.dart';
import '../../utils/util.dart';
import 'kupac_mojProfil_screen.dart';
import 'kupac_mojeRezervacije_details_screen.dart';

class KupacMojeRezervacijeScreen extends StatefulWidget {
  static const String routeName = "/Kupac_rezervacije";
  final KorisniciProfil argumentsKor;

  KupacMojeRezervacijeScreen({Key? key, required this.argumentsKor})
      : super(key: key);

  @override
  State<KupacMojeRezervacijeScreen> createState() =>
      _KupacMojeRezervacijeScreenState();
}

class _KupacMojeRezervacijeScreenState
    extends State<KupacMojeRezervacijeScreen> {
  String title = "Moje rezervacije";
  int currentIndex = 0;
  BicikliProvider? _bicikliProvider = null;
  RezervacijeKupacProvider? _rezervacijeKupacProvider = null;
  RezervacijePregled? rezPregled;
  //MojeRezervacijeArguments? args;
  //CartProvider? _cartProvider = null;
  List<Bicikli> data = [];
  Bicikli? bic;
  List<RezervacijePregled> dataRezervacije = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bicikliProvider = context.read<BicikliProvider>();
    _rezervacijeKupacProvider = context.read<RezervacijeKupacProvider>();

    // _cartProvider = context.read<CartProvider>();
    print("called initState");
    loadData();
    loaddataRezervacije();
  }

  Future loadData() async {
    var tmpData = await _bicikliProvider?.get(null);
    setState(() {
      data = tmpData!;
    });
  }

  Future loaddataRezervacije() async {
    var id = widget.argumentsKor.korisnikId as int;

    var tmpDataRez = await _rezervacijeKupacProvider!.getRezervacijeKupac(id);
    setState(() {
      if (tmpDataRez != null) {
        dataRezervacije = tmpDataRez;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final _rezervacijeKupacProvider =
    //     Provider.of<RezervacijeKupacProvider>(context);
    return MasterScreenWidget(
      argumentsKor: widget.argumentsKor,
      // appBar: AppBar(
      //   title: Text('RentABikeWTR '),
      // ),
      // drawer: KupacDrawer(
      //   argumentsKor: widget.argumentsKor,
      // ),
      // //////////////////////////////////////////////////
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_bag),
      //       label: 'Moje rezervacije',
      //     ),
      //   ],
      //   selectedItemColor: Colors.amber[800],
      //   currentIndex: currentIndex,
      //   onTap: _onItemTapped,
      // ),
      /////////////////////////////////////////////////////
      child: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(title: title),
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                height: 100,
                width: 100,
                child: Image.asset(
                  'assets/images/logo7.png',
                  fit: BoxFit.contain,
                ),
              ),
            ]),
            SizedBox(height: 20.0),
            Container(
              height: 450,
              // width: 500, // promijenio sam visinu sa 200 na 400
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        2, // bio je 1 ovo je broj osa (kolona ili redova)
                    childAspectRatio: 4 / 3,
                    crossAxisSpacing: 5, // bilo je 20
                    mainAxisSpacing: 5), //bilo je 30
                scrollDirection: Axis.vertical, //bio je horizontal
                children: _buildProductCardList(),
              ),
            ),
            // Container(
            //   height: 50,
            //   child: ElevatedButton(
            //       child: Text("Proba"),
            //       onPressed: () async {
            //         var kup = await _bicikliProvider!.get();
            //       }),
            // )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildProductCardList() {
    if (data.length == 0) {
      return [Text("Loading...")];
    }
    List<Widget> list = dataRezervacije
        .map(
          (x) => Container(
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    await Navigator.pushNamed(context,
                        "${KupacMojeRezervacijeDetailsScreen.routeName}",
                        arguments: MojeRezervacijeArguments(
                            dataRezervacije[dataRezervacije.indexOf(x)],
                            this.widget.argumentsKor,
                            loadBic(x)));
                    //dataRezervacije[dataRezervacije.indexOf(x)]);
                    //loadBicikliSlika(x);

                    //...vazno za prosljedjivanje objekta... mi daje tačan indeks
                    //...ne bi bilo ispravno da sam stavio data[x.bicikliId!]
                    //...nemam sve id-eve Bicikala u list
                    //arguments: x.biciklId); ... ovo je trebalo ici po ID-u,
                    //... ali sam izbacio
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          //Container je bio ili SizedBox
                          height: 100, //bio je height
                          width: 150, //bio je width i kasnije 100

                          child: imageFromBase64String(loadBicikliSlika(x))),
                    ),
                    //ovo je bilo prije x.slika!
                  ),
                ),

                //child: Text(x.datumIzdavanja!.toIso8601String()),
                Text("Rezervacija broj: " + (x.rezervacijaId).toString()),
                //Text("Kupac ID je" + (x.kupacID).toString()),
                //Text((x.statusPlacanja).toString()),
                // IconButton(
                //   icon: Icon(Icons.shopping_cart),
                //   onPressed: ()  {
                //       _cartProvider?.addToCart(x);
                //   },
              ],
            ),
          ),
        )
        .cast<Widget>()
        .toList();

    return list;
  }

  String loadBicikliSlika(RezervacijePregled x) {
    //Bicikli bici;
    var result = data.firstWhere((bic) => bic.biciklID == x.biciklID);

    return result.slika!;
  }

  Bicikli loadBic(RezervacijePregled x) {
    //Bicikli bici;
    var result = data.firstWhere((bic) => bic.biciklID == x.biciklID);

    return result;
  }

  Widget _buildHeader() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "Moje rezervacije",
        style: TextStyle(
            color: Color.fromARGB(233, 120, 180, 229),
            fontSize: 30,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    if (currentIndex == 0) {
      Navigator.pushNamed(context, KupacPocetnaScreen.routeName,
          arguments: widget.argumentsKor);
    } else if (currentIndex == 1) {
      Navigator.pushNamed(context, KupacMojeRezervacijeScreen.routeName,
          arguments: widget.argumentsKor);
      // } else if (currentIndex == 2) {
      //   Navigator.pushNamed(context, KupacMojeRezervacijeDetailsScreen.routeName);
      // }
    }
  }
}
