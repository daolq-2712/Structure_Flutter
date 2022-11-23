import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

const API_KEY = '2f9b69f9f2a5fb16a394b3d2b7d78ada';
const API_ID = '63349974';
const API_URL = 'https://api.edamam.com/api/recipes/v2';

class RecipeService {
  // 1
  Future _getData(String url) async {
    // 2
    if (kDebugMode) {
      print('Calling url: $url');
    }
    // 3
    final response = await get(Uri.parse(url));
    // 4
    if (response.statusCode == 200) {
      // 5
      return response.body;
    } else {
      // 6
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }

  // 1
  Future<dynamic> getRecipes(String query, int from, int to) async {
// 2
    final recipeData = await _getData(
        '$API_URL?app_id=$API_ID&app_key=$API_KEY&q=$query&from=$from&to=$to');
    // 3
    return recipeData;
  }
}
