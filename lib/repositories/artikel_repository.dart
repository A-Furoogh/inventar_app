// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart';
import 'package:inventar_app/models/artikel.dart';
import 'package:inventar_app/repositories/authorization_repository.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

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
      // Ausgabe der Response
      String locationHeader = productResponse.headers['location'].toString();
      print('locationHeader: $locationHeader');
       // Extrahieren der Artikel ID aus dem Location Header
      String articleId = Uri.parse(locationHeader).pathSegments.last;
      print('Article ID: $articleId');
      // Füge das hochgeladenes Bild zu einem Artikel hinzu
      if (artikel.image != null) {
        String mediaId =  await addImageIntoNewMedia(artikel.image!);
        print('mediaId: $mediaId');
        await relateImageToArtikel(articleId, mediaId);
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
    } else {
      if (artikel.image != null) {
        // Erst löschen wir das alte Bild   !!! Achtung: Alle alte Bilder von dem Artikel werden gelöscht !!!
        Response mediaResponse = await get(Uri.parse("$productEndpoint/${artikel.artikelId}/media"), headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
        if (mediaResponse.statusCode == 200) {
          final Map<String, dynamic> mediaResult = jsonDecode(mediaResponse.body);
          if (mediaResult.containsKey('data')) {
            final dynamic mediaData = mediaResult['data'];
            if (mediaData is List && mediaData.isNotEmpty) {
              for (dynamic media in mediaData) {
                String mediaId = media['id'];
                Response deleteMediaResponse = await delete(Uri.parse("$productEndpoint/${artikel.artikelId}/media/$mediaId"), headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $token'
                });
                if (deleteMediaResponse.statusCode != 204) {
                  print(deleteMediaResponse.body);
                  throw Exception(deleteMediaResponse.reasonPhrase);
                }
              }
            }
          }
        }
        // Dann fügen wir das neue Bild hinzu
        String mediaId = await addImageIntoNewMedia(artikel.image!);
        await relateImageToArtikel(artikel.artikelId!, mediaId);
      }
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

  
  Future<String> addImageIntoNewMedia(String imageFile)  async {
    try {
      String token = await AuthorizationRepository.getBearerToken();
      String mediaEndpoint = "https://reimedia.de/shop/dev/public/api/media/";
      String mediaFolderId = "356827fb06954540bd85f3db61f3dc2a";           // Die Id des Ornders, wo das Bild gespeichert wird.
      String imageExtension = path.basename(imageFile).split('.')[1]; // nehmt die Dateiendung 
      String imageName = path.basename(imageFile).split('.')[0];      // nehmt den Dateinamen ohne Endung
      String mediaId = const Uuid().v4().replaceAll('-', '');                                   // generiert eine zufällige Id für das Bild
      print('imageExtension-> $imageExtension  imagename-> $imageName mediaId-> $mediaId');
      Response mediaResponse = await post(Uri.parse(mediaEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
          {
            "id": mediaId,
            "mediaFolderId": mediaFolderId,
          }
        ),);
      if (mediaResponse.statusCode != 204) {
        print(mediaResponse.body);
        throw Exception(mediaResponse.reasonPhrase);
      }
      else {
        String mediaEndpoint = "https://reimedia.de/shop/dev/public/api/_action/media/"; // _action fehlte
        List<int> imageBytes = await File(imageFile).readAsBytes();
        Response mediaUploadResponse = await post(Uri.parse("$mediaEndpoint$mediaId/upload?extension=$imageExtension&fileName=$imageName"),
        headers: <String, String>{
          'Content-Type': 'image/$imageExtension',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: imageBytes,
            //"file": imageFile,
        );
      if (mediaUploadResponse.statusCode != 204) {
        print(mediaUploadResponse.body);
        throw Exception(mediaUploadResponse.reasonPhrase);
      } else {
        return mediaId;
      }
    }
  }
  catch (e) {
    print('Error  from addImageIntoNewMedia(): $e');
    throw Exception(e);
  }
  }

  // Füge das hochgeladenes Bild zu einem Artikel hinzu
  Future<void> relateImageToArtikel(String artikelId, String mediaId) async {
    try {
      String token = await AuthorizationRepository.getBearerToken();
      String mediaEndpoint = "https://reimedia.de/shop/dev/public/api/product/$artikelId/media";
      Response mediaResponse = await post(Uri.parse(mediaEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
          {
            "mediaId": mediaId,
            "position": 0,
            "cover": true,
          }
        ),);
      if (mediaResponse.statusCode != 204) {
        print(mediaResponse.body);
        throw Exception(mediaResponse.reasonPhrase);
      }
    }
    catch (e) {
      print('Error  aus relateImageToArtikel(): $e');
      throw Exception(e);
    }
  }

 // Lösche das erste Bild von einem Artikel
  Future<void> deleteImageFromArtikel(String artikelId) async {
    try {
      String token = await AuthorizationRepository.getBearerToken();
      String mediaEndpoint = "https://reimedia.de/shop/dev/public/api/product/$artikelId/media";
      Response mediaResponse = await get(Uri.parse(mediaEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        );
      if (mediaResponse.statusCode == 200) {
        final Map<String, dynamic> mediaResult = jsonDecode(mediaResponse.body);
        if (mediaResult.containsKey('data')) {
          final dynamic mediaData = mediaResult['data'];
          if (mediaData is List && mediaData.isNotEmpty) {
            String mediaId = mediaData[0]['id'];
            Response deleteMediaResponse = await delete(Uri.parse("$mediaEndpoint/$mediaId"), headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            });
            if (deleteMediaResponse.statusCode != 204) {
              print(deleteMediaResponse.body);
              throw Exception(deleteMediaResponse.reasonPhrase);
            }
          }
        }
      }
    }
    catch (e) {
      print('Error  aus deleteImageFromArtikel(): $e');
      throw Exception(e);
    }
  }

  String generateRandomHex(int length) {
  final random = Random();
  const chars = '0123456789ABCDEF';

  String result = '';
  for (int i = 0; i < length; i++) {
    result += chars[random.nextInt(16)];
  }

  return result;
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
