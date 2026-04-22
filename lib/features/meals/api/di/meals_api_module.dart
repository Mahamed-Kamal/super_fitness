import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/constants/api_constants.dart';
import 'package:super_fitness/features/meals/api/client/meals_api_client.dart';

@module
abstract class MealsApiModule {
  @lazySingleton
  MealsApiClient provideMealsApiClient(Dio dio) =>
      MealsApiClient(dio, baseUrl: ApiConstants.mealsBaseUrl);
}
