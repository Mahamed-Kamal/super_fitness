import 'package:json_annotation/json_annotation.dart';

part 'trainer_levels_response.g.dart';

@JsonSerializable()
class TrainerLevels {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "levels")
  final List<Levels>? levels;

  TrainerLevels({this.message, this.levels});

  factory TrainerLevels.fromJson(Map<String, dynamic> json) {
    return _$TrainerLevelsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TrainerLevelsToJson(this);
  }
}

@JsonSerializable()
class Levels {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  Levels({this.id, this.name});

  factory Levels.fromJson(Map<String, dynamic> json) {
    return _$LevelsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LevelsToJson(this);
  }
}
