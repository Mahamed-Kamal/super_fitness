import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users_dto.g.dart';

@JsonSerializable()
class UsersDto extends Equatable {
  @JsonKey(name: "_id")
  final String? id;
  final String? createdAt;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final int? age;
  final int? weight;
  final int? height;
  final String? activityLevel;
  final String? goal;
  @JsonKey(name: "photo")
  final String? profilePicture;

  const UsersDto({
    this.id,
    this.createdAt,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
    this.profilePicture,
  });

  factory UsersDto.fromJson(Map<String, dynamic> json) =>
      _$UsersDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UsersDtoToJson(this);

  @override
  List<Object?> get props => [
    id,
    createdAt,
    firstName,
    lastName,
    email,
    gender,
    age,
    weight,
    height,
    activityLevel,
    goal,
    profilePicture,
  ];
}
