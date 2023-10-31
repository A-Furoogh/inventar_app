import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Home Page'),
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