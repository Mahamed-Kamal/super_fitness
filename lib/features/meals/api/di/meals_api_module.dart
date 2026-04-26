import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/constants/api_constants.dart';
import 'package:super_fitness/features/meals/api/client/meals_api_client.dart';

@module
abstract class MealsApiModule {
  /// Meal API must be an absolute URL or Retrofit merges with [Dio.options.baseUrl].
  @lazySingleton
  MealsApiClient provideMealsApiClient(Dio dio) => MealsApiClient(
    dio,
    baseUrl: _toAbsoluteMealsBaseUrl(ApiConstants.mealsBaseUrl),
  );
}

String _toAbsoluteMealsBaseUrl(String raw) {
  var s = raw.trim();
  if (s.isEmpty) {
    return s;
  }
  final lower = s.toLowerCase();
  if (!lower.startsWith('http://') && !lower.startsWith('https://')) {
    s = 'https://$s';
  }
  if (!s.endsWith('/')) {
    s = '$s/';
  }
  return s;
}
