import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_category_dto.dart';

part 'categories_response_dto.g.dart';

@JsonSerializable()
class CategoriesResponseDto {
  final List<MealCategoryDto>? categories;

  const CategoriesResponseDto({this.categories});

  factory CategoriesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseDtoToJson(this);
}
