import 'package:equatable/equatable.dart';

class MealEntity extends Equatable {
  final String id;
  final String title;
  final String instructions;
  final String imageUrl;
  final String videoUrl;
  final List<MapEntry<String, String>> ingredients;

  const MealEntity({
    this.id = "",
    this.title = "",
    this.instructions = "",
    this.imageUrl = "",
    this.videoUrl = "",
    this.ingredients = const [],
  });

  @override
  List<Object?> get props => [title, instructions, imageUrl, ingredients];
}
