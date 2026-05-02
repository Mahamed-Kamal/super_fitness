import 'package:super_fitness/features/meals/api/models/responses/categories_response_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_category_dto.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_category_entity.dart';

extension MealCategoryDtoMapperX on MealCategoryDto {
  MealCategoryEntity? toEntity() {
    final name = strCategory;
    if (name == null || name.isEmpty) return null;
    return MealCategoryEntity(
      id: idCategory ?? name,
      name: name,
      thumbUrl: strCategoryThumb,
      description: strCategoryDescription,
    );
  }
}

extension CategoriesResponseMapperX on CategoriesResponseDto {
  List<MealCategoryEntity> toEntityList() {
    return (categories ?? [])
        .map((e) => e.toEntity())
        .whereType<MealCategoryEntity>()
        .toList();
  }
}
