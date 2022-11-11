import 'package:chopper/chopper.dart';
import 'package:structureflutter/network/model_response.dart';

import 'recipe_model.dart';

abstract class RecipeService extends ChopperService {

  Future<Response<Result<APIRecipeQuery>>> queryRecipes(@Query('q')String query,@Query('from') int from,@Query('to') int to);
}
