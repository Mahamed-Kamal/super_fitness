import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/core/api/models/users_dto.dart';

part 'update_user_data_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateUserDataResponseDto extends Equatable {
  final String? message;
  final UsersDto? user;

  const UpdateUserDataResponseDto({this.message, this.user});

  factory UpdateUserDataResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDataResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserDataResponseDtoToJson(this);

  @override
  List<Object?> get props => [message, user];
}
