import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentabikewtr_desktop/main.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_biciklo_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_dezurnoVozilo_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_modelBicikla_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_poslovnicu_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_pozivDezurnomVozilu_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_proizvodjacaBicikla_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_rezervniDio_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_servisiranje_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_tipBicikla_screen.dart';
import 'package:rentabikewtr_desktop/screens/dodaj_turistRutu_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_bicikli_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_dezurnaVozila_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_modeliBicikla_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_poslovnice.dart';
import 'package:rentabikewtr_desktop/screens/lista_poziviDezurnomVozilu.dart';
import 'package:rentabikewtr_desktop/screens/lista_proizvodjaciBicikla.dart';
import 'package:rentabikewtr_desktop/screens/lista_rezervniDijelovi_screen.dart';
import 'package:rentabikewtr_desktop/screens/lista_servisiranja.dart';
import 'package:rentabikewtr_desktop/screens/lista_tipoviBicikla.dart';
import 'package:rentabikewtr_desktop/screens/lista_turistRute_screen.dart';
import 'package:rentabikewtr_desktop/screens/periodicniIzvjestajRezervacije_screen.dart';
import 'package:rentabikewtr_desktop/screens/radnikPortal_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_korak1_screen.dart';
import 'package:rentabikewtr_desktop/screens/rezervacija_listaRezervacija_screen.dart';

class MenuRadnik extends StatelessWidget {
  const MenuRadnik({
    super.key,
  });

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
          child: const MenuAcceleratorLabel('&Radnik portal'),
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
                    builder: (context) => ListaBicikliScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Lista bicikla'),
            ),
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DodajBicikloScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Dodaj biciklo'),
            ),
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListaTipoviBiciklaScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Lista tipova bicikla'),
            ),
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DodajTipBiciklaScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Dodaj tip bicikla'),
            ),
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListaProizvodjaciBiciklaScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Lista proizvodjaca bicikla'),
            ),
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DodajProizvodjacaBiciklaScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Dodaj proizvodjaca bicikla'),
            ),
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListaModeliBiciklaScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Lista modela bicikla'),
            ),
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DodajModelBiciklaScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Dodaj model bicikla'),
            )
          ],
          child: const MenuAcceleratorLabel('&Bicikli'),
        ),
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListaTuristRuteScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Lista turist ruta'),
            ),
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DodajTuristRutuScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Dodaj turist rutu'),
            ),
          ],
          child: const MenuAcceleratorLabel('&Turist rute'),
        ),
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListaPoziviDezurnomVoziluScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Evidencija poziva'),
            ),
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DodajPozivDezurnomVoziluScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Pozovi dezurno vozilo'),
            ),
          ],
          child: const MenuAcceleratorLabel('&Pozivi dezurnom vozilu'),
        ),
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListaDezurnaVozilaScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Lista dezurnih vozila'),
            ),
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DodajDezurnoVoziloScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Dodaj dezurno vozilo'),
            ),
          ],
          child: const MenuAcceleratorLabel('&Dezurna vozila'),
        ),
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListaServisiranjaScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Lista servisiranja'),
            ),
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DodajServisiranjeScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Dodaj servisiranje'),
            ),
          ],
          child: const MenuAcceleratorLabel('&Servisiranja'),
        ),
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListaRezervniDijeloviScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Lista rezervnih dijelova'),
            ),
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DodajRezervniDioScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Dodaj rezervni dio'),
            ),
          ],
          child: const MenuAcceleratorLabel('&Rezervni dijelovi'),
        ),
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListaPoslovniceScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Lista poslovnica'),
            ),
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DodajPoslovnicuScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Dodaj poslovnicu'),
            ),
          ],
          child: const MenuAcceleratorLabel('&Poslovnice'),
        ),
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListaPoziviDezurnomVoziluScreen(),
                  ),
                );
              },
              child: const MenuAcceleratorLabel('Pregled najava'),
            ),
          ],
          child: const MenuAcceleratorLabel('&Najava odmora'),
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
        child: const Scaffold(body: SafeArea(child: RadnikPortalScreen())),
      ),
    );
  }
}
