// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

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
    Response response = await get(Uri.parse('$endpoint/$id'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return Artikel.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> addArtikel(Artikel artikel) async {

    if (artikel.image != null) {
      print('artikel.image: ${artikel.image}');
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
      
      if (artikel.image != null && !isBase64(artikel.image!)) {
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

  Future<void> deleteArtikel(int artikelId) async {
    Response response = await delete(Uri.parse(endpoint + artikelId.toString()));
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

  // Konvertieren von Base64 in Image
  Future<File> convertBase64ToImage(String base64Image) async {
    try {
      final decodedBytes = base64Decode(base64Image);
      return File('path_to_image').writeAsBytes(decodedBytes);
    } catch (e) {
      print('Error convertBase64ToImage: $e');
      throw Exception(e);
    }
  }

  bool isBase64(String base64String) {
    RegExp base64 = RegExp(r'^data:image\/[a-z]+;base64,');
    return base64.hasMatch(base64String);
  }

}