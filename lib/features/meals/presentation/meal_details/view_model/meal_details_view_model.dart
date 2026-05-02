import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_view_model.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/domain/use_cases/get_meal_details_use_case.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/view_model/meal_details_events.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/view_model/meal_details_intent.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/view_model/meal_details_state.dart';

@injectable
class MealDetailsViewModel
    extends
        BaseViewModel<MealDetailsState, MealDetailsIntent, MealDetailsEvents> {
  final GetMealDetailsUseCase _getMealDetailsUseCase;

  MealDetailsViewModel(this._getMealDetailsUseCase)
    : super(MealDetailsState.init());

  @override
  void doIntent(MealDetailsIntent intent) {
    switch (intent) {
      case GetMealDetails():
        getMealDetails(id: intent.id);
    }
  }

  Future<void> getMealDetails({required String id}) async {
    emit(MealDetailsState.loading());
    var result = await _getMealDetailsUseCase.call(id: id);
    switch (result) {
      case SuccessResponse<MealEntity>():
        emit(MealDetailsState.loaded(result.data));
      case FailureResponse<MealEntity>():
        emit(MealDetailsState.error(result.errorMessage));
    }
  }
}
