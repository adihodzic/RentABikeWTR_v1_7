// //import 'dart:html';

// import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
// import 'package:rentabikewtr_mobile/model/screenArguments.dart';
// import 'package:rentabikewtr_mobile/model/turistickiVodici.dart';
// import 'package:rentabikewtr_mobile/model/turistRute.dart';
// import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';
// import 'package:rentabikewtr_mobile/providers/detalji_provider.dart';
// import 'package:rentabikewtr_mobile/providers/turistRute_provider.dart';
// //import 'package:eprodajamobile/screens/cart/cart_screen.dart';
// import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_details_screen.dart';
// import 'package:rentabikewtr_mobile/screens/turistRute/turistRute_details_screen.dart';
// import 'package:rentabikewtr_mobile/utils/util.dart';
// import 'package:rentabikewtr_mobile/widgets/header_widget.dart';
// import 'package:rentabikewtr_mobile/widgets/master_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// import '../../model/bicikli.dart';
// //import '../../providers/cart_provider.dart';
// import '../../model/turistRute.dart';
// import '../../providers/turistRute_provider.dart';
// import '../../providers/turistickiVodici_provider.dart';
// //import '../../widgets/bicikli_drawer.dart';

// class TuristickiVodiciListScreen extends StatefulWidget {
//   static const String routeName = "/TuristRute"; // rutu mijenjam
//   //...ako mijenjam string na Super(bicikliProvider-u)
//   final Bicikli argumentsBic;
//   final KorisniciProfil argumentsKor;

//   const TuristickiVodiciListScreen(
//       {Key? key, required this.argumentsBic, required this.argumentsKor})
//       : super(key: key);

//   @override
//   State<TuristickiVodiciListScreen> createState() =>
//       _TuristickiVodiciListScreenState();
// }

// class _TuristickiVodiciListScreenState
//     extends State<TuristickiVodiciListScreen> {
//   String title = "Turist rute";
//   TuristRuteProvider? _turistRuteProvider = null;
//   TuristickiVodiciProvider? _turistickiVodiciProvider = null;
//   BicikliProvider? _bicikliProvider = null;
//   TuristickiVodici? argumentsTV;
//   //TuristRute? argumenstTR;
//   //late ScreenArguments args;
//   //late ScreenArguments sa;
// //mogli smo argumentstV inicijalizirati i u Statefull Widgetu, a nw u State-u...
//   //...onda bi koristili u navigatoru(push.named) widget.argumentsTV kao i za argBic
//   //CartProvider? _cartProvider = null;
//   List<TuristRute> data = [];
//   List<TuristickiVodici> dataTV = [];
//   TuristickiVodici? _selectedValue;
//   String dropdownvalue = "Odaberite turističkog vodiča";

//   TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _turistRuteProvider = context.read<TuristRuteProvider>();
//     _bicikliProvider = context.read<BicikliProvider>();
//     _turistickiVodiciProvider = context.read<TuristickiVodiciProvider>();
//     // _cartProvider = context.read<CartProvider>();
//     print("called initState");
//     loadData();
//   }

//   Future loadData() async {
//     var tmpData = await _turistRuteProvider?.get(null);
//     setState(() {
//       data = tmpData!;
//     });
//   }

//   Future loadDataTV() async {
//     var tmpDataTV = await _turistickiVodiciProvider?.get(null);
//     setState(() {
//       dataTV = tmpDataTV!;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("called build $data");
//     return MasterScreenWidget(
//         argumentsKor: widget.argumentsKor,
//         child: SingleChildScrollView(
//           child: Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 DropdownButton<TuristickiVodici>(
//                     hint: Text("Odaberite turističkog vodiča"),
//                     value: _selectedValue,
//                     icon: const Icon(Icons.keyboard_arrow_down),

