import 'package:json_annotation/json_annotation.dart';

part 'difficulty_levels_dto.g.dart';

@JsonSerializable()
class DifficultyLevelsDTO {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  DifficultyLevelsDTO({this.id, this.name});

  factory DifficultyLevelsDTO.fromJson(Map<String, dynamic> json) {
    return _$DifficultyLevelsDTOFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DifficultyLevelsDTOToJson(this);
  }
}
