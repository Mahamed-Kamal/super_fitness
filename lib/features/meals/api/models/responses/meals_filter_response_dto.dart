import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_list_item_dto.dart';

part 'meals_filter_response_dto.g.dart';

@JsonSerializable()
class MealsFilterResponseDto {
  final List<MealListItemDto>? meals;

  const MealsFilterResponseDto({this.meals});

  factory MealsFilterResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MealsFilterResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealsFilterResponseDtoToJson(this);
}
