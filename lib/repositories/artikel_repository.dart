// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:inventar_app/models/artikel.dart';
import 'package:inventar_app/repositories/authorization_repository.dart';

class ArtikelRepository {
  String productEndpoint = "https://reimedia.de/shop/dev/public/api/product";
  String taxEndpoint = "https://reimedia.de/shop/dev/public/api/tax";

  Future<List<Artikel>> getArtikels() async {
    try {
      String token = await AuthorizationRepository.getBearerToken();
      print('Received Token: $token');

    Response productResponse = await get(Uri.parse(productEndpoint), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    Response mediaResponse = await get(Uri.parse("$productEndpoint-media"), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
      });

    if (productResponse.statusCode == 200) {
      final Map<String, dynamic> productResult = jsonDecode(productResponse.body);
      final Map<String, dynamic> mediaResult = jsonDecode(mediaResponse.body);
      

      if (productResult.containsKey('data') && mediaResult.containsKey('data')) {
        final dynamic productData = productResult['data'];
        final dynamic mediaData = mediaResult['data'];

        if (productData is List) {
          List<Artikel> artikels = [];
          for (dynamic json in productData) {
            
            String? imageUrl = () {
              if ( mediaData is List && mediaData.isNotEmpty) {
                for (dynamic media in mediaData) {
                  if (media['productId'] == json['id']) {
                    return media['media']['url'] as String?;
                  }
                }
              } else if (mediaData is Map && mediaData.containsKey('media') && mediaData['media'] is Map) {
                // Handle the case when data is not a list but a map
                print(mediaData['media']['url']);
                return mediaData['media']['url'] as String?;
              } // else return null
              else {
                return '';
              }
            }();
            
            Artikel artikel = Artikel.fromJson(json);
            artikel.image = imageUrl;

            artikels.add(artikel);
          }

          return artikels;
        } else if (productData is Map<String, dynamic>) {
          return [Artikel.fromJson(productData)];
        } else {
          throw Exception('Ungültige Datenstruktur: $productData');
        }
      } else {
        throw Exception('Es wurden keine ''--> Daten <--'' gefunden');
      }
    }
    else {
      throw Exception(productResponse.reasonPhrase);
    }
    } catch (e) {
      throw Exception("gescheitert um Artikels zu bekommen: $e");
    }
  }

  Future<Artikel> getArtikel(String id) async {
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
    /*if (artikel.image != null) {
      artikel.image = await convertImageToBase64(artikel.image!);
    }*/
    String token = await AuthorizationRepository.getBearerToken();

    Response taxResponse = await get(Uri.parse(taxEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        );
    if (taxResponse.statusCode != 200) {
      throw Exception(taxResponse.reasonPhrase);
    } else {
      dynamic result = jsonDecode(taxResponse.body);
      String standardTaxId = result['data'][1]['id'];
      print('Standard Tax ID: $standardTaxId');

      Response productResponse = await post(Uri.parse(productEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(artikel.toJson(taxId: standardTaxId)),
        );
        //print(productResponse.body);
        //print(artikel.toJson(taxId: standardTaxId));
      if (productResponse.statusCode != 204) {
        print(productResponse.body);
        throw Exception(productResponse.reasonPhrase);
      }
    }
  }

  Future<void> updateArtikel(Artikel artikel) async {
    //if (artikel.image != null) {
      // Wird geprüft, ob das Bild bereits in Base64 konvertiert wurde
    //  if (artikel.image!.length < 1000) {
    //    artikel.image = await convertImageToBase64(artikel.image!);
    //  }
    //}
    String token = await AuthorizationRepository.getBearerToken();
    Response response = await patch(Uri.parse('$productEndpoint/${artikel.artikelId}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(artikel.toJson()));
    if (response.statusCode != 204) {
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> deleteArtikel(Artikel artikel) async {
    String token = await AuthorizationRepository.getBearerToken();
    Response response = await delete(Uri.parse('$productEndpoint/${artikel.artikelId}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        );
    if (response.statusCode != 204) {
      print(response.body);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Artikel>> getLagerArtikels(String lagerId) {
    List<Artikel> lagerArtikels = [];
    return getArtikels().then((artikel) {
      for (Artikel a in artikel) {
        if ((a.lagerplatzId?.toLowerCase() ?? '').contains(lagerId.toLowerCase())) {
          lagerArtikels.add(a);
        }
      }
      return lagerArtikels;
    });
  }

  
  List<Artikel> filterArtikel(List<Artikel> allArtikel, String searchQuery) {
    final lowerSearchQuery = searchQuery.toLowerCase();
  return allArtikel.where((artikel) =>
    (artikel.bezeichnung?.toLowerCase() ?? '').contains(lowerSearchQuery) ||
    (artikel.ean?.toLowerCase() ?? '').contains(lowerSearchQuery) ||
    (artikel.artikelId?.toLowerCase() ?? '').contains(lowerSearchQuery)
  ).toList();
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
