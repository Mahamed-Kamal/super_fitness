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
  const MealCardClickedIntent(this.meal);
}

sealed class MealsUIEvents {}

final class NavigateToMealsDetails extends MealsUIEvents {
  final MealEntity meal;
  NavigateToMealsDetails(this.meal);
}
