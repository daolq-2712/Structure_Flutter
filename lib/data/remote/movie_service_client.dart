import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class MovieServiceClient {
  static const apiKey = '74a16ff11a1af0351e925e85db72a2cf';
  static const apiUrl = 'https://api.themoviedb.org/3/movie/';

  static final MovieServiceClient instance = MovieServiceClient._();

  final Client _client;

  MovieServiceClient._({Client? client}) : _client = client ?? Client();

  Future<Map<String, dynamic>> getJsonFromUrl(String url) async {
    if (kDebugMode) {
      print('Request url: $url');
    }

    final response =
        await _client.get(Uri.parse(url)).timeout(const Duration(seconds: 20));

    if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
    }

    if (response.statusCode == HttpStatus.ok) {
      return json.decode(response.body);
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
      throw Exception(
          'Fail to request data from server: ${response.statusCode}');
    }
  }
}
