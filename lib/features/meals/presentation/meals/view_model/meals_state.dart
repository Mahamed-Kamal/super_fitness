part of 'meals_view_model.dart';

class MealsState extends Equatable {
  final BaseState<List<MealCategoryEntity>> categoriesState;
  final BaseState<List<MealEntity>> mealsState;
  final int selectedCategoryIndex;

  const MealsState({
    required this.categoriesState,
    required this.mealsState,
    required this.selectedCategoryIndex,
  });

  factory MealsState.initial() => MealsState(
    categoriesState: BaseState.init(),
    mealsState: BaseState.init(),
    selectedCategoryIndex: 0,
  );

  MealsState copyWith({
    BaseState<List<MealCategoryEntity>>? categoriesState,
    BaseState<List<MealEntity>>? mealsState,
    int? selectedCategoryIndex,
  }) {
    return MealsState(
      categoriesState: categoriesState ?? this.categoriesState,
      mealsState: mealsState ?? this.mealsState,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
    );
  }

  @override
  List<Object?> get props => [
    categoriesState,
    selectedCategoryIndex,
    mealsState,
  ];
}
