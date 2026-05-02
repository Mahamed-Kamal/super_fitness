import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/domain/use_cases/get_meals_by_category_use_case.dart';
import 'package:super_fitness/features/meals/domain/use_cases/get_meals_categories_use_case.dart';
import 'package:super_fitness/features/meals/presentation/meals/view_model/meals_intent.dart';

part 'meals_state.dart';

@injectable
class MealsViewModel extends Cubit<MealsState> {
  final GetMealsCategoriesUseCase _getMealsCategoriesUseCase;
  final GetMealsByCategoryUseCase _getMealsByCategoryUseCase;
  final _uiEventsController = StreamController<MealsUIEvents>.broadcast();
  Stream<MealsUIEvents> get uiEventsStream => _uiEventsController.stream;

  MealsViewModel(
    this._getMealsCategoriesUseCase,
    this._getMealsByCategoryUseCase,
  ) : super(MealsState.initial());

  Future<void> doIntent(MealsIntent intent) async {
    switch (intent) {
      case GetMealsCategoriesIntent():
        await _getCategories();
      case SelectMealCategoryIntent():
        await _selectAndLoadMealsByIndex(intent.selectedIndex);
      case GetMealsByCategoryIntent():
        await _fetchMealsBySelectedCategory();
      case MealCardClickedIntent():
        _uiEventsController.add(NavigateToMealsDetails(intent.meal));
    }
  }

  Future<void> _getCategories() async {
    emit(state.copyWith(categoriesState: state.categoriesState.loading));
    var response = await _getMealsCategoriesUseCase();
    switch (response) {
      case SuccessResponse<List<MealCategoryEntity>>():
        if (response.data.isEmpty) {
          emit(
            state.copyWith(
              categoriesState: state.categoriesState.loaded(response.data),
            ),
          );
          return;
        }
        emit(
          state.copyWith(
            categoriesState: state.categoriesState.loaded(response.data),
            selectedCategoryIndex: 0,
          ),
        );
        await _fetchMealsBySelectedCategory();

      case FailureResponse<List<MealCategoryEntity>>():
        emit(
          state.copyWith(
            categoriesState: state.categoriesState.error(response.errorMessage),
          ),
        );
    }
  }

  Future<void> _selectAndLoadMealsByIndex(int selectedIndex) async {
    if (selectedIndex == state.selectedCategoryIndex) return;
    emit(
      state.copyWith(
        selectedCategoryIndex: selectedIndex,
        mealsState: state.mealsState.loading,
      ),
    );
    await _fetchMealsBySelectedCategory();
  }

  Future<void> _fetchMealsBySelectedCategory() async {
    final categories = state.categoriesState.data ?? <MealCategoryEntity>[];
    if (categories.isEmpty) return;
    if (state.selectedCategoryIndex < 0 ||
        state.selectedCategoryIndex >= categories.length) {
      return;
    }
    final category = categories[state.selectedCategoryIndex].name;
    emit(state.copyWith(mealsState: state.mealsState.loading));
    var response = await _getMealsByCategoryUseCase(category: category);
    switch (response) {
      case SuccessResponse<List<MealEntity>>():
        emit(
          state.copyWith(mealsState: state.mealsState.loaded(response.data)),
        );
      case FailureResponse<List<MealEntity>>():
        emit(
          state.copyWith(
            mealsState: state.mealsState.error(response.errorMessage),
          ),
        );
    }
  }

  @override
  Future<void> close() {
    _uiEventsController.close();
    return super.close();
  }
}
