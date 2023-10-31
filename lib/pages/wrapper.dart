import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventar_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:inventar_app/pages/home_page/home_page.dart';
import 'package:inventar_app/pages/login_page/login_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return const HomePage();
        } else if (state is UnauthenticatedState) {
          return const LoginPage();
        } else if (state is AuthLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const LoginPage();
        }
      },
    );
  }
}