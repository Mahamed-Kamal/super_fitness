import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';

void main() {
  void expectIngredient(
    MapEntry<String, String> entry,
    String key,
    String value,
  ) {
    expect(entry.key, key);
    expect(entry.value, value);
  }

  group('MealEntity', () {
    // ─── Default constructor ────────────────────────────────────────────────

    test('creates instance with default values', () {
      const entity = MealEntity();

      expect(entity.title, '');
      expect(entity.instructions, '');
      expect(entity.image, '');
      expect(entity.ingredients, isEmpty);
    });

    test('creates instance with provided values', () {
      final entity = MealEntity(
        title: 'Pizza',
        instructions: 'Bake it',
        image: 'https://img.com/pizza.jpg',
        ingredients: [MapEntry('Flour', '2 cups')],
      );

      expect(entity.title, 'Pizza');
      expect(entity.instructions, 'Bake it');
      expect(entity.image, 'https://img.com/pizza.jpg');
      expect(entity.ingredients.length, 1);
      expectIngredient(entity.ingredients[0], 'Flour', '2 cups');
    });

    // ─── Equatable equality ─────────────────────────────────────────────────

    test('two instances with same scalar values are equal', () {
      const a = MealEntity(title: 'Pizza', instructions: 'Bake', image: 'img');
      const b = MealEntity(title: 'Pizza', instructions: 'Bake', image: 'img');

      expect(a, equals(b));
    });

    test('two instances with different title are not equal', () {
      const a = MealEntity(title: 'Pizza');
      const b = MealEntity(title: 'Burger');

      expect(a, isNot(equals(b)));
    });

    test('two instances with different instructions are not equal', () {
      const a = MealEntity(instructions: 'Bake');
      const b = MealEntity(instructions: 'Fry');

      expect(a, isNot(equals(b)));
    });

    test('two instances with different image are not equal', () {
      const a = MealEntity(image: 'img1.jpg');
      const b = MealEntity(image: 'img2.jpg');

      expect(a, isNot(equals(b)));
    });

    // ─── Ingredients equality ───────────────────────────────────────────────
    // Note: List<MapEntry> equality depends on list identity in Equatable,
    // since MapEntry doesn't implement ==. These tests document that behavior.

    test('same ingredients list instance is equal', () {
      final ingredients = [MapEntry('Flour', '2 cups')];
      final a = MealEntity(ingredients: ingredients);
      final b = MealEntity(ingredients: ingredients);

      expect(a, equals(b));
    });

    test('empty ingredients list is equal across instances', () {
      const a = MealEntity(ingredients: []);
      const b = MealEntity(ingredients: []);

      expect(a, equals(b));
    });

    // ─── props ──────────────────────────────────────────────────────────────

    test('props contains all four fields', () {
      final ingredients = [MapEntry('Flour', '2 cups')];
      final entity = MealEntity(
        title: 'Pizza',
        instructions: 'Bake',
        image: 'img.jpg',
        ingredients: ingredients,
      );

      expect(entity.props, ['Pizza', 'Bake', 'img.jpg', ingredients]);
    });

    test('default instance props are all empty', () {
      const entity = MealEntity();
      expect(entity.props, ['', '', '', <MapEntry<String, String>>[]]);
    });
  });
}
