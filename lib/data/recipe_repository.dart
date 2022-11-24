import 'remote/response/recipe_model.dart';

abstract class RecipeRepository {
  Future<APIRecipeQuery> getSearchRecipe(String query, int fromIndex, int toIndex);

  void getRecipeDetails();
}
