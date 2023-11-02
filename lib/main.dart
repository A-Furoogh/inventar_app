import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:inventar_app/blocs/artikel_bloc/artikel_bloc.dart';
import 'package:inventar_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:inventar_app/pages/wrapper.dart';
import 'package:inventar_app/repositories/artikel_repository.dart';
import 'package:inventar_app/repositories/auth_repository.dart';

void main() {
  runApp(Phoenix(child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthRepository())),
        BlocProvider(create: (context) => ArtikelBloc(ArtikelRepository())),
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
