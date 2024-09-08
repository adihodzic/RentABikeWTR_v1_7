// import 'dart:html';

import 'package:rentabikewtr_mobile/model/bicikliRecommend.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/model/rezervacije.dart';
import 'package:rentabikewtr_mobile/model/screenArguments.dart';
import 'package:rentabikewtr_mobile/model/turistRute.dart';
import 'package:rentabikewtr_mobile/model/turistickiVodici.dart';
import 'package:rentabikewtr_mobile/providers/bicikliRecommend_provider.dart';
import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';
import 'package:rentabikewtr_mobile/providers/rezervacije_provider.dart';
import 'package:rentabikewtr_mobile/screens/rezervacije/rezervacija_korak3tr_screen.dart';
import 'package:rentabikewtr_mobile/screens/rezervacije/rezervacija_korak3bic_screen.dart';
//import 'package:rentabikewtr_mobile/widgets/eprodaja_drawer.dart';
import 'package:rentabikewtr_mobile/widgets/master_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_mobile/widgets/header_widget.dart';

import '../../model/bicikli.dart';
import '../../providers/rezervacije_provider.dart';
import '../../utils/util.dart';
import '../turistRute/turistRute_list_screen.dart';

class RezervacijaKorak1Screen extends StatefulWidget {
  //final int biciklId;
  String title = "Rezervacija bicikla";
  KorisniciProfil argumentsKor;
  DateTime argumentsDate;
  Bicikli argumentsBic; //ako bi htio vise argumenata poslati onda koristim
  //...klasu npr. ScreenArguments.... Onda nju kasnije pozovem ...pogledati primjer
  RezervacijaKorak1Screen({
    Key? key,
    required this.argumentsBic,
    required this.argumentsKor,
    required this.argumentsDate,
  }) : super(key: key);
  static const String routeName = "/rezervacije_bicikli";

  @override
  State<RezervacijaKorak1Screen> createState() =>
      _RezervacijaKorak1ScreenState();
}

class _RezervacijaKorak1ScreenState extends State<RezervacijaKorak1Screen> {
  TuristickiVodici? argumentsTV;
  TuristRute? argumentsTR;

  BicikliRecommendProvider? _bicikliRecommendProvider = null;
  List<BicikliRecommend> data = [];
  List<BicikliRecommend> _dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bicikliRecommendProvider = context.read<BicikliRecommendProvider>();

