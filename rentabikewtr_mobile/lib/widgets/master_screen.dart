import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_details_screen.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_mojeRezervacije_screen.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_pocetna_screen.dart';
import 'package:rentabikewtr_mobile/screens/rezervacije/rezervacija_korak1_screen.dart';

//import '../screens/cart/cart_screen.dart';
import '../model/bicikli.dart';
import 'kupac_drawer.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  final KorisniciProfil argumentsKor;
  MasterScreenWidget({this.child, required this.argumentsKor, Key? key})
      : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  int currentIndex = 0;
  Bicikli bic = Bicikli();

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RentABikeWTR")),
      drawer: KupacDrawer(
        argumentsKor: widget.argumentsKor,
      ),
      body: SafeArea(
        child: widget.child!,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Moje rezervacije',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        currentIndex: currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
