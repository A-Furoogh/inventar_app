import 'package:flutter/material.dart';
import 'package:inventar_app/pages/home_page/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Row(
        children: [
          Icon(Icons.account_circle_outlined, color: Colors.white),
          SizedBox(width: 10),
          Text('Anmelden', style: TextStyle(fontSize: 20)),
        ],
      ), centerTitle: true),
      body: Container(
        color: Colors.grey[200],
        child: Center(
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
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                        // Hier muss auch die SharedPreferences gesetzt werden.
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                    child:
                        const Text('anmelden', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
