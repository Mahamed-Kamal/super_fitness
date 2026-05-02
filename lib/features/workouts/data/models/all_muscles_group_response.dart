import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/workouts/data/models/muscles_group_dto.dart';

part 'all_muscles_group_response.g.dart';

@JsonSerializable()
class AllMusclesGroupResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "musclesGroup")
  final List<MusclesGroupDto>? musclesGroupDto;

  AllMusclesGroupResponse({this.message, this.musclesGroupDto});

  factory AllMusclesGroupResponse.fromJson(Map<String, dynamic> json) {
    return _$AllMusclesGroupResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllMusclesGroupResponseToJson(this);
  }
}
