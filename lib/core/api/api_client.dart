import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness/core/api/constants/end_points.dart';
import 'package:super_fitness/features/auth/data/models/request/forgot_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness/features/auth/data/models/response/forgot_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/verify_reset_code_response.dart';

import '../../features/auth/data/models/request/reset_password_request.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(EndPoints.forgotPassword)
  Future<ForgotPasswordResponse> forgotPassword({
    @Body() required ForgotPasswordRequest forgotPassword,
  });
  @POST(EndPoints.verifyOtp)
  Future<VerifyResetCodeResponse> verifyOtp({
    @Body() required VerifyResetCodeRequest verifyResetCodeRequest,
  });
  @POST(EndPoints.resetPassword)
  Future< ResetPasswordResponse> resetPassword({
    @Body() required ResetPasswordRequest resetPassword,
  });

}
