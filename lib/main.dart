import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:inventar_app/pages/wrapper.dart';

void main() {
  runApp(Phoenix(child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Wrapper(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      themeMode: ThemeMode.system,
    );
  }
}

// Phoenix.restartApp(context);
