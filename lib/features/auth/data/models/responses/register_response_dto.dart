import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/core/api/models/user_dto.dart';

part 'register_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterResponseDto extends Equatable {
  final String? message;
  final UserDto? user;
  final String? token;

  const RegisterResponseDto({this.message, this.user, this.token});

  factory RegisterResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseDtoToJson(this);

  @override
  List<Object?> get props => [message, user, token];
}
