import 'package:flutter/material.dart';

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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.person, size: 150, color: Colors.grey),
            Text('Konto Page'),
          ],
        ),
      ),
    );
  }
}