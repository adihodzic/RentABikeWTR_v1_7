import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/model/turistickiVodici.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_biciklo_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_dezurnoVozilo_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_korisnika_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_modelBicikla_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_poslovnicu_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_proizvodjacaBicikla_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_rezervniDio_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_servisiranje_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_tipBicikla_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_turistRutu_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_vodica_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_bicikli_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_dezurnaVozila_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_korisnici_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_modeliBicikla_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_poslovnice.dart';
import 'package:rentabikewtr_desktop/screens/lista_poziviDezurnomVozilu.dart';
import 'package:rentabikewtr_desktop/screens/lista_proizvodjaciBicikla.dart';
import 'package:rentabikewtr_desktop/screens/lista_rezervniDijelovi_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_servisiranja.dart';
import 'package:rentabikewtr_desktop/screens/lista_tipoviBicikla.dart';
import 'package:rentabikewtr_desktop/screens/lista_turistRute_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_vodici_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';
import 'package:rentabikewtr_desktop/screens/vodici_detalji_screen.dart';

class MenuAdmin extends StatelessWidget {
  const MenuAdmin({
    super.key,
  });

// ignore: non_constant_identifier_names
  @override
  Widget build(BuildContext context) {
    return MenuBar(
      children: <Widget>[
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () async {
                showAboutDialog(
                  context: context,
                  applicationName: 'Potrebno napraviti profil korisnika',
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
                    builder: (context) => RezervacijaListaRezervacijaScreen(),
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
              child: const MenuAcceleratorLabel('Periodicni izvjestaj'),
            ),
          ],
          child: const MenuAcceleratorLabel('&Izvjestaji'),
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
        child: Scaffold(
            body: SafeArea(
                child: VodiciDetaljiScreen(
          argumentsK: TuristickiVodici(),
        ))),
      ),
    );
  }
}
