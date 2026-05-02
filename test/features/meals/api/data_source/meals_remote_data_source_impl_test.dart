import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/api/client/meals_api_client.dart';
import 'package:super_fitness/features/meals/api/data_source/meals_remote_data_source_impl.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_details_response_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_dto.dart';
import 'package:super_fitness/features/meals/data/data_source/meals_remote_data_source.dart';
import 'package:super_fitness/features/meals/api/models/responses/categories_response_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/meals_filter_response_dto.dart';

import 'meals_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([MealsApiClient])
void main() {
  group("", () {
    late MockMealsApiClient mockMealsApiClient;
    late MealsRemoteDataSourceImpl mealsRemoteDataSource;

    setUp(() {
      mockMealsApiClient = MockMealsApiClient();
      mealsRemoteDataSource = MealsRemoteDataSourceImpl(mockMealsApiClient);
    });

    group('MealsRemoteDataSourceImpl.fetchMealCategories', () {
      test('returns SuccessResponse when api client succeeds', () async {
        const categoriesResponse = CategoriesResponseDto(categories: []);
        when(
          mockMealsApiClient.getMealCategories(),
        ).thenAnswer((_) async => categoriesResponse);

        final result = await mealsRemoteDataSource.fetchMealCategories();

        expect(result, isA<SuccessResponse<CategoriesResponseDto>>());
        expect(
          (result as SuccessResponse<CategoriesResponseDto>).data,
          categoriesResponse,
        );
        verify(mockMealsApiClient.getMealCategories()).called(1);
        verifyNoMoreInteractions(mockMealsApiClient);
      });

      test(
        'returns FailureResponse when api client throws exception',
        () async {
          when(
            mockMealsApiClient.getMealCategories(),
          ).thenThrow(Exception('network failed'));

          final result = await mealsRemoteDataSource.fetchMealCategories();

          expect(result, isA<FailureResponse<CategoriesResponseDto>>());
          expect(
            (result as FailureResponse<CategoriesResponseDto>).errorMessage,
            isNotEmpty,
          );
          verify(mockMealsApiClient.getMealCategories()).called(1);
          verifyNoMoreInteractions(mockMealsApiClient);
        },
      );
    });

    group('MealsRemoteDataSourceImpl.fetchMealsByCategory', () {
      test('returns SuccessResponse when api client succeeds', () async {
        const categoryName = 'Chicken';
        const mealsFilterResponse = MealsFilterResponseDto(meals: []);
        when(
          mockMealsApiClient.getMealsByCategory(categoryName),
        ).thenAnswer((_) async => mealsFilterResponse);

        final result = await mealsRemoteDataSource.fetchMealsByCategory(
          category: categoryName,
        );

        expect(result, isA<SuccessResponse<MealsFilterResponseDto>>());
        expect(
          (result as SuccessResponse<MealsFilterResponseDto>).data,
          mealsFilterResponse,
        );
        verify(mockMealsApiClient.getMealsByCategory(categoryName)).called(1);
        verifyNoMoreInteractions(mockMealsApiClient);
      });

      test(
        'returns FailureResponse when api client throws exception',
        () async {
          const categoryName = 'Beef';
          when(
            mockMealsApiClient.getMealsByCategory(categoryName),
          ).thenThrow(Exception('network failed'));

          final result = await mealsRemoteDataSource.fetchMealsByCategory(
            category: categoryName,
          );

          expect(result, isA<FailureResponse<MealsFilterResponseDto>>());
          expect(
            (result as FailureResponse<MealsFilterResponseDto>).errorMessage,
            isNotEmpty,
          );
          verify(mockMealsApiClient.getMealsByCategory(categoryName)).called(1);
          verifyNoMoreInteractions(mockMealsApiClient);
        },
      );
    });
  });
  group("Test getMealDetails in dataSource cases", () {
    late MockMealsApiClient mockMealsApiClient;
    late MealsRemoteDataSource mealsRemoteDataSource;
    late String id;
    late MealDetailsResponseDto mealDetailsResponseDto;
    late List<MealDto> mealsDto;
    setUpAll(() {
      mockMealsApiClient = MockMealsApiClient();
      mealsRemoteDataSource = MealsRemoteDataSourceImpl(mockMealsApiClient);
    });

    setUp(() {
      id = "55555";
      mealsDto = [MealDto(idMeal: "55555", strMeal: "Noodles")];
      mealDetailsResponseDto = MealDetailsResponseDto(meals: mealsDto);
    });

    test(
      "When i call getMealDetails with empty id it's return failure",
      () async {
        id = "";

        var response = await mealsRemoteDataSource.getMealDetails(id: id);
        expect(response is FailureResponse<List<MealDto>>, true);
        expect(
          (response as FailureResponse<List<MealDto>>).errorMessage,
          "empty_id",
        );
      },
    );

    test("When i call getMealDetails with id it's return success"
        "if api call success", () async {
      when(
        mockMealsApiClient.getMealDetails(id: id),
      ).thenAnswer((_) async => mealDetailsResponseDto);

      var response =
          await mealsRemoteDataSource.getMealDetails(id: id)
              as SuccessResponse<List<MealDto>>;

      expect(response.data.first.idMeal, id);
    });

    test("When i call getMealDetails with id it's return failure"
        "if api call failed", () async {
      when(
        mockMealsApiClient.getMealDetails(id: id),
      ).thenThrow(Exception("Unexpected error"));

      var response = await mealsRemoteDataSource.getMealDetails(id: id);

      expect(response is FailureResponse<List<MealDto>>, true);
      expect(
        (response as FailureResponse).errorMessage,
        equals("errors.unexpected"),
      );
    });
  });
}
