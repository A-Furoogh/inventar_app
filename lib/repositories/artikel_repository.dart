import 'dart:convert';

import 'package:http/http.dart';
import 'package:inventar_app/models/artikel.dart';

class ArtikelRepository {

  String endpoint = "http://192.168.178.22/myproject/myartikelapi.php";

  Future<List<Artikel>> getArtikels() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => Artikel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Artikel> getArtikel(int id) async {
    Response response = await get(Uri.parse(endpoint + id.toString()));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return Artikel.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> addArtikel(Artikel artikel) async {
    Response response = await post(Uri.parse(endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(artikel.toJson()));
    if (response.statusCode != 201) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> updateArtikel(Artikel artikel) async {
    Response response = await put(Uri.parse(endpoint + artikel.artikelId.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(artikel.toJson()));
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> deleteArtikel(int id) async {
    Response response = await delete(Uri.parse(endpoint + id.toString()));
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Artikel>> searchArtikel(String search) {
    List<Artikel> searchedArtikel = [];
    return getArtikels().then((artikel) {
      for (Artikel a in artikel) {
        if (a.bezeichnung.toLowerCase().contains(search.toLowerCase()) || a.artikelId.toString().contains(search)) {
          searchedArtikel.add(a);
        }
      }
      return searchedArtikel;
    });
  }
}