import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_details_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Moje Rezervacije"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 800,
              width: 500, // promijenio sam visinu sa 200 na 400
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
                  child: Container(
                      //Container je bio ili SizedBox
                      height: 100, //bio je height
                      width: 200,
                      //bic=await _bicikliProvider.getById(biciklID); //bio je width i kasnije 100

                      //child: Text(x.datumIzdavanja!.toIso8601String()),
                      child: imageFromBase64String(loadBicikliSlika(x))
                      //ovo je bilo prije x.slika!
                      ),
                ),

                //child: Text(x.datumIzdavanja!.toIso8601String()),
                Text("Rezervacija ID je" + (x.rezervacijaId).toString()),
                Text("Kupac ID je" + (x.kupacID).toString()),
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
    var result = data.firstWhere((bic) => bic.biciklId == x.biciklID);

    return result.slika!;
  }

  Bicikli loadBic(RezervacijePregled x) {
    //Bicikli bici;
    var result = data.firstWhere((bic) => bic.biciklId == x.biciklID);

    return result;
  }
}
