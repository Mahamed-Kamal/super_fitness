import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/api/constants/api_constants.dart';

@module
abstract class ApiModule {
  @lazySingleton
  ApiClient provideApiClient(Dio dio) {
    return ApiClient(dio, baseUrl: ApiConstants.baseUrl);
  }

  @preResolve
  @lazySingleton
  Future<Dio> provideDio(BaseOptions option, PrettyDioLogger logger) async {
    var dio = Dio(option);
    dio.interceptors.add(logger);

    dio.options.headers = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $userToken',
    };

    return dio;
  }

  @lazySingleton
  BaseOptions providerOption() => BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    sendTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  );

  @lazySingleton
  PrettyDioLogger provideLogger() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
    );
  }
}
