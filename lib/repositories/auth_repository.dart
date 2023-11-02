// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart';
import 'package:inventar_app/models/benutzer.dart';

class AuthRepository {

  // Endpoint für die Authentifizierung
  final String endpoint = 'http://192.168.178.22/myproject/mybenutzerapi.php';


  Future<bool> signUp(String benutzername, String passwort) async {
    Map<String, dynamic> body = {
      'benutzername': benutzername,
      'passwort': passwort,
    };
    try {
      Response response = await post(Uri.parse(endpoint),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(body));
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Benutzer>> getBenutzer() async {
    try {
      Response response = await get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body);
        print(result);
        return result.map((e) => Benutzer.fromJson(e)).toList();
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // login durch Benutzername und Passwort und vergleiche mit der Datenbank und falls erfolgreich, dann rückgabe des Benutzers
  Future<Benutzer> login(String benutzername, String password) async {
    var benutzer = await getBenutzer();
    var user = benutzer.firstWhere(
      (element) =>
          element.benutzername == benutzername && element.passwort == password,
      orElse: () => throw Exception('Benutzername oder Passwort ist falsch'),
    );

    return Future.value(user);
  }

  // logout
  Future<void> logout() async {
    return Future.value();
  }
}
