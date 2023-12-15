import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventar_app/blocs/auth_bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.account_circle_outlined, color: Colors.white),
              SizedBox(width: 10),
              Text('Anmelden', style: TextStyle(fontSize: 20)),
            ],
          ),
          centerTitle: true,),
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.grey[200],
          child: Center(
              child: SingleChildScrollView(
                child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                const Text('Anmelden', style: TextStyle(fontSize: 30)),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.person_3_rounded, color: Colors.grey[600]),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  hintText: 'Benutzername',
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white70,
                                  filled: true),
                              controller: _usernameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Bitte geben Sie einen Benutzernamen ein.';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.key_rounded, color: Colors.grey[600]),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  hintText: 'Passwort',
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white70,
                                  filled: true),
                              controller: _passwordController,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Bitte geben Sie ein Passwort ein.';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                              /*context.read<AuthBloc>().add(
                                  AuthLoginEvent(
                                      benutzername: _usernameController.text,
                                      passwort: _passwordController.text));
                                      */
                              try {
                                BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                                  _usernameController.text,
                                  _passwordController.text));
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Benutzername oder Passwort falsch.')));
                              }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50),
                        ),
                        child: const Text('anmelden',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                )
                            ],
                          ),
              )),
        ),
      ),
    );
  }
}
