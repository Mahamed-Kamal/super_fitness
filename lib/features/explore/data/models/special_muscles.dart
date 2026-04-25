import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/explore/data/models/muscles_dto.dart';
import 'package:super_fitness/features/explore/data/models/muscles_group_dto.dart';

part 'special_muscles.g.dart';

@JsonSerializable()
class SpecialMusclesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "muscleGroup")
  final MusclesGroup? muscleGroup;
  @JsonKey(name: "muscles")
  final List<Muscles>? muscles;

  SpecialMusclesResponse({this.message, this.muscleGroup, this.muscles});

  factory SpecialMusclesResponse.fromJson(Map<String, dynamic> json) {
    return _$SpecialMusclesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SpecialMusclesResponseToJson(this);
  }
}
