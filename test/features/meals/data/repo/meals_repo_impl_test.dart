import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/categories_response_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_category_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_list_item_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/meals_filter_response_dto.dart';
import 'package:super_fitness/features/meals/data/data_source/meals_remote_data_source.dart';
import 'package:super_fitness/features/meals/data/repo/meals_repo_impl.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_category_entity.dart';
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

  late MockMealsRemoteDataSource mockDataSource;
  late MealsRepoImpl repo;

  setUp(() {
    mockDataSource = MockMealsRemoteDataSource();
    repo = MealsRepoImpl(mockDataSource);
  });

  group('MealsRepoImpl.getMealCategories', () {
    test('maps SuccessResponse DTO to entity list', () async {
      final dto = CategoriesResponseDto(
        categories: [
          const MealCategoryDto(
            idCategory: '1',
            strCategory: 'Beef',
            strCategoryThumb: 'http://thumb',
            strCategoryDescription: 'desc',
          ),
        ],
      );
      final remote = SuccessResponse<CategoriesResponseDto>(data: dto);
      provideDummy<Result<CategoriesResponseDto>>(remote);
      when(
        mockDataSource.fetchMealCategories(),
      ).thenAnswer((_) async => remote);

      final result = await repo.getMealCategories();

      expect(result, isA<SuccessResponse<List<MealCategoryEntity>>>());
      final data = (result as SuccessResponse<List<MealCategoryEntity>>).data;
      expect(data.length, 1);
      expect(
        data.first,
        const MealCategoryEntity(
          id: '1',
          name: 'Beef',
          thumbUrl: 'http://thumb',
          description: 'desc',
        ),
      );
      verify(mockDataSource.fetchMealCategories()).called(1);
    });

    test('propagates FailureResponse', () async {
      final remote = FailureResponse<CategoriesResponseDto>(
        errorMessage: 'errors.connectionError',
      );
      provideDummy<Result<CategoriesResponseDto>>(remote);
      when(
        mockDataSource.fetchMealCategories(),
      ).thenAnswer((_) async => remote);

      final result = await repo.getMealCategories();

      expect(
        (result as FailureResponse<List<MealCategoryEntity>>).errorMessage,
        'errors.connectionError',
      );
      verify(mockDataSource.fetchMealCategories()).called(1);
    });
  });

  group('MealsRepoImpl.getMealsByCategory', () {
    test('maps SuccessResponse DTO to entity list', () async {
      final dto = MealsFilterResponseDto(
        meals: [
          const MealListItemDto(
            idMeal: '10',
            strMeal: ' Pie ',
            strMealThumb: 'http://m',
          ),
        ],
      );
      final remote = SuccessResponse<MealsFilterResponseDto>(data: dto);
      provideDummy<Result<MealsFilterResponseDto>>(remote);
      when(
        mockDataSource.fetchMealsByCategory(category: 'Beef'),
      ).thenAnswer((_) async => remote);

      final result = await repo.getMealsByCategory(category: 'Beef');

      expect(result, isA<SuccessResponse<List<MealEntity>>>());
      final data = (result as SuccessResponse<List<MealEntity>>).data;
      expect(
        data.single,
        const MealEntity(id: '10', title: 'Pie', imageUrl: 'http://m'),
      );
      verify(mockDataSource.fetchMealsByCategory(category: 'Beef')).called(1);
    });

    test('propagates FailureResponse', () async {
      final remote = FailureResponse<MealsFilterResponseDto>(
        errorMessage: 'errors.connectionError',
      );
      provideDummy<Result<MealsFilterResponseDto>>(remote);
      when(
        mockDataSource.fetchMealsByCategory(category: 'Beef'),
      ).thenAnswer((_) async => remote);

      final result = await repo.getMealsByCategory(category: 'Beef');

      expect(
        (result as FailureResponse<List<MealEntity>>).errorMessage,
        'errors.connectionError',
      );
    });
  });
}
