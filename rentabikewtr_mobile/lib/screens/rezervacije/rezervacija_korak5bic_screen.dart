import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_mobile/model/checkoutArguments.dart';
import 'package:rentabikewtr_mobile/model/screenArguments.dart';
import 'package:rentabikewtr_mobile/widgets/header_widget.dart';

import '../../model/rezervacije.dart';
import '../../model/korisnici.dart';
import '../../providers/rezervacije_provider.dart';
import '../bicikli/bicikli_list_screen.dart';

class RezervacijaKorak5bicScreen extends StatefulWidget {
  String title = "Završetak rezervacije";
  CheckoutArguments args;
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
  //samo se required parametri iz konstruktora moraju navesti
  //late RezervacijeProvider? _rezervacijeProvider;
  RezervacijaKorak5bicScreen({Key? key, required this.args}) : super(key: key);
  static const String routeName = "/rezervacijebic_success";

  @override
  State<RezervacijaKorak5bicScreen> createState() =>
      _RezervacijaKorak5bicScreenState();
}

class _RezervacijaKorak5bicScreenState
    extends State<RezervacijaKorak5bicScreen> {
  //}
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
    widget.rezos.biciklId = widget.args.argumentsBic!.biciklID;
    widget.rezos.cijenaUsluge = widget.args.argumentsBic!.cijenaBicikla;
    widget.rezos.kupacID =
        widget.args.argumentsKor!.korisnikId!; //potrebno staviti aktivnog kupca
    widget.rezos.korisnikID = widget.args.argumentsKor!.korisnikId!;
    widget.rezos.datumIzdavanja = widget.args.argumentsDate;

    super.initState();
    setState(() {
      //Kombinuje se datum rezervacije sa vremenom preuzimanja i vremenom vraćanja
      int year = widget.rezos.datumIzdavanja!.year;
      int month = widget.rezos.datumIzdavanja!.month;
      int day = widget.rezos.datumIzdavanja!.day;
      String stringTime = "09:00";
      String stringTime2 = "18:00";
      DateFormat timeFormat = DateFormat("hh:mm");
      DateTime time = timeFormat.parse(stringTime);
      DateTime time2 = timeFormat.parse(stringTime2);

      DateTime combinedDateTime =
          DateTime(year, month, day, time.hour, time.minute);
      DateTime combinedDateTime2 =
          DateTime(year, month, day, time2.hour, time2.minute);

      widget.rezos.vrijemeVracanja = combinedDateTime;
      widget.rezos.vrijemePreuzimanja = combinedDateTime2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _rezervacijeProvider = Provider.of<RezervacijeProvider>(context);
    return WillPopScope(
      // WillPopScope onemogucava back button povratak na prethodnu stranicu
      child: Scaffold(
        appBar: AppBar(
            title: Text('RentABikeWTR'), automaticallyImplyLeading: false),
        body: Column(
          children: [
            HeaderWidget(title: "Završetak rezervacije"),
            SizedBox(height: 50.0),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/Logo6.JPG"),
                    //fit:  BoxFit.fill
                  )),
                ),
              ),
            ),
            SizedBox(height: 100.0),
            Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  wordSpacing: 5.0,
                  fontStyle: FontStyle.normal,
                ),
                "Uspješno je izvršena rezervacija! "),
            SizedBox(height: 10.0),
            Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                  letterSpacing: 2.0,
                  wordSpacing: 5.0,
                  fontStyle: FontStyle.normal,
                ),
                "Hvala Vam što koristite naše usluge!!!"),
            SizedBox(height: 30.0),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.end,
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
                      padding: const EdgeInsets.all(20.0), //prosiren inkWell
                      child: InkWell(
                        child: Center(
                            child: Text("Povratak na početnu stranicu",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                        onTap: () async {
                          try {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BicikliListScreen(
                                  argumentsKor: widget.args.argumentsKor!,
                                ),
                              ),
                            );
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
