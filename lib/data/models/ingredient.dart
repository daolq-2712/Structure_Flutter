import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  final int? id;
  final int? recipeId;
  final String? name;
  final double? weight;

  const Ingredient({this.id, this.recipeId, this.name, this.weight});

  @override
  List<Object?> get props => [recipeId, name, weight];
}
