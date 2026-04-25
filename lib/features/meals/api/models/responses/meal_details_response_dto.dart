import 'package:json_annotation/json_annotation.dart';

import 'meal_dto.dart';

part 'meal_details_response_dto.g.dart';

@JsonSerializable()
class MealDetailsResponseDto {
  @JsonKey(name: "meals")
  final List<MealDto>? meals;

  MealDetailsResponseDto({this.meals});

  factory MealDetailsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MealDetailsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealDetailsResponseDtoToJson(this);
}
