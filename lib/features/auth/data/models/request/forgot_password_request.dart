import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request.g.dart';

@JsonSerializable()
class ForgotPasswordRequest extends Equatable{
  @JsonKey(name: "email")
  final String? email;

  const ForgotPasswordRequest ({
    this.email,

  });

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    return _$ForgotPasswordRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ForgotPasswordRequestToJson(this);
  }

  @override
  List<Object?> get props => [email];
}


