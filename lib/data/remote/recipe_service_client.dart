import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class RecipeServiceClient {
  static const apiKey = '74a16ff11a1af0351e925e85db72a2cf';
  static const apiId = '529629a0';
  static const apiUrl = 'https://api.edamam.com/api/recipes/v2';

  static final RecipeServiceClient instance = RecipeServiceClient._();

  final Client _client;

  RecipeServiceClient._({Client? client}) : _client = client ?? Client();

  Future<String> getJsonFromUrl(String url) async {
    if (kDebugMode) {
      print('Calling url: $url');
    }

    final response = await _client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
      throw Exception('Fail to request data from server');
    }
  }
}
