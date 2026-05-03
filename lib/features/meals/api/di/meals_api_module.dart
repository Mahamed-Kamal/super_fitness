import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:super_fitness/core/api/constants/api_constants.dart';
import 'package:super_fitness/features/meals/api/client/meals_api_client.dart';

@module
abstract class MealsApiModule {
  @lazySingleton
  MealsApiClient provideMealsApiClient(@Named('mealsDio') Dio dio) =>
      MealsApiClient(dio);

  @lazySingleton
  @Named('mealsDio')
  Dio provideMealsDio(PrettyDioLogger logger) {
    final dio = Dio(
      BaseOptions(
        baseUrl: _toAbsoluteMealsBaseUrl(ApiConstants.mealsBaseUrl),
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );

    dio.interceptors.add(logger);

    return dio;
  }
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
