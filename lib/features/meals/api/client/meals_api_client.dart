import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'meals_api_client.g.dart';

@RestApi()
abstract class MealsApiClient {
  @factoryMethod
  factory MealsApiClient(Dio dio, {String? baseUrl}) = _MealsApiClient;
}
