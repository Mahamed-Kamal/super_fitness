import 'package:super_fitness/features/meals/api/models/responses/meal_dto.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';

extension MealDetailsMapper on MealDto {
  MealEntity toMealEntity() => MealEntity(
    title: strMeal ?? "",
    instructions: strInstructions ?? "",
    imageUrl: strMealThumb ?? "",
    videoUrl: strYoutube ?? "",
    ingredients: [
      MapEntry(strIngredient1 ?? "", strMeasure1 ?? ""),
      MapEntry(strIngredient2 ?? "", strMeasure2 ?? ""),
      MapEntry(strIngredient3 ?? "", strMeasure3 ?? ""),
      MapEntry(strIngredient4 ?? "", strMeasure4 ?? ""),
      MapEntry(strIngredient5 ?? "", strMeasure5 ?? ""),
      MapEntry(strIngredient6 ?? "", strMeasure6 ?? ""),
      MapEntry(strIngredient7 ?? "", strMeasure7 ?? ""),
      MapEntry(strIngredient8 ?? "", strMeasure8 ?? ""),
      MapEntry(strIngredient9 ?? "", strMeasure9 ?? ""),
      MapEntry(strIngredient10 ?? "", strMeasure10 ?? ""),
      MapEntry(strIngredient11 ?? "", strMeasure11 ?? ""),
      MapEntry(strIngredient12 ?? "", strMeasure12 ?? ""),
      MapEntry(strIngredient13 ?? "", strMeasure13 ?? ""),
      MapEntry(strIngredient14 ?? "", strMeasure14 ?? ""),
      MapEntry(strIngredient15 ?? "", strMeasure15 ?? ""),
      MapEntry(strIngredient16 ?? "", strMeasure16 ?? ""),
      MapEntry(strIngredient17 ?? "", strMeasure17 ?? ""),
      MapEntry(strIngredient18 ?? "", strMeasure18 ?? ""),
      MapEntry(strIngredient19 ?? "", strMeasure19 ?? ""),
      MapEntry(strIngredient20 ?? "", strMeasure20 ?? ""),
    ],
  );
}
