import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/exercises/data/models/difficulty_levels_dto.dart';

part 'difficulty_levels_response.g.dart';

@JsonSerializable()
class DifficultyLevelsResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "totalLevels")
  final int? totalLevels;
  @JsonKey(name: "difficulty_levels")
  final List<DifficultyLevelsDTO>? difficultyLevels;

  DifficultyLevelsResponse({
    this.message,
    this.totalLevels,
    this.difficultyLevels,
  });

  factory DifficultyLevelsResponse.fromJson(Map<String, dynamic> json) {
    return _$DifficultyLevelsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DifficultyLevelsResponseToJson(this);
  }
}
