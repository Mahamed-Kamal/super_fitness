import 'package:json_annotation/json_annotation.dart';

part 'register_request_model.g.dart';

@JsonSerializable()
class RegisterRequestModel {
  String firstName;
  String lastName;
  String email;
  String password;
  String rePassword;
  String gender;
  int height;
  int weight;
  int age;
  String goal;
  String activityLevel;

  RegisterRequestModel({
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.password = "",
    this.rePassword = "",
    this.gender = "",
    this.height = 0,
    this.weight = 0,
    this.age = 0,
    this.goal = "",
    this.activityLevel = "",
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}
