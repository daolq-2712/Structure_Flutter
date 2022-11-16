import '../data/models/ingredient.dart';
import '../data/models/recipe.dart';
import '../data/sqlite/database_helper.dart';
import 'repository.dart';

class SqliteRepository extends Repository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
    return dbHelper.deleteIngredient(ingredient);
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    return dbHelper.deleteIngredients(ingredients);
  }

  @override
  Future<void> deleteRecipe(Recipe recipe) {
    return dbHelper.deleteRecipe(recipe);
  }

  @override
  Future<void> deleteRecipeIngredients(int recipeId) {
    return dbHelper.deleteRecipeIngredients(recipeId);
  }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    return dbHelper.findAllIngredients();
  }

  @override
  Future<List<Recipe>> findAllRecipes() {
    return dbHelper.findAllRecipes();
  }

  @override
  Future<Recipe> findRecipeById(int id) {
    return dbHelper.findRecipeById(id);
  }

  @override
  Future<List<Ingredient>> findRecipeIngredients(int recipeId) {
    return dbHelper.findRecipeIngredients(recipeId);
  }

  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    // TODO: implement insertIngredients
    throw UnimplementedError();
  }

  @override
  Future<int> insertRecipe(Recipe recipe) {
    return dbHelper.insertRecipe(recipe);
  }

  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    return dbHelper.watchAllIngredients();
  }

  @override
  Stream<List<Recipe>> watchAllRecipes() {
    return dbHelper.watchAllRecipes();
  }

  @override
  Future init() async {
    await dbHelper.database;
    return Future.value();
  }

  @override
  void close() {
    dbHelper.close();
  }
}
