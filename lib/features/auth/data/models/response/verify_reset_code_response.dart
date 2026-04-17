import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/auth/domain/entity/verify_reset_code_entity.dart';

part 'verify_reset_code_response.g.dart';

@JsonSerializable()
class VerifyResetCodeResponse {
  @JsonKey(name: 'status')
  final String message;

  VerifyResetCodeResponse({required this.message});

  factory VerifyResetCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetCodeResponseToJson(this);
  VerifyResetCodeEntity toEntity() {
    return VerifyResetCodeEntity(message: message);
  }
}
