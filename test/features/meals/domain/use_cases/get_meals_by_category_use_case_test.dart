import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/domain/repo/meals_repo.dart';
import 'package:super_fitness/features/meals/domain/use_cases/get_meals_by_category_use_case.dart';

import 'get_meals_by_category_use_case_test.mocks.dart';

@GenerateMocks([MealsRepo])
void main() {
  late MockMealsRepo mockMealsRepo;
  late GetMealsByCategoryUseCase useCase;

  const category = 'Chicken';

  setUp(() {
    mockMealsRepo = MockMealsRepo();
    useCase = GetMealsByCategoryUseCase(mockMealsRepo);
  });

  group('GetMealsByCategoryUseCase', () {
    final meals = [const MealEntity(id: '1', name: 'Meal A')];
    late SuccessResponse<List<MealEntity>> success;
    late FailureResponse<List<MealEntity>> failure;

    setUp(() {
      success = SuccessResponse<List<MealEntity>>(data: meals);
      failure = FailureResponse<List<MealEntity>>(
        errorMessage: 'errors.connectionError',
      );
    });

    test('calls repo with category and returns SuccessResponse', () async {
      provideDummy<Result<List<MealEntity>>>(success);
      when(
        mockMealsRepo.getMealsByCategory(category: category),
      ).thenAnswer((_) async => success);

      final result = await useCase(category: category);

      expect((result as SuccessResponse<List<MealEntity>>).data, meals);
      verify(mockMealsRepo.getMealsByCategory(category: category)).called(1);
      verifyNoMoreInteractions(mockMealsRepo);
    });

    test('returns FailureResponse when repo fails', () async {
      provideDummy<Result<List<MealEntity>>>(failure);
      when(
        mockMealsRepo.getMealsByCategory(category: category),
      ).thenAnswer((_) async => failure);

      final result = await useCase(category: category);

      expect(
        (result as FailureResponse<List<MealEntity>>).errorMessage,
        'errors.connectionError',
      );
      verify(mockMealsRepo.getMealsByCategory(category: category)).called(1);
      verifyNoMoreInteractions(mockMealsRepo);
    });
  });
}
