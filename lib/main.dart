import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:inventar_app/blocs/artikel_bloc/artikel_bloc.dart';
import 'package:inventar_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:inventar_app/blocs/benutzer_bloc/benutzer_bloc.dart';
import 'package:inventar_app/pages/wrapper.dart';
import 'package:inventar_app/repositories/artikel_repository.dart';
import 'package:inventar_app/repositories/benutzer_repository.dart';

// bad certificate error fix! (only for testing)
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
  }
}


void main() {
  // bad certificate error fix! (only for testing)
  HttpOverrides.global = MyHttpOverrides();

  runApp(Phoenix(child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(BenutzerRepository())),
        BlocProvider(create: (context) => ArtikelBloc(ArtikelRepository())),
        BlocProvider(create: (context) => BenutzerBloc(BenutzerRepository())),
      ],
      child: const MyApp())));
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
