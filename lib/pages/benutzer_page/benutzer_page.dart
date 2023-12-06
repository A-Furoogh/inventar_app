import 'package:flutter/material.dart';
import 'package:inventar_app/pages/benutzer_page/crud_benutzer/add_benutzer.dart';

class BenutzerPage extends StatefulWidget {
  const BenutzerPage({super.key});

  @override
  State<BenutzerPage> createState() => _BenutzerPageState();
}

class _BenutzerPageState extends State<BenutzerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Benutzer Page'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.person, size: 150, color: Colors.grey),
            const Text('Benutzer Page'),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddbenutzerPage()));
              }, 
              icon: const Icon(Icons.person_add), 
              label: const Text('Benutzer hinzufügen')),
          ],
        ),
      ),
    );
  }
}