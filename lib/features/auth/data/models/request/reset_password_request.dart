import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest extends Equatable {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "newPassword")
  final String? newPassword;

  const ResetPasswordRequest({this.email, this.newPassword});

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$ResetPasswordRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResetPasswordRequestToJson(this);
  }

  @override
  List<Object?> get props => [email, newPassword];
}
