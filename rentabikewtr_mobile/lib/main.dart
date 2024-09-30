//import 'package:thirtyfour_app/providers/cart_provider.dart';
//import 'package:thirtyfour_app/providers/order_provider.dart';
//import 'dart:html';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/gestures.dart';
import 'package:rentabikewtr_mobile/model/bicikliRecommend.dart';
import 'package:rentabikewtr_mobile/model/korisniciProfil.dart';
import 'package:rentabikewtr_mobile/model/korisnici.dart';
import 'package:rentabikewtr_mobile/model/mojProfilArguments.dart';
import 'package:rentabikewtr_mobile/model/mojeRezervacijeArguments.dart';
import 'package:rentabikewtr_mobile/model/screenArguments.dart';
import 'package:rentabikewtr_mobile/providers/bicikliRecommend_provider.dart';
import 'package:rentabikewtr_mobile/providers/bicikli_provider.dart';
import 'package:rentabikewtr_mobile/providers/godineKupci_provider.dart';
import 'package:rentabikewtr_mobile/providers/korisniciProfil_provider.dart';
import 'package:rentabikewtr_mobile/providers/korisniciProfil_provider.dart';
import 'package:rentabikewtr_mobile/providers/rezervacijeBiciklDostupni_provider.dart';
import 'package:rentabikewtr_mobile/providers/rezervacije_provider.dart';
import 'package:rentabikewtr_mobile/providers/turistRute_provider.dart';
import 'package:rentabikewtr_mobile/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_details_screen.dart';
//import 'package:thirtyfour_app/screens/cart/cart_screen.dart';
//import 'package:thirtyfour_app/screens/bicikli/product_details_screen.dart';
import 'package:rentabikewtr_mobile/screens/bicikli/bicikli_list_screen.dart';
import 'package:rentabikewtr_mobile/screens/kupci/kupac_mojProfil_screen.dart';
import 'package:rentabikewtr_mobile/screens/rezervacije/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_mobile/screens/rezervacije/rezervacija_korak3tr_screen.dart';
import 'package:rentabikewtr_mobile/screens/rezervacije/rezervacija_korak3bic_screen.dart';
import 'package:rentabikewtr_mobile/screens/rezervacije/rezervacija_korak5bic_screen.dart';
import 'package:rentabikewtr_mobile/screens/turistRute/turistRute_details_screen.dart';
import 'package:rentabikewtr_mobile/screens/turistRute/turistRute_list_screen.dart';
//import 'package:rentabikewtr_mobile/screens/turistRute/turistRute_list_screen.dart';
import 'package:rentabikewtr_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rentabikewtr_mobile/providers/korisnici_provider.dart';

import 'model/bicikli.dart';
import 'model/checkoutArguments.dart';
import 'model/checkoutTrArguments.dart';
import 'model/rezervacije.dart';
import 'model/rezervacijePregled.dart';
import 'model/turistRute.dart';
import 'model/turistickiVodici.dart';
import 'providers/detalji_provider.dart';
import 'providers/dezurnaVozila_provider.dart';
import 'providers/drzave_provider.dart';
import 'providers/korisniciProfilUpdate_provider.dart';
import 'providers/korisniciProfil_provider.dart';
import 'providers/korisniciProfil_provider.dart';
import 'providers/korisniciRegistracija_provider.dart';
import 'providers/kupciProfil_provider.dart';
import 'providers/kupci_provider.dart';
import 'providers/lokacijeOdmora_provider.dart';
import 'providers/najaveOdmora_provider.dart';
import 'providers/ocjene_provider.dart';
import 'providers/poslovnice_provider.dart';
import 'providers/poziviDezurnomVozilu_provider.dart';
import 'providers/rezervacijeKupac_provider.dart';
import 'screens/kupci/kupac_mojeRezervacije_details_screen.dart';
import 'screens/kupci/kupac_mojeRezervacije_screen.dart';
import 'screens/kupci/kupac_ocjene_screen.dart';
import 'screens/kupci/kupac_pocetna_screen.dart';
import 'screens/kupci/kupac_registracija_screen.dart';
import 'screens/rezervacije/checkout_page.dart';
import 'screens/rezervacije/checkout_tr_page.dart';
import 'screens/rezervacije/rezervacija_korak5tr_screen.dart';
import 'screens/vodicapp/vodic_najave_odmora_screen.dart';
import 'screens/vodicapp/vodic_pocetna_screen.dart';
import 'screens/vodicapp/vodic_poziv_dezurnom_vozilu_screen.dart';

