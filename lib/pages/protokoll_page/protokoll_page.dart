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
        title: Text('Protokoll'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text(' Alle Protokolle werden hier angezeigt'),
      ),
    );
  }
}
