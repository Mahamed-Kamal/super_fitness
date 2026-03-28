import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness/core/api/constants/end_points.dart';
import 'package:super_fitness/features/auth/data/models/requests/register_request_model.dart';
import 'package:super_fitness/features/auth/data/models/responses/register_response_dto.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST(EndPoints.register)
  Future<RegisterResponseDto> register(
    @Body() RegisterRequestModel registerRequestModel,
  );
}
