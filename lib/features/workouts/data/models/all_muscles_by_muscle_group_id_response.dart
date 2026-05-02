import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/workouts/data/models/muscles_dto.dart';
import 'package:super_fitness/features/workouts/data/models/muscles_group_dto.dart';

part 'all_muscles_by_muscle_group_id_response.g.dart';

@JsonSerializable()
class AllMusclesByMuscleGroupIdResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "muscleGroup")
  final MusclesGroupDto? muscleGroupDto;
  @JsonKey(name: "muscles")
  final List<MusclesDto>? musclesDto;

  AllMusclesByMuscleGroupIdResponse({
    this.message,
    this.muscleGroupDto,
    this.musclesDto,
  });

  factory AllMusclesByMuscleGroupIdResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return _$AllMusclesByMuscleGroupIdResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllMusclesByMuscleGroupIdResponseToJson(this);
  }
}
