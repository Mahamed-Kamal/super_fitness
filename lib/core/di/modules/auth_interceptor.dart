import 'package:dio/dio.dart';
import 'package:super_fitness/core/utils/local/app_local_storage.dart';
import 'package:super_fitness/core/utils/local/local_keys.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await AppLocalStorage.getSecuredString(
      key: LocalKeys.authToken,
    );

    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
