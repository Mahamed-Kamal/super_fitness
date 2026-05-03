import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/explore/domain/entities/muscles_entity.dart';

part 'muscles_dto.g.dart';

@JsonSerializable()
class MusclesDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "image")
  final String? image;

  MusclesDto({this.id, this.name, this.image});

  factory MusclesDto.fromJson(Map<String, dynamic> json) {
    return _$MusclesDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesDtoToJson(this);
  }

  MusclesEntity toEntity() {
    return MusclesEntity(id: id, name: name, image: image);
  }
}
