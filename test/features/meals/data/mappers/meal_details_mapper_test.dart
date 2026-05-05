import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_dto.dart';
import 'package:super_fitness/features/meals/domain/mapper/meal_details_mapper.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';

void main() {
  group('MealDetailsMapper', () {
    MealDto buildMealDto({
      String? strMeal,
      String? strInstructions,
      String? strMealThumb,
      String? strIngredient1,
      String? strMeasure1,
      String? strIngredient2,
      String? strMeasure2,
      String? strIngredient3,
      String? strMeasure3,
      String? strIngredient4,
      String? strMeasure4,
      String? strIngredient5,
      String? strMeasure5,
      String? strIngredient6,
      String? strMeasure6,
      String? strIngredient7,
      String? strMeasure7,
      String? strIngredient8,
      String? strMeasure8,
      String? strIngredient9,
      String? strMeasure9,
      String? strIngredient10,
      String? strMeasure10,
      String? strIngredient11,
      String? strMeasure11,
      String? strIngredient12,
      String? strMeasure12,
      String? strIngredient13,
      String? strMeasure13,
      String? strIngredient14,
      String? strMeasure14,
      String? strIngredient15,
      String? strMeasure15,
      String? strIngredient16,
      String? strMeasure16,
      String? strIngredient17,
      String? strMeasure17,
      String? strIngredient18,
      String? strMeasure18,
      String? strIngredient19,
      String? strMeasure19,
      String? strIngredient20,
      String? strMeasure20,
    }) => MealDto(
      strMeal: strMeal,
      strInstructions: strInstructions,
      strMealThumb: strMealThumb,
      strIngredient1: strIngredient1,
      strMeasure1: strMeasure1,
      strIngredient2: strIngredient2,
      strMeasure2: strMeasure2,
      strIngredient3: strIngredient3,
      strMeasure3: strMeasure3,
      strIngredient4: strIngredient4,
      strMeasure4: strMeasure4,
      strIngredient5: strIngredient5,
      strMeasure5: strMeasure5,
      strIngredient6: strIngredient6,
      strMeasure6: strMeasure6,
      strIngredient7: strIngredient7,
      strMeasure7: strMeasure7,
      strIngredient8: strIngredient8,
      strMeasure8: strMeasure8,
      strIngredient9: strIngredient9,
      strMeasure9: strMeasure9,
      strIngredient10: strIngredient10,
      strMeasure10: strMeasure10,
      strIngredient11: strIngredient11,
      strMeasure11: strMeasure11,
      strIngredient12: strIngredient12,
      strMeasure12: strMeasure12,
      strIngredient13: strIngredient13,
      strMeasure13: strMeasure13,
      strIngredient14: strIngredient14,
      strMeasure14: strMeasure14,
      strIngredient15: strIngredient15,
      strMeasure15: strMeasure15,
      strIngredient16: strIngredient16,
      strMeasure16: strMeasure16,
      strIngredient17: strIngredient17,
      strMeasure17: strMeasure17,
      strIngredient18: strIngredient18,
      strMeasure18: strMeasure18,
      strIngredient19: strIngredient19,
      strMeasure19: strMeasure19,
      strIngredient20: strIngredient20,
      strMeasure20: strMeasure20,
    );

    void expectIngredient(
      MapEntry<String, String> entry,
      String key,
      String value,
    ) {
      expect(entry.key, key);
      expect(entry.value, value);
    }

    // ─── Return type ──────────────────────────────────────────────────────────

    test('returns a MealEntity', () {
      final result = buildMealDto().toMealEntity();
      expect(result, isA<MealEntity>());
    });

    // ─── Scalar fields ────────────────────────────────────────────────────────

    test('maps title from strMeal', () {
      final result = buildMealDto(strMeal: 'Spaghetti').toMealEntity();
      expect(result.title, 'Spaghetti');
    });

    test('maps instructions from strInstructions', () {
      final result = buildMealDto(strInstructions: 'Boil water').toMealEntity();
      expect(result.instructions, 'Boil water');
    });

    test('maps image from strMealThumb', () {
      final result = buildMealDto(
        strMealThumb: 'https://img.com/meal.jpg',
      ).toMealEntity();
      expect(result.imageUrl, 'https://img.com/meal.jpg');
    });

    // ─── Null fallbacks ───────────────────────────────────────────────────────

    test('falls back to empty string for null title', () {
      final result = buildMealDto(strMeal: null).toMealEntity();
      expect(result.title, '');
    });

    test('falls back to empty string for null instructions', () {
      final result = buildMealDto(strInstructions: null).toMealEntity();
      expect(result.instructions, '');
    });

    test('falls back to empty string for null image', () {
      final result = buildMealDto(strMealThumb: null).toMealEntity();
      expect(result.imageUrl, '');
    });

    // ─── Ingredients list ─────────────────────────────────────────────────────

    test('always produces exactly 20 ingredient entries', () {
      final result = buildMealDto().toMealEntity();
      expect(result.ingredients.length, 20);
    });

    test('maps ingredient and measure values correctly for all 20 slots', () {
      final dto = buildMealDto(
        strIngredient1: 'Flour',
        strMeasure1: '2 cups',
        strIngredient2: 'Sugar',
        strMeasure2: '1 cup',
        strIngredient3: 'Eggs',
        strMeasure3: '3',
        strIngredient4: 'Butter',
        strMeasure4: '100g',
        strIngredient5: 'Milk',
        strMeasure5: '200ml',
        strIngredient6: 'Salt',
        strMeasure6: '1 tsp',
        strIngredient7: 'Pepper',
        strMeasure7: '1/2 tsp',
        strIngredient8: 'Oil',
        strMeasure8: '2 tbsp',
        strIngredient9: 'Garlic',
        strMeasure9: '3 cloves',
        strIngredient10: 'Onion',
        strMeasure10: '1 large',
        strIngredient11: 'Tomato',
        strMeasure11: '2',
        strIngredient12: 'Basil',
        strMeasure12: 'handful',
        strIngredient13: 'Oregano',
        strMeasure13: '1 tsp',
        strIngredient14: 'Thyme',
        strMeasure14: '1/2 tsp',
        strIngredient15: 'Cumin',
        strMeasure15: '1 tsp',
        strIngredient16: 'Paprika',
        strMeasure16: '1 tsp',
        strIngredient17: 'Vinegar',
        strMeasure17: '1 tbsp',
        strIngredient18: 'Honey',
        strMeasure18: '2 tbsp',
        strIngredient19: 'Lemon',
        strMeasure19: '1',
        strIngredient20: 'Parsley',
        strMeasure20: 'handful',
      );

      final ingredients = dto.toMealEntity().ingredients;

      expectIngredient(ingredients[0], 'Flour', '2 cups');
      expectIngredient(ingredients[1], 'Sugar', '1 cup');
      expectIngredient(ingredients[2], 'Eggs', '3');
      expectIngredient(ingredients[3], 'Butter', '100g');
      expectIngredient(ingredients[4], 'Milk', '200ml');
      expectIngredient(ingredients[5], 'Salt', '1 tsp');
      expectIngredient(ingredients[6], 'Pepper', '1/2 tsp');
      expectIngredient(ingredients[7], 'Oil', '2 tbsp');
      expectIngredient(ingredients[8], 'Garlic', '3 cloves');
      expectIngredient(ingredients[9], 'Onion', '1 large');
      expectIngredient(ingredients[10], 'Tomato', '2');
      expectIngredient(ingredients[11], 'Basil', 'handful');
      expectIngredient(ingredients[12], 'Oregano', '1 tsp');
      expectIngredient(ingredients[13], 'Thyme', '1/2 tsp');
      expectIngredient(ingredients[14], 'Cumin', '1 tsp');
      expectIngredient(ingredients[15], 'Paprika', '1 tsp');
      expectIngredient(ingredients[16], 'Vinegar', '1 tbsp');
      expectIngredient(ingredients[17], 'Honey', '2 tbsp');
      expectIngredient(ingredients[18], 'Lemon', '1');
      expectIngredient(ingredients[19], 'Parsley', 'handful');
    });

    test('falls back to empty string for null ingredient', () {
      final result = buildMealDto(
        strIngredient1: null,
        strMeasure1: '1 cup',
      ).toMealEntity();
      expectIngredient(result.ingredients[0], '', '1 cup');
    });

    test('falls back to empty string for null measure', () {
      final result = buildMealDto(
        strIngredient1: 'Flour',
        strMeasure1: null,
      ).toMealEntity();
      expectIngredient(result.ingredients[0], 'Flour', '');
    });

    test(
      'falls back to empty strings for both null ingredient and measure',
      () {
        final result = buildMealDto().toMealEntity();
        for (final entry in result.ingredients) {
          expectIngredient(entry, '', '');
        }
      },
    );

    test('preserves order — ingredient index matches measure index', () {
      final dto = buildMealDto(
        strIngredient1: 'A',
        strMeasure1: 'MA',
        strIngredient2: 'B',
        strMeasure2: 'MB',
      );
      final ingredients = dto.toMealEntity().ingredients;

      expect(ingredients[0].key, 'A');
      expect(ingredients[0].value, 'MA');
      expect(ingredients[1].key, 'B');
      expect(ingredients[1].value, 'MB');
    });
  });
}
