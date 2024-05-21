import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';
import 'package:rentabikewtr_mobile/providers/detalji_provider.dart';
//import 'package:eprodajamobile/screens/cart/cart_screen.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_details_screen.dart';
import 'package:rentabikewtr_mobile/utils/util.dart';
import 'package:rentabikewtr_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/bicikli.dart';
//import '../../providers/cart_provider.dart';
import '../../widgets/bicikli_drawer.dart';

class BicikliListScreen extends StatefulWidget {
  static const String routeName = "/BicikliMobilna"; // rutu mijenjam
  //...ako mijenjam string na Super(bicikliProvider-u)

  const BicikliListScreen({Key? key}) : super(key: key);

  @override
  State<BicikliListScreen> createState() => _BicikliListScreenState();
}

class _BicikliListScreenState extends State<BicikliListScreen> {
  BicikliProvider? _bicikliProvider = null;
  //CartProvider? _cartProvider = null;
  List<Bicikli> data = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bicikliProvider = context.read<BicikliProvider>();
    // _cartProvider = context.read<CartProvider>();
    print("called initState");
    loadData();
  }

  Future loadData() async {
    var tmpData = await _bicikliProvider?.get(null);
    setState(() {
      data = tmpData!;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("called build $data");
    return MasterScreenWidget(
        child: SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(), // Ovo su widget-i
            _buildProductSearch(), // ovo su widget-i
            Container(
              height: 400, // promijenio sam visinu sa 200 na 400
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
            )
          ],
        ),
      ),
    ));
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "Bicikli",
        style: TextStyle(
            color: Colors.grey, fontSize: 40, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildProductSearch() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) async {
                var tmpData =
                    await _bicikliProvider?.get({'nazivBicikla': value});
                setState(() {
                  data = tmpData!;
                });
              },
              decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey))),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () async {
              var tmpData = await _bicikliProvider
                  ?.get({'nazivBicikla': _searchController.text});
              setState(() {
                data = tmpData!;
              });
            },
          ),
        )
      ],
    );
  }

  List<Widget> _buildProductCardList() {
    if (data.length == 0) {
      return [Text("Loading...")];
    }

    List<Widget> list = data
        .map(
          (x) => Container(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, "${BicikliDetailsScreen.routeName}",
                        arguments: data[data.indexOf(x)]);
                    //...vazno za prosljedjivanje objekta... mi daje tačan indeks
                    //...ne bi bilo ispravno da sam stavio data[x.bicikliId!]
                    //...nemam sve id-eve Bicikala u list
                    //arguments: x.biciklId); ... ovo je trebalo ici po ID-u,
                    //... ali sam izbacio
                  },
                  child: Container(
                    //Container je bio ili SizedBox
                    height: 100, //bio je height
                    width: 200, //bio je width i kasnije 100

                    child: imageFromBase64String(x.slika!),
                    //ovo je bilo prije x.slika!
                  ),
                ),

                Text(x.nazivBicikla ?? "Proba i tako to"),
                //Text(formatNumber(x.cijena)),
                // IconButton(
                //   icon: Icon(Icons.shopping_cart),
                //   onPressed: ()  {
                //       _cartProvider?.addToCart(x);
                //   },
                // )
              ],
            ),
          ),
        )
        .cast<Widget>()
        .toList();

    return list;
  }
}