    print("called initState");
    loadData();
  }

  Future loadData() async {
    var tmpData = await _bicikliRecommendProvider
        ?.recommend(widget.argumentsBic.biciklID!);
    setState(() {
      data = tmpData!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      argumentsKor: widget.argumentsKor!,
      //appBar: AppBar(title: Text('Rezervacija bicikla')),
      child: ListView(
        //ovo sam stavio umjesto kolone da imam ljepsi izgled
        //...tacnije da se ne zalijepe dugmad za dno ekrana...
        children: [
          HeaderWidget(title: widget.title!),
          _buildBuyButton(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //////////////////////////////////////////////////////
                ///
                Card(
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

                        child:
                            imageFromBase64String(widget.argumentsBic.slika!)),
                  ),
                  //ovo je bilo prije x.slika!
                ),

                ///
                ///
                // Container(
                //   height: 100,
                //   width: 100,
                //   child: imageFromBase64String(widget.argumentsBic.slika!),
                // ),
                //SizedBox(height: 20.0),
                Text(
                  widget.argumentsBic.nazivBicikla!,
                  textAlign: TextAlign.end,
                ),
                SizedBox(height: 20),
                Text(
                  "Korisnici aplikacije, koji biraju ove bicikle, birali su i ove...",
                  style: TextStyle(
                    color: Color.fromARGB(233, 120, 180, 229),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                // Row(
                //   children: [
                //     Expanded(
                //       child: Column(
                //         children: [
                //           _buildProductCardList().elementAt(0),
                //           Card(
                //             elevation: 10,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10.0),
                //             ),
                //             //color: Color.fromRGBO(143, 148, 251, .6),
                //             color: Color.fromARGB(233, 120, 180, 229),
                //             child: Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Container(
                //                   height: 50, //bio je height
                //                   width: 75, //bio je width i kasnije 100

                //                   child: imageFromBase64String(
                //                       widget.argumentsBic.slika!)),
                //             ),
                //           ),
                //           Text(
                //             widget.argumentsBic.nazivBicikla!,
                //             textAlign: TextAlign.end,
                //           ),
                //           SizedBox(height: 20),
                //         ],
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                Column(
                  children: [
                    Container(
                      height: 100, // promijenio sam visinu sa 200 na 400
                      child: GridView(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                2, // bio je 1 ovo je broj osa (kolona ili redova)
                            childAspectRatio: 4 / 3,
                            crossAxisSpacing: 5, // bilo je 20
                            mainAxisSpacing: 5), //bilo je 30
                        //scrollDirection: Axis.vertical,
                        //bio je horizontal
                        children: _buildProductCardList(),
                      ),
                    ),
                    //     Card(
                    //       elevation: 10,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10.0),
                    //       ),
                    //       //color: Color.fromRGBO(143, 148, 251, .6),
                    //       color: Color.fromARGB(233, 120, 180, 229),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Container(
                    //             height: 50, //bio je height
                    //             width: 75, //bio je width i kasnije 100

                    //             child: imageFromBase64String(
                    //                 widget.argumentsBic.slika!)),
                    //       ),
                    //     ),
                    //     Text(
                    //       widget.argumentsBic.nazivBicikla!,
                    //       textAlign: TextAlign.end,
                    //     ),
                    //     SizedBox(height: 20),
                    //   ],
                    // ),
                  ],
                ),
                SizedBox(height: 100.0),
                //Kada se salje vise parametara onda radim push umjest pushNamed.
                //Mora Row ici jer Expanded pravi problem (javlja da nema ogranicenja)
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        //color: Color.fromRGBO(143, 148, 251, .6),
                        color: Color.fromARGB(233, 120, 180, 229),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                              child: Center(
                                child: Text('Izvrši rezervaciju bicikla',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                              onTap: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RezervacijaKorak3bicScreen(
                                      argumentsBiciklo: widget.argumentsBic,
                                      argumentsKorisnik: widget.argumentsKor,
                                      argumentsDate: widget.argumentsDate,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                /////////////////////////////////////////
                ///Ne mora Row ici da bi bilo rasireno dugme
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        //color: Color.fromRGBO(143, 148, 251, .6),
                        color: Color.fromARGB(233, 120, 180, 229),
                        // child: Container(
                        //   height: 30,
                        //   margin: EdgeInsets.fromLTRB(5, 10, 0, 10),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(2),
                        //     gradient: LinearGradient(colors: [
                        //       Color.fromRGBO(143, 148, 251, 1),
                        //       Color.fromRGBO(143, 148, 251, .6)
                        //     ]),
                        //   ),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(20.0), //prosiren inkWell
                          child: InkWell(
                            child: Center(
                                child: Text("Rezervacija bicikla i turist rute",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                            onTap: () async {
                              try {
                                // await _handleFormSubmission();
                                // await _showDialog(
                                //     context,
                                //     'Success',
                                //     'Uspješno ste editovali detalje bicikla');
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TuristRuteListScreen(
                                              argumentsBic: widget.argumentsBic,
                                              argumentsKor: widget.argumentsKor,
                                              argumentsDate:
                                                  widget.argumentsDate,
                                              //     arguments: ScreenArguments(
                                              //   widget.argumentsKor,
                                              //   argumentsTR,
                                              //   widget.argumentsBic,
                                              //   argumentsTV,
                                              //   widget.argumentsDate,
                                              // )
                                            )));
                              } catch (e) {
                                throw Exception("Došlo je do greške");
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildBuyButton() {
    return Column();
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
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color.fromARGB(233, 120, 180, 229),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        //Container je bio ili SizedBox
                        height: 50, //bio je height
                        width: 75, //bio je width i kasnije 100

                        child: imageFromBase64String(x.slika!)),
                  ),
                  //ovo je bilo prije x.slika!
                ),

                Text(x.nazivBicikla ?? "Nema naziva"),
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
