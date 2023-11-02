import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:inventar_app/blocs/auth_bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
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
        )]
      ),
    ));
  }
}