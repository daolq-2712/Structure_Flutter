import 'package:equatable/equatable.dart';

import 'ingredient.dart';

//ignore: must_be_immutable
class Recipe extends Equatable {
  final int? id;
  final String? label;
  final String? image;
  final String? url;

  List<Ingredient>? ingredients;
  final double? calories;
  final double? totalWeight;
  final double? totalTime;

  Recipe({
    this.id,
    this.label,
    this.image,
    this.url,
    this.calories,
    this.totalWeight,
    this.totalTime,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json["recipeId"],
      label: json["label"],
      image: json["image"],
      url: json["url"],
      calories: double.parse(json["calories"]),
      totalWeight: double.parse(json["totalWeight"]),
      totalTime: double.parse(json["totalTime"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "recipeId": id,
      "label": label,
      "image": image,
      "url": url,
      "calories": calories,
      "totalWeight": totalWeight,
      "totalTime": totalTime,
    };
  }

  @override
  List<Object?> get props =>
      [id, label, image, url, ingredients, calories, totalWeight, totalTime];
}
