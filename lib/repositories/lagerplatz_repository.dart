import 'dart:convert';

import 'package:http/http.dart';
import 'package:inventar_app/models/lagerplatz.dart';

class LagerplatzRepository {

  String endpoint = "https://api.komiku.id/v1/";

  Future<List<Lagerplatz>> getLagerplaetze() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => Lagerplatz.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Lagerplatz> getLagerplatz(int id) async {
    Response response = await get(Uri.parse(endpoint + id.toString()));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return Lagerplatz.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> addLagerplatz(Lagerplatz lagerplatz) async {
    Response response = await post(Uri.parse(endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(lagerplatz.toJson()));
    if (response.statusCode != 201) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> updateLagerplatz(Lagerplatz lagerplatz) async {
    Response response = await put(Uri.parse(endpoint + lagerplatz.platzId.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(lagerplatz.toJson()));
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> deleteLagerplatz(int id) async {
    Response response = await delete(Uri.parse(endpoint + id.toString()));
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }
}