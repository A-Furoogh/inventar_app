// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:inventar_app/models/artikel.dart';

class ArtikelRepository {
  String endpoint = "https://ahmad-furoogh.de.cool/myArtikelApi.php";

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
    await getArtikels().then((artikel) {
      for (Artikel a in artikel) {
        if (a.artikelId == id) {
          return a;
        }
      }
    });
    throw Exception("Artikel mit der ID $id nicht gefunden");
  }

  Future<void> addArtikel(Artikel artikel) async {
    if (artikel.image != null) {
      artikel.image = await convertImageToBase64(artikel.image!);
    }

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
    if (artikel.image != null) {
      artikel.image = await convertImageToBase64(artikel.image!);
    }

    Response response = await put(Uri.parse(endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(artikel.toJson()));
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> deleteArtikel(Artikel artikel) async {
    Response response = await delete(Uri.parse(endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(artikel.toJson()));
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Artikel>> searchArtikel(String search) {
    List<Artikel> searchedArtikel = [];
    return getArtikels().then((artikel) {
      for (Artikel a in artikel) {
        if (a.bezeichnung.toLowerCase().contains(search.toLowerCase()) ||
            a.artikelId.toString().contains(search)) {
          searchedArtikel.add(a);
        }
      }
      return searchedArtikel;
    });
  }

  // Konvertieren von Image in Base64
  Future<String> convertImageToBase64(String imagePath) async {
    try {
      final bytes = await File(imagePath).readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      print('Error convertImageToBase64: $e');
      throw Exception(e);
    }
  }
}
