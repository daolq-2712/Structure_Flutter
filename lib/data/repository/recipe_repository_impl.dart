import 'dart:convert';

import '/data/remote/recipe_service_client.dart';
import '../remote/response/recipe_model.dart';
import '../recipe_repository.dart';

class RecipeRepositoryImpl extends RecipeRepository {
  static final RecipeRepositoryImpl instance =
      RecipeRepositoryImpl._(client: RecipeServiceClient.instance);

  final RecipeServiceClient _client;

  RecipeRepositoryImpl._({required RecipeServiceClient client})
      : _client = client;

  @override
  void getRecipeDetails() {
    // TODO: implement getRecipeDetails
  }

  @override
  Future<APIRecipeQuery> getSearchRecipe(
      String query, int fromIndex, int toIndex) async {
    final jsonResponse = await _client.getJsonFromUrl(
        '${RecipeServiceClient.apiUrl}?app_id=${RecipeServiceClient.apiId}&app_key=${RecipeServiceClient.apiKey}&type=any&q=$query&from=$fromIndex&to=$toIndex');
    return APIRecipeQuery.fromJson(json.decode(jsonResponse));
  }
}
