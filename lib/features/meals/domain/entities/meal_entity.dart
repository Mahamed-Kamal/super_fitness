class MealEntity {
  final String title;
  final String instructions;
  final String image;
  final List<MapEntry<String, String>> ingredients;

  MealEntity({
    this.title = "",
    this.instructions = "",
    this.image = "",
    this.ingredients = const [],
  });
}
