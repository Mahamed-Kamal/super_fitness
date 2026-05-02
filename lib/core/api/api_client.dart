import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness/core/api/constants/end_points.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/data/models/request/forgot_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/data/models/response/forgot_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:super_fitness/features/auth/data/models/responses/register_response_dto.dart';
import 'package:super_fitness/features/auth/data/models/responses/update_user_data_response_dto.dart';
import 'package:super_fitness/features/profile/data/models/response/profile_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(EndPoints.register)
  Future<RegisterResponseDto> register(
    @Body() RegisterRequestModel registerRequestModel,
  );

  @POST(EndPoints.updateUserData)
  Future<UpdateUserDataResponseDto> updateUserData({
    @Header("Authorization") String? token,
    @Body() required UpdateUserDataRequest updateUserDataRequest,
  });

  @POST(EndPoints.login)
  Future<LoginResponseDto> login({
    @Field("email") required String email,
    @Field("password") required String password,
  });

  @POST(EndPoints.forgotPassword)
  Future<ForgotPasswordResponse> forgotPassword({
    @Body() required ForgotPasswordRequest forgotPassword,
  });
  @POST(EndPoints.verifyOtp)
  Future<VerifyResetCodeResponse> verifyOtp({
    @Body() required VerifyResetCodeRequest verifyResetCodeRequest,
  });
  @PUT(EndPoints.resetPassword)
  Future<ResetPasswordResponse> resetPassword({
    @Body() required ResetPasswordRequest resetPassword,
  });
  @GET(EndPoints.profile)
  Future<ProfileResponse> getUserData();
}
