// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIRecipeQuery _$APIRecipeQueryFromJson(Map<String, dynamic> json) =>
    APIRecipeQuery(
      from: json['from'] as int,
      to: json['to'] as int,
      count: json['count'] as int,
      hits: (json['hits'] as List<dynamic>)
          .map((e) => APIHits.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$APIRecipeQueryToJson(APIRecipeQuery instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'count': instance.count,
      'hits': instance.hits,
    };

APIHits _$APIHitsFromJson(Map<String, dynamic> json) => APIHits(
      recipe: APIRecipe.fromJson(json['recipe'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$APIHitsToJson(APIHits instance) => <String, dynamic>{
      'recipe': instance.recipe,
    };

APIRecipe _$APIRecipeFromJson(Map<String, dynamic> json) => APIRecipe(
      uri: json['uri'] as String,
      label: json['label'] as String,
      image: json['image'] as String,
      source: json['source'] as String,
      url: json['url'] as String,
      shareAs: json['shareAs'] as String,
      yield: (json['yield'] as num).toDouble(),
      dietLabels: (json['dietLabels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      healthLabels: (json['healthLabels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      cautions:
          (json['cautions'] as List<dynamic>).map((e) => e as String).toList(),
      ingredientLines: (json['ingredientLines'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => APIIngredients.fromJson(e as Map<String, dynamic>))
          .toList(),
      calories: (json['calories'] as num).toDouble(),
      totalWeight: (json['totalWeight'] as num).toDouble(),
      totalTime: (json['totalTime'] as num).toDouble(),
    );

Map<String, dynamic> _$APIRecipeToJson(APIRecipe instance) => <String, dynamic>{
      'uri': instance.uri,
      'label': instance.label,
      'image': instance.image,
      'source': instance.source,
      'url': instance.url,
      'shareAs': instance.shareAs,
      'yield': instance.yield,
      'dietLabels': instance.dietLabels,
      'healthLabels': instance.healthLabels,
      'cautions': instance.cautions,
      'ingredientLines': instance.ingredientLines,
      'ingredients': instance.ingredients,
      'calories': instance.calories,
      'totalWeight': instance.totalWeight,
      'totalTime': instance.totalTime,
    };

APIIngredients _$APIIngredientsFromJson(Map<String, dynamic> json) =>
    APIIngredients(
      json['text'] as String,
      (json['weight'] as num).toDouble(),
    );

Map<String, dynamic> _$APIIngredientsToJson(APIIngredients instance) =>
    <String, dynamic>{
      'text': instance.text,
      'weight': instance.weight,
    };
