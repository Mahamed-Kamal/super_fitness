import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/auth/domain/entity/forget_password_entity.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "info")
  final String? info;

  ForgotPasswordResponse({this.message, this.info});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$ForgotPasswordResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ForgotPasswordResponseToJson(this);
  }

  ForgotPasswordEntity toEntity() {
    return ForgotPasswordEntity(message: message, info: info);
  }
}
