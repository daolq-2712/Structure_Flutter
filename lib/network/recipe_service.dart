import 'package:chopper/chopper.dart';

import '../env/debug_env.dart';
import '../network/model_response.dart';
import '../network/model_converter.dart';
import 'recipe_model.dart';

part 'recipe_service.chopper.dart';

@ChopperApi(baseUrl: DebugEnv.API_URL)
abstract class RecipeService extends ChopperService {
  @Get(path: '/search')
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
      @Query('q') String query, @Query('from') int from, @Query('to') int to);

  static RecipeService create() {
    final client = ChopperClient(
      baseUrl: DebugEnv.API_URL,
      interceptors: [_addQuery, HttpLoggingInterceptor()],
      converter: ModelConverter(),
      errorConverter: const JsonConverter(),
      services: [_$RecipeService()],
    );
    return _$RecipeService(client);
  }
}

Request _addQuery(Request req) {
  final params = Map<String, dynamic>.from(req.parameters);
  params['app_id'] = DebugEnv.API_ID;
  params['app_key'] = DebugEnv.API_KEY;
  return req.copyWith(parameters: params);
}
