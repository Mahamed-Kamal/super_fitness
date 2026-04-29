import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/meals/api/models/responses/categories_response_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_category_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_list_item_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/meals_filter_response_dto.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/domain/mapper/meal_category_dto_mapper.dart';
import 'package:super_fitness/features/meals/domain/mapper/meal_list_item_dto_mapper.dart';

void main() {
  group('MealCategoryDtoMapperX', () {
    test('toEntity returns null when strCategory is null', () {
      expect(const MealCategoryDto(strCategory: null).toEntity(), isNull);
    });

    test('toEntity returns null when strCategory is empty', () {
      expect(const MealCategoryDto(strCategory: '').toEntity(), isNull);
    });

    test('toEntity uses idCategory when present', () {
      final entity = const MealCategoryDto(
        idCategory: 'id-1',
        strCategory: 'Vegan',
        strCategoryThumb: 't',
        strCategoryDescription: 'd',
      ).toEntity();
      expect(
        entity,
        const MealCategoryEntity(
          id: 'id-1',
          name: 'Vegan',
          thumbUrl: 't',
          description: 'd',
        ),
      );
    });

    test('toEntity falls back id to name when idCategory null', () {
      final entity = const MealCategoryDto(strCategory: 'Vegan').toEntity();
      expect(entity?.id, 'Vegan');
      expect(entity?.name, 'Vegan');
    });
  });

  group('CategoriesResponseMapperX', () {
    test('toEntityList filters null entities', () {
      final list = CategoriesResponseDto(
        categories: [
          const MealCategoryDto(strCategory: 'A'),
          const MealCategoryDto(strCategory: ''),
        ],
      ).toEntityList();
      expect(list.length, 1);
      expect(list.single.name, 'A');
    });
  });

  group('MealListItemDtoMapperX', () {
    test('toEntity returns null when strMeal empty', () {
      expect(
        const MealListItemDto(idMeal: '1', strMeal: '   ').toEntity(),
        isNull,
      );
    });

    test('toEntity returns null when idMeal null', () {
      expect(
        const MealListItemDto(idMeal: null, strMeal: 'X').toEntity(),
        isNull,
      );
    });

    test('toEntity maps valid row', () {
      final entity = const MealListItemDto(
        idMeal: '9',
        strMeal: 'Soup',
        strMealThumb: 'u',
      ).toEntity();
      expect(entity, const MealEntity(id: '9', name: 'Soup', imageUrl: 'u'));
    });
  });

  group('MealsFilterResponseMapperX', () {
    test('toEntityList skips invalid items', () {
      final list = MealsFilterResponseDto(
        meals: [
          const MealListItemDto(idMeal: '1', strMeal: 'Ok'),
          const MealListItemDto(idMeal: null, strMeal: 'Bad'),
        ],
      ).toEntityList();
      expect(list.single.name, 'Ok');
    });
  });
}
