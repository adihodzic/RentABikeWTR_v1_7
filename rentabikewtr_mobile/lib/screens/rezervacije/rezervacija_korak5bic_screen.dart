import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_mobile/model/checkoutArguments.dart';

import '../../model/rezervacije.dart';
import '../../model/korisnici.dart';
import '../../providers/rezervacije_provider.dart';
import '../bicikli/bicikli_list_screen.dart';

class RezervacijaKorak5bicScreen extends StatefulWidget {
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
    widget.rezos.biciklId = widget.args.argumentsBic!.biciklId;
    widget.rezos.cijenaUsluge = 10;
    widget.rezos.kupacID = 8; //potrebno staviti aktivnog kupca
    widget.rezos.korisnikID = 8;
    widget.rezos.datumIzdavanja = DateTime.now();
    widget.rezos.vrijemePreuzimanja = DateTime.now();
    widget.rezos.vrijemeVracanja = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _rezervacijeProvider = Provider.of<RezervacijeProvider>(context);
    return WillPopScope(
      // WillPopScope onemogucava back button povratak na prethodnu stranicu
      child: Scaffold(
        appBar: AppBar(
            title: Text('Završetak rezervacije'),
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
                onPressed: () async {
                  // ignore: await_only_futures

                  await _rezervacijeProvider.insert(widget.rezos);
                  await Navigator.pushNamed(
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

//     @override
//     Widget build(BuildContext context) {
//       return WillPopScope(
//         // WillPopScope onemogucava back button povratak na prethodnu stranicu
//         child: Scaffold(
//           appBar: AppBar(
//               title: Text('Završetak rezervacije'),
//               automaticallyImplyLeading: false),
//           body: Column(
//             children: [
//               SizedBox(height: 50.0),
//               Text(
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 25.0,
//                     letterSpacing: 2.0,
//                     wordSpacing: 5.0,
//                     fontStyle: FontStyle.italic,
//                   ),
//                   "Uspješno je izvršena rezervacija! "),
//               SizedBox(height: 30.0),
//               Container(
//                 height: 200,
//                 width: 200,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                   image: AssetImage("assets/images/Logo.JPG"),
//                   //fit:  BoxFit.fill
//                 )),
//               ),
//               SizedBox(height: 30.0),
//               Text(
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 25.0,
//                     letterSpacing: 2.0,
//                     wordSpacing: 5.0,
//                     fontStyle: FontStyle.italic,
//                   ),
//                   "Hvala Vam što koristite naše usluge!!!"),
//               SizedBox(height: 30.0),
//               ElevatedButton(
//                   onPressed: () async {
//                     // ignore: await_only_futures
//                     await sendAPIRequest();
//                     Navigator.pushNamed(
//                       context,
//                       "${BicikliListScreen.routeName}",
//                     );
//                   },
//                   child: Text("Povratak na početnu stranicu"))
//             ],
//           ),
//         ),
//         //Property onWillPop mora biti da bi se onemogucio povratak na prethodnu stranicu
//         onWillPop: () async {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text(
//                   'Pop Screen Disabled. You cannot go to previous screen.'),
//               backgroundColor: Colors.red,
//             ),
//           );
//           return false;
//         },
//       );
//     }
//   }
// // //Future<T?> insert(dynamic request) async {
// //     var url = "$_baseUrl$_endpoint";
// //     var uri = Uri.parse(url);

// //     Map<String, String> headers = createHeaders();
// //     var jsonRequest = jsonEncode(request);
// //     var response = await http!.post(uri, headers: headers, body: jsonRequest);

// //     if (isValidResponseCode(response)) {
// //       var data = jsonDecode(response.body);
// //       return fromJson(data) as T;
// //     } else {
// //       return null;
// //     }
// //
// }
