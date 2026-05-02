import 'package:json_annotation/json_annotation.dart';
part 'muscles_group_dto.g.dart';

@JsonSerializable()
class MusclesGroup {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;

  MusclesGroup({this.id, this.name});

  factory MusclesGroup.fromJson(Map<String, dynamic> json) {
    return _$MusclesGroupFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MusclesGroupToJson(this);
  }
}
