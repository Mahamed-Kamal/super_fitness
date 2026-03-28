import 'package:json_annotation/json_annotation.dart';

part 'update_user_data_request.g.dart';

@JsonSerializable()
class UpdateUserDataRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  int? height;
  int? weight;
  int? age;
  String? goal;
  String? activityLevel;

  UpdateUserDataRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.height,
    this.weight,
    this.age,
    this.goal,
    this.activityLevel,
  });

  factory UpdateUserDataRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserDataRequestToJson(this);
}
