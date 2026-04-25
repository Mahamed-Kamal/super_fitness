import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_dto.dart';
import 'package:super_fitness/features/meals/data/data_source/meals_remote_data_source.dart';
import 'package:super_fitness/features/meals/data/repo/meals_repo_impl.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/domain/repo/meals_repo.dart';

import 'meals_repo_impl_test.mocks.dart';

@GenerateMocks([MealsRemoteDataSource])
void main() {
  group("getMealDetails in REPO TEST CASES", () {
    late MockMealsRemoteDataSource mockMealsRemoteDataSource;
    late MealsRepo mealsRepo;
    late String id, title, instructions, image;
    late MealDto mealDto;

    setUpAll(() {
      mockMealsRemoteDataSource = MockMealsRemoteDataSource();
      mealsRepo = MealsRepoImpl(mockMealsRemoteDataSource);
    });

    setUp(() {
      id = "55555";
      title = "Noodles";
      instructions = "any";
      image = "url";
      mealDto = MealDto(
        idMeal: id,
        strMeal: title,
        strIngredient1: 'ingredient',
        strMeasure1: 'measure',
        strInstructions: instructions,
        strMealThumb: image,
      );
    });

    test("When i call getMealDetails from repo"
        "it's call datasource and return success", () async {
      provideDummy<Result<MealDto>>(SuccessResponse(data: mealDto));
      when(
        mockMealsRemoteDataSource.getMealDetails(id: id),
      ).thenAnswer((_) async => SuccessResponse(data: mealDto));

      var result = await mealsRepo.getMealDetails(id: id);
      expect(result is SuccessResponse<MealEntity>, true);
      expect((result as SuccessResponse<MealEntity>).data.title, title);
      verify(mockMealsRemoteDataSource.getMealDetails(id: id)).called(1);
      verifyNoMoreInteractions(mockMealsRemoteDataSource);
    });

    test("When datasource returns failure "
        "repo returns same failure", () async {
      when(mockMealsRemoteDataSource.getMealDetails(id: id)).thenAnswer(
        (_) async => FailureResponse(errorMessage: "errors.unexpected"),
      );

      final result = await mealsRepo.getMealDetails(id: id);

      expect(
        (result as FailureResponse).errorMessage,
        equals("errors.unexpected"),
      );

      verify(mockMealsRemoteDataSource.getMealDetails(id: id)).called(1);
      verifyNoMoreInteractions(mockMealsRemoteDataSource);
    });
  });
}
