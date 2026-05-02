import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness/core/api/constants/end_points.dart';
import 'package:super_fitness/core/api/constants/queries_constant.dart';
import 'package:super_fitness/features/auth/data/models/login/login_response_dto.dart';
import 'package:super_fitness/features/auth/data/models/request/forgot_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/reset_password_request.dart';
import 'package:super_fitness/features/auth/data/models/request/verify_reset_code_request.dart';
import 'package:super_fitness/features/auth/data/models/requests/change_password_request.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';
import 'package:super_fitness/features/auth/data/models/requests/update_user_data_request.dart';
import 'package:super_fitness/features/auth/data/models/response/forgot_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/reset_password_response.dart';
import 'package:super_fitness/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:super_fitness/features/auth/data/models/responses/change_password_response.dart';
import 'package:super_fitness/features/auth/data/models/responses/register_response_dto.dart';
import 'package:super_fitness/features/auth/data/models/responses/update_user_data_response_dto.dart';
import 'package:super_fitness/features/profile/data/models/upload_profile/upload_profile_message_response.dart';
import 'package:super_fitness/features/exercises/data/models/difficulty_levels_response.dart';
import 'package:super_fitness/features/exercises/data/models/exercises_response.dart';
import 'package:super_fitness/features/explore/data/models/categories_response.dart';
import 'package:super_fitness/features/explore/data/models/exercises_response.dart';
import 'package:super_fitness/features/explore/data/models/muscles_group_response.dart';
import 'package:super_fitness/features/explore/data/models/muscles_random_response.dart';
import 'package:super_fitness/features/explore/data/models/special_muscles.dart';
import '../../features/explore/data/models/trainer_levels_response.dart';
import 'package:super_fitness/features/workouts/data/models/all_muscles_by_muscle_group_id_response.dart';
import 'package:super_fitness/features/workouts/data/models/all_muscles_group_response.dart';

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

  @GET(EndPoints.getExercises)
  Future<ExercisesResponse> getExercises({
    @Query("primeMoverMuscleId") required String primeMoverMuscleId,
    @Query("difficultyLevelId") required String difficultyLevelId,
    @Query("page") required int page,
  });

  @GET(EndPoints.getDifficultyLevels)
  Future<DifficultyLevelsResponse> getDifficultyLevels({
    @Query("primeMoverMuscleId") required String primeMoverMuscleId,
  });
  @GET(EndPoints.getAllMusclesGroups)
  Future<AllMusclesGroupResponse> getAllMusclesGroups();
  @GET(EndPoints.getMusclesByMusclesGroupID)
  Future<AllMusclesByMuscleGroupIdResponse> getMusclesByMusclesGroupID(
    @Path("id") String id,
  );

  @PATCH(EndPoints.changePassword)
  Future<ChangePasswordResponse> changePassword({
    @Body() required ChangePasswordRequest changePasswordRequest,
  });
  @GET(EndPoints.getMusclesRandom)
  Future<MusclesRandomDto> getMusclesRandom();
  @GET(EndPoints.getMusclesGroup)
  Future<MusclesResponseDto> getMusclesGroup();
  @GET(EndPoints.getCategories)
  Future<CategoriesResponse> getCategories();
  @GET(EndPoints.getSpecificMusclesGroup)
  Future<SpecialMusclesResponse> getSpecificMusclesGroup(@Path() String id);
  @GET(EndPoints.getTrainerLevels)
  Future<TrainerLevels> getTrainerLevels();
  @GET(EndPoints.getExercisesByMuscleDifficulty)
  Future<ExercisesByPrimeResponse> getExerciseByPrimeMoverMuscleAndDiffLevel(
    @Query(QueriesConstant.primeMoverMuscle) String primeMoverMuscle,
    @Query(QueriesConstant.difficultyLevel) String difficultyLevel,
  );

  @PUT(EndPoints.updateUserData)
  Future<UpdateUserDataResponseDto> editProfile({
    @Body() required UpdateUserDataRequest updateUserDataRequest,
  });

  @MultiPart()
  @PUT(EndPoints.uploadProfilePhoto)
  Future<UploadProfileMessageResponse> uploadProfilePhoto({
    @Part(name: 'photo') required MultipartFile photo,
  });

  @GET(EndPoints.getProfileData)
  Future<UpdateUserDataResponseDto> getProfileData();
}
