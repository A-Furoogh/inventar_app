import 'package:flutter/material.dart';

class ProtokollPage extends StatefulWidget {
  const ProtokollPage({super.key});

  @override
  State<ProtokollPage> createState() => _ProtokollPageState();
}

class _ProtokollPageState extends State<ProtokollPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Protokoll'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.document_scanner, size: 150, color: Colors.grey),
            Text('Protokolle'),
          ],
        ),
      ),
    );
  }
}
