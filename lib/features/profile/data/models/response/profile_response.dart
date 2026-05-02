import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/profile/data/models/response/user_dto.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDto? userDto;

  ProfileResponse ({
    this.message,
    this.userDto,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileResponseToJson(this);
  }
}



