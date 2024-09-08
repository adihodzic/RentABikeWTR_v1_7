import 'package:rentabikewtr_mobile/model/korisnici.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';
import 'package:rentabikewtr_mobile/providers/detalji_provider.dart';
import 'package:rentabikewtr_mobile/providers/rezervacijeBiciklDostupni_provider.dart';
//import 'package:eprodajamobile/screens/cart/cart_screen.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_details_screen.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_mojeRezervacije_screen.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_pocetna_screen.dart';
import 'package:rentabikewtr_mobile/utils/util.dart';
import 'package:rentabikewtr_mobile/widgets/header_widget.dart';
import 'package:rentabikewtr_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/bicikli.dart';
//import '../../providers/cart_provider.dart';
import '../../widgets/kupac_drawer.dart';

class BicikliListScreen extends StatefulWidget {
  static const String routeName = "/bicikli_list"; // rutu mijenjam
  //...ako mijenjam string na Super(bicikliProvider-u)
  final KorisniciProfil argumentsKor;

  const BicikliListScreen({Key? key, required this.argumentsKor})
      : super(key: key);

  @override
  State<BicikliListScreen> createState() => _BicikliListScreenState();
}

class _BicikliListScreenState extends State<BicikliListScreen> {
  String title = "Bicikli lista";
  BicikliProvider? _bicikliProvider = null;
  RezervacijeBiciklDostupniProvider? _rezervacijeBiciklDostupniProvider;
  KorisniciProfil? korisnik;
  //CartProvider? _cartProvider = null;
  List<Bicikli> data = [];
  List<Bicikli> _dataList = [];
  int currentIndex = 0;
  DateTime dateTime = DateTime.now();

  TextEditingController _searchController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  // List<RezervacijeBiciklDostupni> data = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    korisnik = widget.argumentsKor;
    // TODO: implement initState
    super.initState();
    _bicikliProvider = context.read<BicikliProvider>();
    _rezervacijeBiciklDostupniProvider =
        context.read<RezervacijeBiciklDostupniProvider>();
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
      argumentsKor: widget.argumentsKor,
      // appBar: AppBar(title: Text("RentABikeWTR")),
      // drawer: KupacDrawer(
      //   argumentsKor: korisnik!,
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
      // /////////////////////////////////////////////////////

      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(title: title), // Ovo su widget-i
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
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "Bicikli lista",
        style: TextStyle(
            color: Color.fromARGB(233, 120, 180, 229),
            fontSize: 30,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildProductSearch() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              readOnly: true,
              controller: _dateController,
              onTap: _selectDate,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Datum rezervacije",
                  hintText: ''),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Odaberite datum rezervacije.';
                } else {
                  return null;
                }
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
        ),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //   child: IconButton(
        //     icon: Icon(Icons.filter_list),
        //     onPressed: () async {
        //       await _handleFormSubmission();
        //       // setState(() {
        //       //   data = tmpData!;
        //       // });
        //     },
        //   ),
        // )
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
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BicikliDetailsScreen(
                            argumentsB: data[data.indexOf(x)],
                            argumentsK: korisnik!,
                            argumentsDate: dateTime,
                          ),
                        ),
                      );
                    }
                    // Navigator.pushNamed(
                    //   context,
                    //   "${BicikliDetailsScreen.routeName}",
                    //   arguments: data[data.indexOf(x)],
                    // );
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

                          child: imageFromBase64String(x.slika!)),
                    ),
                    //ovo je bilo prije x.slika!
                  ),
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

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      _dateController.text = DateFormat('dd-MM-yyyy').format(dateTime);
      await _handleFormSubmission();
    }
  }

  Future<void> _handleFormSubmission() async {
    try {
      // var data = await _rezervacijeBiciklDostupniProvider!
      //     .getRezervacijeDostupni(DateTime.parse(_dateController.text));
      var datum = dateTime.toIso8601String();
      var tmpsearchdata = await _rezervacijeBiciklDostupniProvider!
          .getRezervacijeDostupni(datum);
//var bicikli= await _bicikliDostupniProvider.getByIds
      print('Fetched data: $data'); // Debugging line

      setState(() {
        data = tmpsearchdata as List<Bicikli>;
        _buildProductCardList();
      });

      //_buildDataListView();
    } catch (e) {
      // Handle the error here if needed
      print('Error fetching data: $e');
      throw Exception("Došlo je do greške!!!");
      // _showDialog(context, "Error",
      //     "Došlo je do greške string is not subtype of num"); // Debugging line
    }
  }
}
