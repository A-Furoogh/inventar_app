import 'package:flutter/material.dart';
import 'package:inventar_app/pages/konto_page/crud_benutzer/add_benutzer.dart';

class KontoPage extends StatefulWidget {
  const KontoPage({super.key});

  @override
  State<KontoPage> createState() => _KontoPageState();
}

class _KontoPageState extends State<KontoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konto Page'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.person, size: 150, color: Colors.grey),
            const Text('Konto Page'),
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