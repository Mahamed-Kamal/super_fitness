import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';

sealed class MealsIntent {
  const MealsIntent();
}

final class GetMealsCategoriesIntent extends MealsIntent {
  const GetMealsCategoriesIntent();
}

final class SelectMealCategoryIntent extends MealsIntent {
  final int selectedIndex;

  const SelectMealCategoryIntent(this.selectedIndex);
}

final class GetMealsByCategoryIntent extends MealsIntent {
  const GetMealsByCategoryIntent();
}

final class MealCardClickedIntent extends MealsIntent {
  final MealEntity meal;
  final List<MealEntity> meals;

  const MealCardClickedIntent(this.meal, this.meals);
}

sealed class MealsUIEvents {}

final class NavigateToMealsDetails extends MealsUIEvents {
  final MealEntity meal;
  final List<MealEntity> meals;

  NavigateToMealsDetails(this.meal, this.meals);
}
