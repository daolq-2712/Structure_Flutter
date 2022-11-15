import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'ingredient.dart';

//ignore: must_be_immutable
class Recipe extends Equatable {
  final String id = const Uuid().v1();
  final String? label;
  final String? image;
  final String? url;

  List<Ingredient>? ingredients;
  final double? calories;
  final double? totalWeight;
  final double? totalTime;

  Recipe({
    this.label,
    this.image,
    this.url,
    this.calories,
    this.totalWeight,
    this.totalTime,
  });

  @override
  List<Object?> get props =>
      [id, label, image, url, ingredients, calories, totalWeight, totalTime];
}