void main() async {
  // ovdje sam prepravio main funkciju i nije vise prazna
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global =
      // ignore: unnecessary_new
      new MyHttpOverrides(); // Ovo sam dodao zbog certifikata kod sesije
  //initializeStripe();
  //String stripePublishableKey;
/////////////////////////////////////////////////////////////////////////////
  ///Ovdje nije trebao biti upisan Stripe.publishable key ...Mora biti na ChekcoutPage-u i CheckoutTrPage-u
  // Stripe.publishableKey =
  //     "pk_test_51NDWrCFgNQXat14ZALPUUNLEwB7tf3ByFuIp7fjjgX9fPtm7bcWkK6zWsaiHsE1zRWywqzcOnLj27Z1U6MKgkXxV00fY3XOvkl";

  //await Stripe.instance.applySettings();
  //await dotenv.load(fileName: "assets/.env");

  ///ovo je dodano u main funkciju zbog stripe-a
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BicikliProvider()),
      ChangeNotifierProvider(create: (_) => DetaljiProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciProvider()),
      ChangeNotifierProvider(create: (_) => RezervacijeProvider()),
      ChangeNotifierProvider(
          create: (_) => RezervacijeBiciklDostupniProvider()),
      ChangeNotifierProvider(create: (_) => RezervacijeKupacProvider()),
      ChangeNotifierProvider(create: (_) => TuristRuteProvider()),
      ChangeNotifierProvider(create: (_) => TuristickiVodiciProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciProfilProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciProfilUpdateProvider()),
      ChangeNotifierProvider(create: (_) => LokacijeOdmoraProvider()),
      ChangeNotifierProvider(create: (_) => NajaveOdmoraProvider()),
      ChangeNotifierProvider(create: (_) => PoziviDezurnomVoziluProvider()),
      ChangeNotifierProvider(create: (_) => DezurnaVozilaProvider()),
      ChangeNotifierProvider(create: (_) => PoslovniceProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciRegistracijaProvider()),
      ChangeNotifierProvider(create: (_) => KupciProvider()),
      ChangeNotifierProvider(create: (_) => DrzaveProvider()),
      ChangeNotifierProvider(create: (_) => KupciProfilProvider()),
      ChangeNotifierProvider(create: (_) => OcjeneProvider()),
      ChangeNotifierProvider(create: (_) => BicikliRecommendProvider()),
      ChangeNotifierProvider(create: (_) => GodineKupciProvider()),
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: Colors.deepPurple,
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.deepPurple,
                  textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic))),

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            headlineLarge:
                TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headlineSmall:
                TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          ),
        ),
        home: HomePage(),
        onGenerateRoute: (settings) {
          //Bicikli bic;
          if (settings.name == BicikliListScreen.routeName) {
            final objekat0 = settings.arguments as KorisniciProfil;
            return MaterialPageRoute(
                builder: ((context) => BicikliListScreen(
                      argumentsKor: objekat0,
                    )));
            // } else if (settings.name == BicikliDetailsScreen.routeName) {
            //   final objekat = settings.arguments as int;
            //   return MaterialPageRoute(
            //       builder: ((context) =>
            //           BicikliDetailsScreen(arguments: objekat)));
            // }
            /////////////////////////////////Kopirano iznad da imam prosljeđivanje objekta
          } else if (settings.name == BicikliDetailsScreen.routeName) {
            final objekat = settings.arguments as Bicikli;
            final objekat2 = settings.arguments as KorisniciProfil;
            final objekat02 = settings.arguments as DateTime;
            return MaterialPageRoute(
                builder: ((context) => BicikliDetailsScreen(
                      argumentsB: objekat,
                      argumentsK: objekat2,
                      argumentsDate: objekat02,
                    )));
          } else if (settings.name == RezervacijaKorak1Screen.routeName) {
            final objekatk1 = settings.arguments as Bicikli;
            final objekatk01 = settings.arguments as KorisniciProfil;
            final objekatk001 = settings.arguments as DateTime;
            //final objekatk11 = settings.arguments as Bicikli;
            return MaterialPageRoute(
                builder: ((context) => RezervacijaKorak1Screen(
                      argumentsBic: objekatk1,
                      argumentsKor: objekatk01,
                      argumentsDate: objekatk001,
                      //arguments: objekatk11,
                    )));
          } else if (settings.name == TuristRuteListScreen.routeName) {
            final objekatk2 = settings.arguments as Bicikli;
            final objekatk02 = settings.arguments as KorisniciProfil;
            final objekatk002 = settings.arguments as DateTime;
            // final objekatk0002 = settings.arguments as TuristickiVodici;
            //final objekatk21 = settings.arguments as ;
            return MaterialPageRoute(
              builder: ((context) => TuristRuteListScreen(
                    argumentsBic: objekatk2,
                    argumentsKor: objekatk02,
                    argumentsDate: objekatk002,
                  )),
            );
          } else if (settings.name == TuristRuteDetailsScreen.routeName) {
            final objekatk21 = settings.arguments as ScreenArguments;
            return MaterialPageRoute(
              builder: ((context) => TuristRuteDetailsScreen(
                    args: objekatk21, // argumentsBic: objekatk22,

                    //arguments: objekatk21,
                  )),
            );
          } else if (settings.name == RezervacijaKorak3bicScreen.routeName) {
            final objekatk3 = settings.arguments as Bicikli;
            final objekatk03 = settings.arguments as KorisniciProfil;
            final objekatk003 = settings.arguments as DateTime;
            return MaterialPageRoute(
              builder: ((context) => RezervacijaKorak3bicScreen(
                    argumentsBiciklo: objekatk3,
                    argumentsKorisnik: objekatk03,
                    argumentsDate: objekatk003,
                  )),
            );
          } else if (settings.name == RezervacijaKorak3trScreen.routeName) {
            final objektktr31 = settings.arguments as ScreenArguments;
            // final objekatktr31 = settings.arguments as Bicikli;
            // final objekatktr031 = settings.arguments as KorisniciProfil;
            // final objekatktr0031 = settings.arguments as TuristRute;
            // final objekatktr00031 = settings.arguments as TuristickiVodici;

            return MaterialPageRoute(
              builder: ((context) => RezervacijaKorak3trScreen(
                    arguments: objektktr31,
                    // argumentsBic: objekatktr31,
                    // argumentsKor: objekatktr031,
                    // argumentsTR: objekatktr0031,
                    // argumentsTV: objekatktr00031,
                  )),
            );
          } else if (settings.name == CheckoutPage.routeName) {
            final objekatk41 = settings.arguments as CheckoutArguments;
            return MaterialPageRoute(
              builder: ((context) => CheckoutPage(
                    args: objekatk41,
                  )),
            );
          } else if (settings.name == RezervacijaKorak5bicScreen.routeName) {
            final objekatk45 = settings.arguments as CheckoutArguments;
            return MaterialPageRoute(
              builder: ((context) => RezervacijaKorak5bicScreen(
                    args: objekatk45,
                  )),
            );
          } else if (settings.name == CheckoutTrPage.routeName) {
            final objekatk42 = settings.arguments as CheckoutTrArguments;
            return MaterialPageRoute(
              builder: ((context) => CheckoutTrPage(
                    args: objekatk42,
                  )),
            );
          } else if (settings.name == RezervacijaKorak5trScreen.routeName) {
            final objekatk5 = settings.arguments as CheckoutTrArguments;
            return MaterialPageRoute(
              builder: ((context) =>
                  RezervacijaKorak5trScreen(args: objekatk5)),
            );
          } else if (settings.name == VodicPocetnaScreen.routeName) {
            final objekatv = settings.arguments as KorisniciProfil;
            return MaterialPageRoute(
                builder: ((context) => VodicPocetnaScreen(
                      argumentsKor: objekatv,
                    )));
          } else if (settings.name ==
              VodicPozivDezurnomVoziluScreen.routeName) {
            final objekatv2 = settings.arguments as KorisniciProfil;
            return MaterialPageRoute(
                builder: ((context) =>
                    VodicPozivDezurnomVoziluScreen(argumentsKor: objekatv2)));
          } else if (settings.name == VodicNajaveOdmoraScreen.routeName) {
            final objekatv3 = settings.arguments as KorisniciProfil;
            return MaterialPageRoute(
                builder: ((context) => VodicNajaveOdmoraScreen(
                      argumentsKor: objekatv3,
                    )));
          } else if (settings.name == HomePage.routeName) {
            //final objekat = settings.arguments as Bicikli;
            return MaterialPageRoute(builder: ((context) => HomePage()));
          } else if (settings.name == KupacRegistracijaScreen.routeName) {
            //final objekat = settings.arguments as Bicikli;
            return MaterialPageRoute(
                builder: ((context) => KupacRegistracijaScreen()));
          } else if (settings.name == KupacPocetnaScreen.routeName) {
            final objekatKP = settings.arguments as KorisniciProfil;
            return MaterialPageRoute(
                builder: ((context) =>
                    KupacPocetnaScreen(argumentsKor: objekatKP)));
          } else if (settings.name == KupacMojProfilScreen.routeName) {
            final objekatMP = settings.arguments as KorisniciProfil;
            return MaterialPageRoute(
                builder: ((context) =>
                    KupacMojProfilScreen(argumentsKor: objekatMP)));
          } else if (settings.name == KupacMojeRezervacijeScreen.routeName) {
            final objekatKMR = settings.arguments as KorisniciProfil;
            return MaterialPageRoute(
                builder: ((context) =>
                    KupacMojeRezervacijeScreen(argumentsKor: objekatKMR)));
          } else if (settings.name ==
              KupacMojeRezervacijeDetailsScreen.routeName) {
            final objekatKMRD = settings.arguments as MojeRezervacijeArguments;
            return MaterialPageRoute(
                builder: ((context) =>
                    KupacMojeRezervacijeDetailsScreen(args: objekatKMRD)));
          } else if (settings.name == KupacOcjeneScreen.routeName) {
            final objekatKO = settings.arguments as MojeRezervacijeArguments;
            return MaterialPageRoute(
                builder: ((context) => KupacOcjeneScreen(args: objekatKO)));
          }
        }
        //},
        ),
  ));
}

