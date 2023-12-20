import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventar_app/blocs/benutzer_bloc/benutzer_bloc.dart';
import 'package:inventar_app/models/benutzer.dart';

class AddbenutzerPage extends StatefulWidget {
  const AddbenutzerPage({super.key});

  @override
  State<AddbenutzerPage> createState() => _AddbenutzerPageState();
}

class _AddbenutzerPageState extends State<AddbenutzerPage> {
  final TextEditingController _benutzernameController = TextEditingController();
  final TextEditingController _passwortController = TextEditingController();
  final TextEditingController _passwortWiederholenController = TextEditingController();
  final TextEditingController _rollenController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _rollenController.text = 'admin';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Neuer Benutzer'), centerTitle: true),
      body: BlocBuilder<BenutzerBloc, BenutzerState>(
        builder: (context, state) {
          if (state is BenutzerLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.person_add_rounded,
                          size: 150, color: Colors.green[400]),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Benutzername',
                        ),
                        controller: _benutzernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Bitte geben Sie einen Benutzernamen ein';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Passwort',
                        ),
                        obscureText: true,
                        controller: _passwortController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Bitte geben Sie ein Passwort ein';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Passwort wiederholen',
                        ),
                        obscureText: true,
                        controller: _passwortWiederholenController,
                        validator: (value) {
                          if (value != _passwortController.text) {
                            return 'Passwörter stimmen nicht überein';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text('Rolle:', style: TextStyle(fontSize: 20)),
                          const SizedBox(width: 20),
                          DropdownButton(
                            items: const [
                              DropdownMenuItem(
                                  value: 'admin', child: Text('Admin')),
                              DropdownMenuItem(
                                  value: 'product manager',
                                  child: Text('Produkt manager')),
                              DropdownMenuItem(
                                  value: 'logistics manager',
                                  child: Text('Logistik manager')),
                              DropdownMenuItem(
                                  value: 'controller',
                                  child: Text('Kontrolleur')),
                            ],
                            value: _rollenController.text.isEmpty
                                ? 'admin'
                                : _rollenController.text,
                            onChanged: (value) {
                              setState(() {
                                _rollenController.text = value.toString();
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Add the new benutzer to the database through BenuzterBloc
                              try {
                                context.read<BenutzerBloc>()
                                    .add(AddbenutzerEvent(Benutzer(
                                  benutzername: _benutzernameController.text,
                                  passwort: _passwortController.text,
                                  rolle: _rollenController.text,
                                )));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.green[300],
                                      content: const Text(
                                          'Benutzer erfolgreich hinzugefügt', style: TextStyle(color: Colors.black))));
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())));
                              }
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(Icons.person_add),
                          label: const Text('Benutzer hinzufügen')),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
