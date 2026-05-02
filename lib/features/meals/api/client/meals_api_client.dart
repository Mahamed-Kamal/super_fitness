import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness/features/meals/api/constants/meals_end_points.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_details_response_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/categories_response_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/meals_filter_response_dto.dart';

part 'meals_api_client.g.dart';

@RestApi()
abstract class MealsApiClient {
  @factoryMethod
  factory MealsApiClient(Dio dio, {String? baseUrl}) = _MealsApiClient;

  @GET(MealsEndPoints.mealsCategories)
  Future<CategoriesResponseDto> getMealCategories();

  @GET(MealsEndPoints.mealsByCategories)
  Future<MealsFilterResponseDto> getMealsByCategory(
    @Query('c') String category,
  );

  @GET(MealsEndPoints.mealDetails)
  Future<MealDetailsResponseDto> getMealDetails({
    @Query('i') required String id,
  });
}
