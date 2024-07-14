import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';

class AdminPortalScreen extends StatelessWidget {
  const AdminPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: MenuBar(
                children: <Widget>[
                  SubmenuButton(
                    menuChildren: <Widget>[
                      MenuItemButton(
                        onPressed: () async {
                          showAboutDialog(
                            context: context,
                            applicationName:
                                'Potrebno napraviti profil korisnika',
                            applicationVersion: '1.7.',
                          );
                        },
                        child: const MenuAcceleratorLabel('Profil korisnika'),
                      ),
                      MenuItemButton(
                        onPressed: () {
                          showAboutDialog(
                            context: context,
                            applicationName: 'RentABikeWTR',
                            applicationVersion: '1.7.',
                          );
                        },
                        child: const MenuAcceleratorLabel('&O aplikaciji'),
                      ),
                      MenuItemButton(
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MyMaterialApp(),
                            ),
                          );
                        },
                        child: const MenuAcceleratorLabel('&Odjava'),
                      ),
                    ],
                    child: const MenuAcceleratorLabel('&Glavni meni'),
                  ),
                  SubmenuButton(
                    menuChildren: <Widget>[],
                    child: const MenuAcceleratorLabel('&Admin portal'),
                  ),
                  SubmenuButton(
                    menuChildren: <Widget>[
                      MenuItemButton(
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ListaKorisniciScreen(),
                            ),
                          );
                        },
                        child: const MenuAcceleratorLabel('Lista korisnika'),
                      ),
                      MenuItemButton(
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DodajKorisnikaScreen(),
                            ),
                          );
                        },
                        child: const MenuAcceleratorLabel('Dodaj korisnika'),
                      ),
                    ],
                    child: const MenuAcceleratorLabel('&Korisnici'),
                  ),
                  SubmenuButton(
                    menuChildren: <Widget>[
                      MenuItemButton(
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ListaVodiciScreen(),
                            ),
                          );
                        },
                        child: const MenuAcceleratorLabel('Lista vodica'),
                      ),
                      MenuItemButton(
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DodajVodicaScreen(),
                            ),
                          );
                        },
                        child: const MenuAcceleratorLabel('Dodaj vodica'),
                      ),
                    ],
                    child: const MenuAcceleratorLabel('&Vodici'),
                  ),
                  SubmenuButton(
                    menuChildren: <Widget>[
                      MenuItemButton(
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  RezervacijaListaRezervacijaScreen(),
                            ),
                          );
                        },
                        child: const MenuAcceleratorLabel('Lista rezervacija'),
                      ),
                      MenuItemButton(
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RezervacijaKorak1Screen(),
                            ),
                          );
                        },
                        child: const MenuAcceleratorLabel('Dodaj rezervaciju'),
                      ),
                    ],
                    child: const MenuAcceleratorLabel('&Rezervacije'),
                  ),
                  SubmenuButton(
                    menuChildren: <Widget>[
                      MenuItemButton(
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  PeriodicniIzvjestajRezervacijeScreen(),
                            ),
                          );
                        },
                        child:
                            const MenuAcceleratorLabel('Periodicni izvjestaj'),
                      ),
                    ],
                    child: const MenuAcceleratorLabel('&Izvjestaji'),
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
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
                          "RentABikeWTR -Admin portal!!!",
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
                  color: Colors.white,

                  //constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
                  child: Center(
                    child: Card(
                      color: Color.fromARGB(255, 78, 11, 212),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(100, 16, 100, 30),
                        child: Column(children: [
                          Image.asset(
                            "assets/images/logo6.jpg",
                            height: 400,
                            width: 400,
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MenuAcceleratorApp extends StatelessWidget {
  const MenuAcceleratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          const SingleActivator(LogicalKeyboardKey.keyT, control: true):
              VoidCallbackIntent(() {
            debugDumpApp();
          }),
        },
        child: const Scaffold(body: SafeArea(child: AdminPortalScreen())),
      ),
    );
  }
}
