import 'package:flutter/material.dart';
import 'package:rentabikewtr_desktop/providers/bicikliPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/bicikli_detalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/bicikli_provider.dart';
import 'package:rentabikewtr_desktop/providers/dezurnaVozilaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/dezurnaVozila_detalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/dezurnaVozila_provider.dart';
import 'package:rentabikewtr_desktop/providers/drzave_provider.dart';
import 'package:rentabikewtr_desktop/providers/kategorijeDijelovaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisniciRezervacijePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/korisnici_provider.dart';
import 'package:rentabikewtr_desktop/providers/kupci_provider.dart';
import 'package:rentabikewtr_desktop/providers/modeliBiciklaDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/modeliBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/modeliBicikla_provider.dart';
import 'package:rentabikewtr_desktop/providers/najaveOdmoraPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/poslovniceDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/poslovnicePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/poslovnice_provider.dart';
import 'package:rentabikewtr_desktop/providers/poziviDezurnomVoziluPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/poziviDezurnomVozilu_provider.dart';
import 'package:rentabikewtr_desktop/providers/proizvodjaciBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/rezervacijeBiciklDostupni_provider.dart';
import 'package:rentabikewtr_desktop/providers/rezervacijeBicikl_provider.dart';
import 'package:rentabikewtr_desktop/providers/rezervacije_provider.dart';
import 'package:rentabikewtr_desktop/providers/rezervniDijeloviPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/rezervniDijelovi_detalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/servisiranjaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/servisiranja_detalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/servisiranja_provider.dart';
import 'package:rentabikewtr_desktop/providers/tipoviBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/tipoviBicikla_provider.dart';
import 'package:rentabikewtr_desktop/providers/tipoviBicikla_detalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistRutePregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistRute_detalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistRute_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciDetalji_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodiciPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/turistickiVodici_provider.dart';
import 'package:rentabikewtr_desktop/providers/velicineBiciklaPregled_provider.dart';
import 'package:rentabikewtr_desktop/providers/xRezervacijeResult_provider.dart';
import 'package:rentabikewtr_desktop/screens/adminPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_bicikli_screen.dart';
import 'package:rentabikewtr_desktop/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';
import 'package:rentabikewtr_desktop/utils/util.dart';

