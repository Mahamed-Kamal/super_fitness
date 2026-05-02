import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_details_response_dto.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_dto.dart';

void main() {
  Map<String, dynamic> fullMealJson() => {
    "idMeal": "52772",
    "strMeal": "Teriyaki Chicken Casserole",
    "strMealAlternate": null,
    "strCategory": "Chicken",
    "strArea": "Japanese",
    "strInstructions": "Preheat oven to 350° F.",
    "strMealThumb":
        "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
    "strTags": "Meat,Casserole",
    "strYoutube": "https://www.youtube.com/watch?v=4aZr5hZXP_s",
    "strIngredient1": "soy sauce",
    "strIngredient2": "water",
    "strIngredient3": "brown sugar",
    "strIngredient4": "ground ginger",
    "strIngredient5": "minced garlic",
    "strIngredient6": "cornstarch",
    "strIngredient7": "chicken breasts",
    "strIngredient8": "stir-fry vegetables",
    "strIngredient9": "brown rice",
    "strIngredient10": "",
    "strIngredient11": "",
    "strIngredient12": "",
    "strIngredient13": "",
    "strIngredient14": "",
    "strIngredient15": "",
    "strIngredient16": null,
    "strIngredient17": null,
    "strIngredient18": null,
    "strIngredient19": null,
    "strIngredient20": null,
    "strMeasure1": "3/4 cup",
    "strMeasure2": "1/2 cup",
    "strMeasure3": "1/4 cup",
    "strMeasure4": "1/2 teaspoon",
    "strMeasure5": "1/2 teaspoon",
    "strMeasure6": "4 Tablespoons",
    "strMeasure7": "2",
    "strMeasure8": "1 package",
    "strMeasure9": "3 cups",
    "strMeasure10": "",
    "strMeasure11": "",
    "strMeasure12": "",
    "strMeasure13": "",
    "strMeasure14": "",
    "strMeasure15": "",
    "strMeasure16": null,
    "strMeasure17": null,
    "strMeasure18": null,
    "strMeasure19": null,
    "strMeasure20": null,
    "strSource": "https://www.somerecipe.com",
    "strImageSource": null,
    "strCreativeCommonsConfirmed": null,
    "dateModified": null,
  };

  group('MealDetailsResponseDto', () {
    group('fromJson', () {
      test('parses a list with one meal correctly', () {
        final json = {
          "meals": [fullMealJson()],
        };

        final response = MealDetailsResponseDto.fromJson(json);

        expect(response.meals, isNotNull);
        expect(response.meals!.length, 1);
        expect(response.meals!.first.idMeal, '52772');
        expect(response.meals!.first.strMeal, 'Teriyaki Chicken Casserole');
      });

      test('parses a list with multiple meals', () {
        final json = {
          "meals": [fullMealJson(), fullMealJson()],
        };

        final response = MealDetailsResponseDto.fromJson(json);

        expect(response.meals, isNotNull);
        expect(response.meals!.length, 2);
      });

      test('parses an empty meals list', () {
        final response = MealDetailsResponseDto.fromJson({"meals": []});

        expect(response.meals, isNotNull);
        expect(response.meals, isEmpty);
      });

      test('parses null meals field as null', () {
        final response = MealDetailsResponseDto.fromJson({"meals": null});

        expect(response.meals, isNull);
      });

      test('parses from empty JSON map — meals defaults to null', () {
        final response = MealDetailsResponseDto.fromJson({});

        expect(response.meals, isNull);
      });
    });

    group('toJson', () {
      test('serializes empty meals list', () {
        final response = MealDetailsResponseDto(meals: []);
        final json = response.toJson();

        expect(json['meals'], isA<List>());
        expect((json['meals'] as List), isEmpty);
      });

      test('serializes null meals as null', () {
        final response = MealDetailsResponseDto(meals: null);
        final json = response.toJson();

        expect(json['meals'], isNull);
      });
    });
    test('serializes meals list correctly', () {
      final response = MealDetailsResponseDto(
        meals: [MealDto.fromJson(fullMealJson())],
      );

      final json = response.toJson();
      final mealsList = (json['meals'] as List)
          .map((e) => (e as MealDto).toJson())
          .toList();

      expect(mealsList, isA<List>());
      expect(mealsList.length, 1);
      expect(mealsList.first['idMeal'], '52772');
    });

    test('toJson output can round-trip back through fromJson', () {
      final original = MealDetailsResponseDto(
        meals: [MealDto.fromJson(fullMealJson())],
      );

      // Manually serialize the meals list before passing to fromJson
      final serializedJson = {
        'meals': original.meals!.map((e) => e.toJson()).toList(),
      };

      final roundTripped = MealDetailsResponseDto.fromJson(serializedJson);

      expect(roundTripped.meals, isNotNull);
      expect(roundTripped.meals!.length, original.meals!.length);
      expect(roundTripped.meals!.first.idMeal, original.meals!.first.idMeal);
    });

    group('constructor', () {
      test('creates instance with meals list', () {
        final meals = [MealDto(idMeal: '1', strMeal: 'Pizza')];
        final response = MealDetailsResponseDto(meals: meals);

        expect(response.meals, isNotNull);
        expect(response.meals!.length, 1);
        expect(response.meals!.first.strMeal, 'Pizza');
      });

      test('creates instance with null meals', () {
        final response = MealDetailsResponseDto();

        expect(response.meals, isNull);
      });
    });
  });
}
