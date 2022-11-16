import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  final int? id;
  final int? recipeId;
  final String? name;
  final double? weight;

  const Ingredient({this.id, this.recipeId, this.name, this.weight});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: int.parse(json["id"]),
      recipeId: json["recipeId"],
      name: json["name"],
      weight: double.parse(json["weight"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "recipeId": recipeId,
      "name": name,
      "weight": weight,
    };
  }

  @override
  List<Object?> get props => [recipeId, name, weight];
}
