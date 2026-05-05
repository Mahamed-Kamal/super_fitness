import 'package:super_fitness/features/meals/api/models/responses/meal_list_item_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/meals_filter_response_dto.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';

extension MealListItemDtoMapperX on MealListItemDto {
  MealEntity? toEntity() {
    final name = strMeal?.trim();
    final id = idMeal;
    if (name == null || name.isEmpty || id == null || id.isEmpty) return null;
    return MealEntity(id: id, title: name, imageUrl: strMealThumb ?? "");
  }
}

extension MealsFilterResponseMapperX on MealsFilterResponseDto {
  List<MealEntity> toEntityList() {
    return (meals ?? [])
        .map((e) => e.toEntity())
        .whereType<MealEntity>()
        .toList();
  }
}