class HomePage extends StatelessWidget {
  static const String routeName = "/home_stranica";
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late KorisniciProvider _korisniciProvider;
  late KorisniciProfilProvider _korisniciProfilProvider;
  Korisnici currentUser = Korisnici();
  int ulogaid = 0;

  @override
  Widget build(BuildContext context) {
    _korisniciProvider = Provider.of<KorisniciProvider>(context, listen: false);
    _korisniciProfilProvider =
        Provider.of<KorisniciProfilProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("RentABikeWTR"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Logo6.JPG"),
                      fit: BoxFit.fill)),
              child: Stack(children: [
                // Positioned(
                //     left: 120,
                //     top: 0,
                //     width: 80,
                //     height: 120,
                //     child: Container(
                //         decoration: BoxDecoration(
                //             image: DecorationImage(
                //       image: AssetImage("assets/images/Logo2.JPG"),
                //     )))),
                // Positioned(
                //     right: 40,
                //     top: 0,
                //     width: 80,
                //     height: 120,
                //     child: Container(
                //         decoration: BoxDecoration(
                //             image: DecorationImage(
                //       image: AssetImage("assets/images/clock.png"),
                //     )))),
                Container(
                  child: Center(
                      child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  )),
                )
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.pedal_bike),
                          hintText: "Korisničko ime",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          suffixIcon: Icon(Icons.person)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.pedal_bike),
                        hintText: "Lozinka",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        suffixIcon: Icon(Icons.password),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6)
                ]),
              ),
              child: InkWell(
                // child: Icon(Icons.pedal_bike),
                onTap: () async {
                  try {
                    Authorization.username = _usernameController.text;
                    Authorization.password = _passwordController.text;

                    await _korisniciProvider.get();

                    //morao sam uraditi zbog logina i ovaj get iznad na _korisniciProvider
                    //provjera koji je tip korisnika
                    var currentUser = await _korisniciProfilProvider
                        .getProfilKorisnika(Authorization.username!);
                    if (currentUser != null && currentUser.ulogaID == 4) {
                      Navigator.pushReplacementNamed(
                          context, KupacPocetnaScreen.routeName,
                          arguments: currentUser);
                    } else if (currentUser != null &&
                        currentUser.ulogaID == 3) {
                      //ovdje cu raditi pushReplacment da se ne bi mogao navigator vratiti na login page
                      Navigator.pushReplacementNamed(
                          context, VodicPocetnaScreen.routeName,
                          arguments: currentUser);
                    }
                  } catch (e) {
                    print('Greska iz konteksta: $e');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text("Greška"),
                              //content: Text(e.toString()),
                              content: Text(
                                  "Pogrešno korisničko ime ili lozinka!!!"),
                              actions: [
                                TextButton(
                                  child: Text("Ok"),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ));
                  }
                },
                child: Center(
                  child: Text(
                    "Login",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () async {
                  Navigator.pushNamed(
                      context, KupacRegistracijaScreen.routeName);
                },
                child: Text("Registracija-kupac",
                    style: TextStyle(color: Colors.blue))),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  // pretragaKorisnika() async {
  //   var users = await _korisniciProvider.get(Authorization.username);
  //   if (users != null) {
  //     for (currentUser in users) {
  //       if (currentUser.korisnickoIme == Authorization.username) {
  //         ulogaid = currentUser.ulogaID as int;
  //         //Navigator.pushNamed(context, BicikliListScreen.routeName);
  //       }
  //     }
  //   }

  //if (ulogaid == 4) {
  //   Navigator.pushNamed(context, BicikliListScreen.routeName);
  //}
}

//Ovo je zbog certifikata dodano u main.dart jer imamo problem u Stripe sesiji
//Morao sam SecurityContext postaviti kao nullable jer se javi greska na createHttpClient
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
