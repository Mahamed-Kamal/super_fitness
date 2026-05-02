import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:super_fitness/core/api/api_client.dart';
import 'package:super_fitness/core/api/constants/api_constants.dart';
import 'package:super_fitness/core/di/modules/auth_interceptor.dart';

@module
abstract class ApiModule {
  @lazySingleton
  ApiClient provideApiClient(@Named('mainDio') Dio dio) => ApiClient(dio);

  @lazySingleton
  @Named('mainDio')
  Dio provideMainDio(PrettyDioLogger logger) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );

    dio.interceptors.add(logger);
    dio.interceptors.add(AuthInterceptor());

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
