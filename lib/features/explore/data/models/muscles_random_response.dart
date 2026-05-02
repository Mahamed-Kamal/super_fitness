import 'package:json_annotation/json_annotation.dart';
import 'muscles_dto.dart';
part 'muscles_random_response.g.dart';

@JsonSerializable()
class MusclesRandomDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "totalMuscles")
  final int? totalMuscles;
  @JsonKey(name: "muscles")
  final List<Muscles>? muscles;

  MusclesRandomDto({this.message, this.totalMuscles, this.muscles});

  factory MusclesRandomDto.fromJson(Map<String, dynamic> json) {
    return _$MusclesRandomDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesRandomDtoToJson(this);
  }
}
