import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:inventar_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:inventar_app/pages/home_page/fields_tile.dart';

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
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 20),
              Text('Willkommen ${context.read<AuthBloc>().state.benutzer.benutzername}', style: const TextStyle(fontSize: 30)),
              // Oder watch statt read verwenden für automatisches rebuild
              // Text('Willkommen ${context.watch<AuthBloc>().state.benutzer.benutzername}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Phoenix.rebirth(context);
                },
                child: const Text('Restart App'),
          ),
          const SizedBox(
            height: 500,
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Row(
                    children: [
                      FieldWidget(image: "assets/images/lager.png", name: "Lager"),
                      FieldWidget(image: "assets/images/artikel.png", name: "Artikel"),
                    ],
                  ),
                  ),
                  Center(
                    child: Row(
                      children: [
                        FieldWidget(image: "assets/images/protokoll.png", name: "Protokoll"),
                        FieldWidget(image: "assets/images/konto.png", name: "Konto"),
                      ],
                    ))
              ],
            ),
          )
          ]
        ),
          ),
      ));
  }
}