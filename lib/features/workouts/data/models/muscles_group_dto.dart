import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/workouts/domain/entity/muscles_group_entity.dart';

part 'muscles_group_dto.g.dart';

@JsonSerializable()
class MusclesGroupDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  MusclesGroupDto({this.id, this.name});

  factory MusclesGroupDto.fromJson(Map<String, dynamic> json) {
    return _$MusclesGroupDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesGroupDtoToJson(this);
  }

  MusclesGroupEntity toEntity() {
    return MusclesGroupEntity(id: id, name: name);
  }
}
