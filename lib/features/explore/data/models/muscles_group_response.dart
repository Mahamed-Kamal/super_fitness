import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/explore/data/models/muscles_group_dto.dart';

part 'muscles_group_response.g.dart';

@JsonSerializable()
class MusclesResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "musclesGroup")
  final List<MusclesGroup>? musclesGroup;

  MusclesResponseDto({this.message, this.musclesGroup});

  factory MusclesResponseDto.fromJson(Map<String, dynamic> json) {
    return _$MusclesResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesResponseDtoToJson(this);
  }
}
