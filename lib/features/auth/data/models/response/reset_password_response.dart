import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/auth/domain/entity/reset_password_entity.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class ResetPasswordResponse with EquatableMixin {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;

  ResetPasswordResponse({this.message, this.token});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);

  ResetPasswordEntity toEntity() {
    return ResetPasswordEntity(
      message: message,
      info: token,
    );
  }
  @override
  List<Object?> get props => [message, token];
}
