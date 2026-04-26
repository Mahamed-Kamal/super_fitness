import 'package:json_annotation/json_annotation.dart';

part 'meal_list_item_dto.g.dart';

/// Item returned by [filter.php] (subset of full meal fields).
@JsonSerializable()
class MealListItemDto {
  @JsonKey(name: 'idMeal')
  final String? idMeal;
  @JsonKey(name: 'strMeal')
  final String? strMeal;
  @JsonKey(name: 'strMealThumb')
  final String? strMealThumb;

  const MealListItemDto({this.idMeal, this.strMeal, this.strMealThumb});

  factory MealListItemDto.fromJson(Map<String, dynamic> json) =>
      _$MealListItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MealListItemDtoToJson(this);
}
