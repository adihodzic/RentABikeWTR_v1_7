import 'dart:collection';
import 'dart:convert';
//import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rentabikewtr_mobile/model/bicikli.dart';
import 'package:rentabikewtr_mobile/model/detalji.dart';
import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';
import 'package:rentabikewtr_mobile/providers/detalji_provider.dart';
import 'package:rentabikewtr_mobile/providers/rezervacije_provider.dart';
import 'package:rentabikewtr_mobile/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
//import 'package:provider/provider.dart';

//import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';

import '../../utils/util.dart';
import '../../widgets/master_screen.dart';
import '../rezervacije/rezervacija_korak1_screen.dart';

class BicikliDetailsScreen extends StatelessWidget {
  Bicikli arguments; //-- ako koristimo prosljeđivanje objekta

  //int arguments;
  //BicikliProvider? _bicikliProvider;
  //Bicikli bic = Bicikli();

  BicikliDetailsScreen({Key? key, required this.arguments}) : super(key: key);
  static const String routeName = "/bicikli_details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.nazivBicikla!),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                // First child in the Row for the name and the
                // Release date information.
                Expanded(
                  // Name and Release date are in the same column
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Code to create the view for name.
                      Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Original Name: " + arguments.nazivBicikla!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Code to create the view for release date.
                      Container(
                        height: 200,
                        width: 100,
                        child: imageFromBase64String(arguments.slika!),
                      ),
                      Center(
                          child: ElevatedButton(
                        child: Text("Rezervacija bicikla"),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, "${RezervacijaKorak1Screen.routeName}",
                              arguments: arguments);
                        },
                      )),
                    ],
                  ),
                ),
                // Icon to indicate the rating.
                new Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
                //new Text('${bic.voteAverage}'),
              ],
            ),
          ),
          // new Container(
          //     padding: const EdgeInsets.all(32.0),
          //     child: new Text(movie.overview,
          //       softWrap: true,
          //     )
          //)
        ],
      ),
    );
  }
}



//////////////////////////////////////////////////////////////////////

//   Future<Bicikli> bicikl() async {
//     var tmp = await _bicikliProvider?.getById(int.parse(this.widget.idem));
//     setState(() {
//       bic = tmp!
//           .firstWhere((bic) => bic.biciklId == (int.parse(this.widget.idem)));
//     });
//     return bic;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MasterScreenWidget(
//       child: Column(children: [
//         //_buildProductSearch(), //ovo su widgeti
//         Text(bic.nazivBicikla ?? "Proba jos jedna"), // ovo su widgeti
//         Container(
//           //Container je bio ili SizedBox
//           height: 100, //bio je height
//           width: 200, //bio je width i kasnije 100

//           //child: imageFromBase64String(bic.slika!),
//           //ovo je bilo prije x.slika!
//         ),
//         Text(this.bic.nazivBicikla ?? "Proba i tako to"),
//       ]),
//     );
//   }
// }
// // }
// //     Container(
// //             child: Column(
// //               children: [
// //                 var tmpData=_bicikliProvider?.getById(this.widget.idem);
// //                 InkWell(
// //                   // onTap: () {
// //                   //   Navigator.pushNamed(context,
// //                   //       "${BicikliDetailsScreen.routeName}/${idem.biciklId}");
// //                   // },
// //                   child: Container(
// //                     //Container je bio ili SizedBox
// //                     height: 100, //bio je height
// //                     width: 200, //bio je width i kasnije 100

// //                     child: imageFromBase64String(item.slika!),
// //                     //ovo je bilo prije x.slika!
// //                   ),
// //                 ),

// //                 Text(idem.nazivBicikla ?? "Proba i tako to"),
// //                 //Text(formatNumber(x.cijena)),
// //                 // IconButton(
// //                 //   icon: Icon(Icons.shopping_cart),
// //                 //   onPressed: ()  {
// //                 //       _cartProvider?.addToCart(x);
// //                 //   },


// //   class _buildBicikliSearch {
// //   }
// // OVAJ BLOK JE RADJEN SAMO ZBOG TESTA DA LI PROLAZI ID SA PRETHONDE STRANICE
// //////////////////////////////////////////////////////////////////////////
// // class ProductDetailsArgument {
// //   final Bicikli bic;
// //   ProductDetailsArgument(@required this.bic);
// // }

// // class _BicikliDetailsScreenState extends State<BicikliDetailsScreen> {
// //   DetaljiProvider? _detaljiProvider = null;
// //   late Future<List<Bicikli>> biciklis;

// //   @override
// //   void initState() {
// //     super.initState();
// //     biciklis = fetchBiciklis(int.parse(widget.idem));

// //     print("called initState");
// //   }

// //   Future<List<Bicikli>> fetchBiciklis(int ids) async {
// //     //var tmpData = await _bicikliProvider?.getById(widget.idem);
// //     Bicikli bic = Bicikli();
// //     bic.biciklId = ids;
// //     var data = null;
// //     var tmpData = await _detaljiProvider?.findInCart(bic);
// //     if (tmpData != null) {
// //       var data = tmpData;
// //     } //ovdje idem sa widget idem jer idem nije
// //     //definisan za state.

// //     var biciklisJson = jsonDecode(data.body)['bicikli'] as List;
// //     return biciklisJson.map((x) => Bicikli.fromJson(x)).toList();
// //   }

// //   // setState(() {
// //   //   data = tmpData!;
// //   // });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Provider.value(value: fetchBiciklis(int.parse(widget.idem)));
// //   }
// // }
