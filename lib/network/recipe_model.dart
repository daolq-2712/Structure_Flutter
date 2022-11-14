import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class APIRecipeQuery {
  @JsonKey(name: 'q')
  String query;
  int from;
  int to;
  bool more;
  int count;
  List<APIHits> hits;

  APIRecipeQuery({
    required this.query,
    required this.from,
    required this.to,
    required this.more,
    required this.count,
    required this.hits,
  });

  factory APIRecipeQuery.fromJson(Map<String, dynamic> json) {
    return _$APIRecipeQueryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$APIRecipeQueryToJson(this);
  }
}

@JsonSerializable()
class APIHits {
  APIRecipe recipe;

  APIHits({required this.recipe});

  factory APIHits.fromJson(Map<String, dynamic> json) {
    return _$APIHitsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$APIHitsToJson(this);
  }
}

@JsonSerializable()
class APIRecipe {
  String uri;
  String label;
  String image;
  String source;
  String url;
  String shareAs;
  double yield;
  List<String> dietLabels;
  List<String> healthLabels;
  List<String> cautions;
  List<String> ingredientLines;
  List<APIIngredients> ingredients;
  double calories;
  double totalWeight;
  double totalTime;

  APIRecipe({
    required this.uri,
    required this.label,
    required this.image,
    required this.source,
    required this.url,
    required this.shareAs,
    required this.yield,
    required this.dietLabels,
    required this.healthLabels,
    required this.cautions,
    required this.ingredientLines,
    required this.ingredients,
    required this.calories,
    required this.totalWeight,
    required this.totalTime,
  });

  factory APIRecipe.fromJson(Map<String, dynamic> json) {
    return _$APIRecipeFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$APIRecipeToJson(this);
  }

  String getCalories(double? calories) {
    if (calories == null) {
      return '0 KCAL';
    }
    return '${calories.floor()} KCAL';
  }
}

@JsonSerializable()
class APIIngredients {
  String text;
  double weight;

  APIIngredients(
    this.text,
    this.weight,
  );

  factory APIIngredients.fromJson(Map<String, dynamic> json) {
    return _$APIIngredientsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$APIIngredientsToJson(this);
  }
}
