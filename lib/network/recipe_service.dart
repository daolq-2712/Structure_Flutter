import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../env/debug_env.dart';

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
        '${DebugEnv.API_URL}?app_id=${DebugEnv.API_ID}&app_key=${DebugEnv.API_KEY}&q=$query&from=$from&to=$to');
    // 3
    return recipeData;
  }
}
