import 'dart:convert';

import 'package:http/http.dart';

abstract class AuthorizationRepository {


  static Future<String> getBearerToken() async {
  const String tokenEndpoint = "https://reimedia.de/shop/dev/public/api/oauth/token";
  final Map<String, String> credentials = {
    "grant_type": "client_credentials",
    "client_id": "SWUARNAWDWXVBVE5WXBYWJBJYG",
    "client_secret": "cU5CdXFqUFVUQ3U5MWVBakpHQldRZlJSelRDRkZaZXJWR1BCc08"
  };

  Response response = await post(Uri.parse(tokenEndpoint), body: credentials);
  
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data['access_token'];
  } else {
    throw Exception("Failed to obtain bearer token: ${response.reasonPhrase}");
  }
}

}