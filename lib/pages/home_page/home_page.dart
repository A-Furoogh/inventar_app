import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:inventar_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:inventar_app/pages/Konto_page/konto_page.dart';
import 'package:inventar_app/pages/artikel/artikel_page.dart';
import 'package:inventar_app/pages/home_page/fields_tile.dart';
import 'package:inventar_app/pages/lager_page/lager_page.dart';
import 'package:inventar_app/pages/protokoll_page/protokoll_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page'), centerTitle: true, actions: <Widget>[PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'logout') {
                        context.read<AuthBloc>().add(const LogoutEvent());
                      }
                    },
                    itemBuilder: (context) {
                      return <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'logout',
                          child: Text('Abmelden'),
                        )
                      ];
                    },
                    icon: const Icon(Icons.logout_outlined))
                    ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 209, 235, 212),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Willkommen ${context.read<AuthBloc>().state.benutzer.benutzername}', style: const TextStyle(fontSize: 30)),
                ),
                // Oder watch statt read verwenden für automatisches rebuild
                // Text('Willkommen ${context.watch<AuthBloc>().state.benutzer.benutzername}', style: const TextStyle(fontSize: 20)),
                Visibility(
                  visible: context.read<AuthBloc>().state.benutzer.benutzername == 'admin',
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton( // Renderoverflow Error hier
                      onPressed: () {
                        Phoenix.rebirth(context);
                      },
                      child: const Text('Restart App'),
                            ),
                  ),
                ),
            Column(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FieldWidget(image: "assets/images/lager.png", name: "Lager", onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LagerPage()));
                      },),
                      FieldWidget(image: "assets/images/artikel.png", name: "Artikel", onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ArtikelPage()));
                      },),
                    ],
                  ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FieldWidget(image: "assets/images/protokoll.png", name: "Protokoll", onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProtokollPage()));
                        },),
                        FieldWidget(image: "assets/images/konto.png", name: "Konto", onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const KontoPage()));
                        },),
                      ],
                    ))
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Text('Reimedia GmbH',
                      style: TextStyle(fontSize: 18)),
                  Text('Amtsstr. 25a, 59073 Hamm'),
                ],
              ),
            ),
            ]
                  ),
          ),
          ),
      ));
  }
}