//                     // Array list of items
//                     items: dataTV.map<DropdownMenuItem<TuristickiVodici>>(
//                         (TuristickiVodici value) {
//                       return DropdownMenuItem<TuristickiVodici>(
//                         value: value,
//                         child: Text(value.naziv!),
//                       );
//                     }).toList(),
//                     // After selecting the desired option,it will
//                     // change button value to selected value
//                     onChanged: (TuristickiVodici? newValue) {
//                       setState(() {
//                         _selectedValue = newValue;
//                         argumentsTV = _selectedValue;
//                       });
//                     }),
//                 HeaderWidget(title: title),
//                 //_buildHeader(), // Ovo su widget-i
//                 // _buildProductSearch(), // ovo su widget-i
//                 const SizedBox(
//                   height: 30.0,
//                 ),
//                 Container(
//                   height: 400, // promijenio sam visinu sa 200 na 400
//                   child: GridView(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount:
//                             2, // bio je 1 ovo je broj osa (kolona ili redova)
//                         childAspectRatio: 4 / 3,
//                         crossAxisSpacing: 5, // bilo je 20
//                         mainAxisSpacing: 5), //bilo je 30
//                     scrollDirection: Axis.vertical, //bio je horizontal
//                     children: _buildProductCardList(),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Text(
//         "Turist rute",
//         style: TextStyle(
//             color: Colors.grey, fontSize: 40, fontWeight: FontWeight.w600),
//       ),
//     );
//   }

//   // Widget _buildProductSearch() {
//   //   return Row(
//   //     children: [
//   //       Expanded(
//   //         child: Container(
//   //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//   //           child: TextField(
//   //             controller: _searchController,
//   //             onSubmitted: (value) async {
//   //               var tmpDataTV = await _turistickiVodiciProvider?.get(null);
//   //               setState(() {
//   //                 dataTV = tmpDataTV!;
//   //               });
//   //             },
//   //             decoration: InputDecoration(
//   //                 hintText: "Search",
//   //                 prefixIcon: Icon(Icons.search),
//   //                 border: OutlineInputBorder(
//   //                     borderRadius: BorderRadius.circular(10),
//   //                     borderSide: BorderSide(color: Colors.grey))),
//   //           ),
//   //         ),
//   //       ),
//   //       Container(
//   //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//   //         child: IconButton(
//   //           icon: Icon(Icons.filter_list),
//   //           onPressed: () async {
//   //             var tmpDataTV = await _turistickiVodiciProvider?.get(null);
//   //             setState(() {
//   //               dataTV = tmpDataTV!;
//   //             });
//   //           },
//   //         ),
//   //       )
//   //     ],
//   //   );
//   // }

//   List<Widget> _buildProductCardList() {
//     if (data.length == 0) {
//       return [Text("Loading...")];
//     }

//     List<Widget> list = data
//         .map(
//           (x) => Container(
//             child: Column(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     //args!.argumentsTR = data[data.indexOf(x)];
//                     Navigator.pushNamed(
//                         context, "${TuristRuteDetailsScreen.routeName}",
//                         arguments: ScreenArguments(
//                             widget.argumentsKor,
//                             data[data.indexOf(x)],
//                             widget.argumentsBic,
//                             argumentsTV));
//                     //...vazno za prosljedjivanje objekta... mi daje tačan indeks
//                     //...ne bi bilo ispravno da sam stavio data[x.bicikliId!]
//                     //...nemam sve id-eve Bicikala u list
//                     //arguments: x.biciklId); ... ovo je trebalo ici po ID-u,
//                     //... ali sam izbacio
//                   },
//                   child: Container(
//                     //Container je bio ili SizedBox
//                     height: 100, //bio je height
//                     width: 200, //bio je width i kasnije 100

//                     child: imageFromBase64String(x.slikaRute!),
//                     //ovo je bilo prije x.slika!
//                   ),
//                 ),

//                 Text(x.naziv ?? "Proba i tako to"),
//                 //Text(formatNumber(x.cijena)),
//                 // IconButton(
//                 //   icon: Icon(Icons.shopping_cart),
//                 //   onPressed: ()  {
//                 //       _cartProvider?.addToCart(x);
//                 //   },
//                 // )
//               ],
//             ),
//           ),
//         )
//         .cast<Widget>()
//         .toList();

//     return list;
//   }
// }
