import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/domain/repo/meals_repo.dart';
import 'package:super_fitness/features/meals/domain/use_cases/get_meal_details_use_case.dart';

import 'get_meal_details_use_case_test.mocks.dart';

@GenerateMocks([MealsRepo])
void main() {
  test("When i call the call function in the use case"
      "it's call the repo to get data", () async {
    var mockMealsRepo = MockMealsRepo();
    var getMealDetailsUseCase = GetMealDetailsUseCase(mockMealsRepo);
    var response = SuccessResponse(data: MealEntity());

    provideDummy<Result<MealEntity>>(response);
    when(
      mockMealsRepo.getMealDetails(id: '5555'),
    ).thenAnswer((_) async => response);

    var result = await getMealDetailsUseCase.call(id: '5555');
    expect(result is SuccessResponse<MealEntity>, true);
    verify(mockMealsRepo.getMealDetails(id: '5555')).called(1);
    verifyNoMoreInteractions(mockMealsRepo);
  });
}
