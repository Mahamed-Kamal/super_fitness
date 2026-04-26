import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness/features/meals/domain/repo/meals_repo.dart';
import 'package:super_fitness/features/meals/domain/use_cases/get_meals_categories_use_case.dart';

import 'get_meals_categories_use_case_test.mocks.dart';

@GenerateMocks([MealsRepo])
void main() {
  late MockMealsRepo mockMealsRepo;
  late GetMealsCategoriesUseCase useCase;

  setUp(() {
    mockMealsRepo = MockMealsRepo();
    useCase = GetMealsCategoriesUseCase(mockMealsRepo);
  });

  group('GetMealsCategoriesUseCase', () {
    final entities = [const MealCategoryEntity(id: '1', name: 'Beef')];
    late SuccessResponse<List<MealCategoryEntity>> success;
    late FailureResponse<List<MealCategoryEntity>> failure;

    setUp(() {
      success = SuccessResponse<List<MealCategoryEntity>>(data: entities);
      failure = FailureResponse<List<MealCategoryEntity>>(
        errorMessage: 'errors.connectionError',
      );
    });

    test('delegates to repo and returns SuccessResponse', () async {
      provideDummy<Result<List<MealCategoryEntity>>>(success);
      when(mockMealsRepo.getMealCategories()).thenAnswer((_) async => success);

      final result = await useCase();

      expect(
        (result as SuccessResponse<List<MealCategoryEntity>>).data,
        entities,
      );
      verify(mockMealsRepo.getMealCategories()).called(1);
      verifyNoMoreInteractions(mockMealsRepo);
    });

    test('returns FailureResponse when repo fails', () async {
      provideDummy<Result<List<MealCategoryEntity>>>(failure);
      when(mockMealsRepo.getMealCategories()).thenAnswer((_) async => failure);

      final result = await useCase();

      expect(
        (result as FailureResponse<List<MealCategoryEntity>>).errorMessage,
        'errors.connectionError',
      );
      verify(mockMealsRepo.getMealCategories()).called(1);
      verifyNoMoreInteractions(mockMealsRepo);
    });
  });
}
