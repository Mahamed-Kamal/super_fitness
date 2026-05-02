import 'package:equatable/equatable.dart';

class MealEntity extends Equatable {
  final String title;
  final String instructions;
  final String image;
  final List<MapEntry<String, String>> ingredients;

  const MealEntity({
    this.title = "",
    this.instructions = "",
    this.image = "",
    this.ingredients = const [],
  });

  @override
  List<Object?> get props => [title, instructions, image, ingredients];
}
