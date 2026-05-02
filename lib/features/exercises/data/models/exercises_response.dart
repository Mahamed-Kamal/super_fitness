import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/exercises/data/models/exercises_dto.dart';

part 'exercises_response.g.dart';

@JsonSerializable()
class ExercisesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "totalExercises")
  final int? totalExercises;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "exercises")
  final List<ExercisesDTO>? exercises;

  ExercisesResponse({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  factory ExercisesResponse.fromJson(Map<String, dynamic> json) {
    return _$ExercisesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExercisesResponseToJson(this);
  }
}
