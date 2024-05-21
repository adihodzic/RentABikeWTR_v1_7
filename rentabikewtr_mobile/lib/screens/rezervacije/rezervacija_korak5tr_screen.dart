import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

//import '../../model/checkoutArguments.dart';
import '../../model/checkoutTrArguments.dart';
import '../../model/rezervacije.dart';
import '../../providers/rezervacije_provider.dart';
import '../bicikli/bicikli_list_screen.dart';

class RezervacijaKorak5trScreen extends StatefulWidget {
  CheckoutTrArguments args;
  Rezervacije rezos = Rezervacije(
      statusPlacanja: true,
      datumIzdavanja: null,
      vrijemePreuzimanja: null,
      vrijemeVracanja: null,
      cijenaUsluge: null,
      biciklId: null,
      turistickiVodicID: null,
      turistRutaID: null,
      kupacID: null,
      korisnikID: null);
  RezervacijaKorak5trScreen({Key? key, required this.args}) : super(key: key);
  static const String routeName = "/rezervacijetr_success";

  @override
  State<RezervacijaKorak5trScreen> createState() =>
      _RezervacijaKorak5trScreenState();
}

class _RezervacijaKorak5trScreenState extends State<RezervacijaKorak5trScreen> {
  @override
  void initState() {
    widget.rezos = Rezervacije(
        statusPlacanja: true,
        datumIzdavanja: null,
        vrijemePreuzimanja: null,
        vrijemeVracanja: null,
        cijenaUsluge: null,
        biciklId: null,
        turistickiVodicID: null,
        turistRutaID: null,
        kupacID: null,
        korisnikID: null);
    widget.rezos.biciklId = widget.args.argumentsBic!.biciklId;
    widget.rezos.cijenaUsluge = 10;
    widget.rezos.kupacID = 8; //potrebno staviti aktivnog kupca
    widget.rezos.korisnikID = 8;
    widget.rezos.datumIzdavanja = DateTime.now();
    widget.rezos.vrijemePreuzimanja = DateTime.now();
    widget.rezos.vrijemeVracanja = DateTime.now();
    widget.rezos.turistRutaID = widget.args.argumentsTR!.turistRutaId;
    widget.rezos.turistickiVodicID = widget.args.argumentsTV!.turistickiVodicId;
    super.initState();
  }

//   @override
//   Widget build(BuildContext context) {

//   }
// }

// class RezervacijaKorak5trScreen extends StatelessWidget {
//   CheckoutArguments args;
//   Rezervacije rezos = Rezervacije(
//       statusPlacanja: true,
//       datumIzdavanja: null,
//       vrijemePreuzimanja: null,
//       vrijemeVracanja: null,
//       cijenaUsluge: null,
//       biciklId: null,
//       turistickiVodicID: null,
//       turistRutaID: null,
//       kupacID: null,
//       korisnikID: null);
//   RezervacijaKorak5trScreen({Key? key, required this.args}) : super(key: key);
//   static const String routeName = "/rezervacijetr_success";

//   @override
//   void initState() {
//     widget.rezos = Rezervacije(
//         statusPlacanja: true,
//         datumIzdavanja: null,
//         vrijemePreuzimanja: null,
//         vrijemeVracanja: null,
//         cijenaUsluge: null,
//         biciklId: null,
//         turistickiVodicID: null,
//         turistRutaID: null,
//         kupacID: null,
//         korisnikID: null);
//     widget.rezos.biciklId = widget.args.argumentsBic!.biciklId;
//     widget.rezos.cijenaUsluge = 10;
//     widget.rezos.kupacID = 8; //potrebno staviti aktivnog kupca
//     widget.rezos.korisnikID = 8;
//     widget.rezos.datumIzdavanja = DateTime.now();
//     widget.rezos.vrijemePreuzimanja = DateTime.now();
//     widget.rezos.vrijemeVracanja = DateTime.now();
//     super.initState();
//   }
  @override
  Widget build(BuildContext context) {
    final _rezervacijeProvider = Provider.of<RezervacijeProvider>(context);
    return WillPopScope(
      // WillPopScope onemogucava back button povratak na prethodnu stranicu
      child: Scaffold(
        appBar: AppBar(
            title: Text('Završetak rezervacije WTR'),
            automaticallyImplyLeading: false),
        body: Column(
          children: [
            SizedBox(height: 50.0),
            Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 25.0,
                  letterSpacing: 2.0,
                  wordSpacing: 5.0,
                  fontStyle: FontStyle.italic,
                ),
                "Uspješno je izvršena rezervacija! "),
            SizedBox(height: 30.0),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/Logo.JPG"),
                //fit:  BoxFit.fill
              )),
            ),
            SizedBox(height: 30.0),
            Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 25.0,
                  letterSpacing: 2.0,
                  wordSpacing: 5.0,
                  fontStyle: FontStyle.italic,
                ),
                "Hvala Vam što koristite naše usluge!!!"),
            SizedBox(height: 30.0),
            ElevatedButton(
                //makeReservation();
                onPressed: () async {
                  await _rezervacijeProvider.insert(widget.rezos);
                  Navigator.pushNamed(
                    context,
                    "${BicikliListScreen.routeName}",
                  );
                },
                child: Text("Povratak na početnu stranicu"))
          ],
        ),
      ),

      //Property onWillPop mora biti da bi se onemogucio povratak na prethodnu stranicu
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Pop Screen Disabled. You cannot go to previous screen.'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      },
    );
  }
}