void main() async {
  // await windowManager.setMinimumSize(const Size(309, 600));
  // await windowManager.setMaximumSize(const Size(618, 1200));
  // await windowManager.setMaximizable(false);
  // await windowManager.setSize(const Size(309, 600));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BicikliDetaljiProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciProvider()),
      //ChangeNotifierProvider(create: (_) => KorisniciUpsertProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciPregledProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciDetaljiProvider()),
      ChangeNotifierProvider(create: (_) => DrzaveProvider()),
      ChangeNotifierProvider(create: (_) => BicikliProvider()),
      ChangeNotifierProvider(create: (_) => BicikliPregledProvider()),
      ChangeNotifierProvider(create: (_) => ModeliBiciklaPregledProvider()),
      ChangeNotifierProvider(create: (_) => ModeliBiciklaDetaljiProvider()),
      ChangeNotifierProvider(create: (_) => ModeliBiciklaProvider()),
      ChangeNotifierProvider(create: (_) => TipoviBiciklaPregledProvider()),
      ChangeNotifierProvider(create: (_) => TipoviBiciklaDetaljiProvider()),
      ChangeNotifierProvider(
          create: (_) => ProizvodjaciBiciklaPregledProvider()),
      ChangeNotifierProvider(create: (_) => VelicineBiciklaPregledProvider()),
      ChangeNotifierProvider(create: (_) => TuristickiVodiciProvider()),
      ChangeNotifierProvider(create: (_) => TuristickiVodiciPregledProvider()),
      ChangeNotifierProvider(create: (_) => TuristickiVodiciDetaljiProvider()),
      ChangeNotifierProvider(create: (_) => RezervacijeBiciklProvider()),
      ChangeNotifierProvider(create: (_) => RezervacijeProvider()),
      ChangeNotifierProvider(create: (_) => TuristRutePregledProvider()),
      ChangeNotifierProvider(create: (_) => TuristRuteDetaljiProvider()),
      ChangeNotifierProvider(create: (_) => TuristRuteProvider()),
      ChangeNotifierProvider(
          create: (_) => RezervacijeBiciklDostupniProvider()),
      ChangeNotifierProvider(
          create: (_) => KorisniciRezervacijePregledProvider()),
      ChangeNotifierProvider(create: (_) => KupciProvider()),
      ChangeNotifierProvider(create: (_) => XRezervacijeResultProvider()),
      ChangeNotifierProvider(create: (_) => PoslovnicePregledProvider()),
      ChangeNotifierProvider(create: (_) => PoslovniceDetaljiProvider()),
      ChangeNotifierProvider(create: (_) => PoslovniceProvider()),
      ChangeNotifierProvider(create: (_) => TipoviBiciklaProvider()),
      ChangeNotifierProvider(
          create: (_) => PoziviDezurnomVoziluPregledProvider()),
      ChangeNotifierProvider(create: (_) => PoziviDezurnomVoziluProvider()),
      ChangeNotifierProvider(create: (_) => DezurnaVozilaPregledProvider()),
      ChangeNotifierProvider(create: (_) => DezurnaVozilaDetaljiProvider()),
      ChangeNotifierProvider(create: (_) => DezurnaVozilaProvider()),
      ChangeNotifierProvider(create: (_) => RezervniDijeloviPregledProvider()),
      ChangeNotifierProvider(
          create: (_) => KategorijeDijelovaPregledProvider()),
      ChangeNotifierProvider(create: (_) => RezervniDijeloviDetaljiProvider()),
      ChangeNotifierProvider(create: (_) => ServisiranjaPregledProvider()),
      ChangeNotifierProvider(create: (_) => ServisiranjaDetaljiProvider()),
      ChangeNotifierProvider(create: (_) => ServisiranjaProvider()),
      ChangeNotifierProvider(create: (_) => NajaveOdmoraPregledProvider()),
    ],
    child: const MyMaterialApp(),
  ));
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RentABikeWTR',
      theme: ThemeData(primarySwatch: Colors.blue),
      //useMaterial3: true,
      home: LoginPage(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a blue toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const LoginPage(title: 'RentABikeWTR_'),
//     );
//   }
// }

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  late KorisniciProvider _korisniciProvider;
  KorisniciDetaljiProvider? _korisniciDetaljiProvider = null;
  BicikliPregledProvider? _bicikliPregledProvider = null;

  @override
  Widget build(BuildContext context) {
    _korisniciProvider = context.read<KorisniciProvider>();
    _korisniciDetaljiProvider = context.read<KorisniciDetaljiProvider>();
    _bicikliPregledProvider = context.read<BicikliPregledProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              //constraints: BoxConstraints(maxWidth: 800, maxHeight: 400),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    // Image.network("https://www.fit.ba/content/public/images/og-image.jpg", height: 100, width: 100,),
                    Image.asset(
                      "assets/images/logo.jpg",
                      height: 200,
                      width: 500,
                    ),
                    SizedBox(
                      height: 50,
                    ),

                    Text(
                      "RentABikeWTR - Dobro došli!!!",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 11, 7, 255)),
                    )
                  ]),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              //constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
              child: Center(
                child: Card(
                  color: Color.fromARGB(255, 78, 11, 212),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
                    child: Column(children: [
                      // Image.network("https://www.fit.ba/content/public/images/og-image.jpg", height: 100, width: 100,),
                      // Image.asset(
                      //   "assets/images/logo3.jpg",
                      //   height: 100,
                      //   width: 100,
                      // ),

                      TextField(
                        style: TextStyle(
                            color: Color.fromARGB(255, 248, 244, 244)),
                        decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Color.fromARGB(239, 251, 251, 251)),
                            floatingLabelStyle: TextStyle(
                                color: Color.fromARGB(255, 234, 249, 104)),
                            labelText: "Username",
                            prefixIconColor: Color.fromARGB(250, 254, 254, 255),
                            prefixIcon: Icon(Icons.email)),
                        controller: _usernameController,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: Color.fromARGB(239, 251, 251, 251)),
                            floatingLabelStyle: TextStyle(
                                color: Color.fromARGB(255, 234, 249, 104)),
                            labelText: "Password",
                            prefixIconColor: Color.fromARGB(250, 254, 254, 255),
                            prefixIcon: Icon(Icons.password)),
                        controller: _passwordController,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            var username = _usernameController.text;
                            var password = _passwordController.text;
                            _passwordController.text = username;

                            print("login proceed $username $password");

                            Authorization.username = username;
                            Authorization.password = password;

                            try {
                              await _korisniciProvider.get();
                              var currentUser = await _korisniciDetaljiProvider
                                  ?.getProfilKorisnika(Authorization.username!);
                              if (currentUser != null &&
                                  currentUser.ulogaID == 1) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AdminPortalScreen(),
                                  ),
                                );
                              } else if (currentUser != null &&
                                  currentUser.ulogaID == 2) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RadnikPortalScreen(),
                                  ),
                                );
                              } else {
                                showDialog(
                                    context: context,
                                    builder: ((context) => AlertDialog(
                                          title: Text("Error"),
                                          content: Text(
                                              "Pogrešno korisničko ime ili lozinka"),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("OK"))
                                          ],
                                        )));
                              }
                            } on Exception catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: Text("Error"),
                                        content: Text(e.toString()),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text("OK"))
                                        ],
                                      ));
                            }
                          },
                          child: Text("Login"))
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
