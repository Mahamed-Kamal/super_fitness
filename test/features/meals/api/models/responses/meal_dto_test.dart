import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/meals/api/models/responses/meal_dto.dart';

void main() {
  group('MealDto', () {
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

    Map<String, dynamic> emptyMealJson() => {
      "idMeal": null,
      "strMeal": null,
      "strMealAlternate": null,
      "strCategory": null,
      "strArea": null,
      "strInstructions": null,
      "strMealThumb": null,
      "strTags": null,
      "strYoutube": null,
      "strIngredient1": null,
      "strIngredient2": null,
      "strIngredient3": null,
      "strIngredient4": null,
      "strIngredient5": null,
      "strIngredient6": null,
      "strIngredient7": null,
      "strIngredient8": null,
      "strIngredient9": null,
      "strIngredient10": null,
      "strIngredient11": null,
      "strIngredient12": null,
      "strIngredient13": null,
      "strIngredient14": null,
      "strIngredient15": null,
      "strIngredient16": null,
      "strIngredient17": null,
      "strIngredient18": null,
      "strIngredient19": null,
      "strIngredient20": null,
      "strMeasure1": null,
      "strMeasure2": null,
      "strMeasure3": null,
      "strMeasure4": null,
      "strMeasure5": null,
      "strMeasure6": null,
      "strMeasure7": null,
      "strMeasure8": null,
      "strMeasure9": null,
      "strMeasure10": null,
      "strMeasure11": null,
      "strMeasure12": null,
      "strMeasure13": null,
      "strMeasure14": null,
      "strMeasure15": null,
      "strMeasure16": null,
      "strMeasure17": null,
      "strMeasure18": null,
      "strMeasure19": null,
      "strMeasure20": null,
      "strSource": null,
      "strImageSource": null,
      "strCreativeCommonsConfirmed": null,
      "dateModified": null,
    };

    group('fromJson', () {
      test('parses all fields correctly from full JSON', () {
        final meal = MealDto.fromJson(fullMealJson());

        expect(meal.idMeal, '52772');
        expect(meal.strMeal, 'Teriyaki Chicken Casserole');
        expect(meal.strMealAlternate, isNull);
        expect(meal.strCategory, 'Chicken');
        expect(meal.strArea, 'Japanese');
        expect(meal.strInstructions, 'Preheat oven to 350° F.');
        expect(
          meal.strMealThumb,
          'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg',
        );
        expect(meal.strTags, 'Meat,Casserole');
        expect(meal.strYoutube, 'https://www.youtube.com/watch?v=4aZr5hZXP_s');
        expect(meal.strIngredient1, 'soy sauce');
        expect(meal.strIngredient2, 'water');
        expect(meal.strIngredient3, 'brown sugar');
        expect(meal.strIngredient4, 'ground ginger');
        expect(meal.strIngredient5, 'minced garlic');
        expect(meal.strIngredient6, 'cornstarch');
        expect(meal.strIngredient7, 'chicken breasts');
        expect(meal.strIngredient8, 'stir-fry vegetables');
        expect(meal.strIngredient9, 'brown rice');
        expect(meal.strIngredient10, '');
        expect(meal.strIngredient11, '');
        expect(meal.strIngredient16, isNull);
        expect(meal.strIngredient20, isNull);
        expect(meal.strMeasure1, '3/4 cup');
        expect(meal.strMeasure2, '1/2 cup');
        expect(meal.strMeasure9, '3 cups');
        expect(meal.strMeasure10, '');
        expect(meal.strMeasure16, isNull);
        expect(meal.strMeasure20, isNull);
        expect(meal.strSource, 'https://www.somerecipe.com');
        expect(meal.strImageSource, isNull);
        expect(meal.strCreativeCommonsConfirmed, isNull);
        expect(meal.dateModified, isNull);
      });

      test('all fields are null when JSON contains only nulls', () {
        final meal = MealDto.fromJson(emptyMealJson());

        expect(meal.idMeal, isNull);
        expect(meal.strMeal, isNull);
        expect(meal.strMealAlternate, isNull);
        expect(meal.strCategory, isNull);
        expect(meal.strArea, isNull);
        expect(meal.strInstructions, isNull);
        expect(meal.strMealThumb, isNull);
        expect(meal.strTags, isNull);
        expect(meal.strYoutube, isNull);
        expect(meal.strIngredient1, isNull);
        expect(meal.strIngredient20, isNull);
        expect(meal.strMeasure1, isNull);
        expect(meal.strMeasure20, isNull);
        expect(meal.strSource, isNull);
        expect(meal.strImageSource, isNull);
        expect(meal.strCreativeCommonsConfirmed, isNull);
        expect(meal.dateModified, isNull);
      });

      test('handles dynamic fields with non-null values', () {
        final json = emptyMealJson()
          ..['strMealAlternate'] = 'Alternate Name'
          ..['strTags'] = ['tag1', 'tag2']
          ..['strCreativeCommonsConfirmed'] = true;

        final meal = MealDto.fromJson(json);

        expect(meal.strMealAlternate, 'Alternate Name');
        expect(meal.strTags, ['tag1', 'tag2']);
        expect(meal.strCreativeCommonsConfirmed, true);
      });

      test('parses from empty JSON map — all fields default to null', () {
        final meal = MealDto.fromJson({});

        expect(meal.idMeal, isNull);
        expect(meal.strMeal, isNull);
        expect(meal.strIngredient1, isNull);
        expect(meal.strMeasure1, isNull);
      });
    });

    group('toJson', () {
      test('serializes all non-null fields correctly', () {
        final meal = MealDto.fromJson(fullMealJson());
        final json = meal.toJson();

        expect(json['idMeal'], '52772');
        expect(json['strMeal'], 'Teriyaki Chicken Casserole');
        expect(json['strCategory'], 'Chicken');
        expect(json['strArea'], 'Japanese');
        expect(json['strIngredient1'], 'soy sauce');
        expect(json['strMeasure1'], '3/4 cup');
        expect(json['strSource'], 'https://www.somerecipe.com');
      });

      test('serializes null fields as null', () {
        final meal = MealDto.fromJson(emptyMealJson());
        final json = meal.toJson();

        expect(json['idMeal'], isNull);
        expect(json['strMeal'], isNull);
        expect(json['strIngredient1'], isNull);
        expect(json['strMeasure1'], isNull);
        expect(json['strSource'], isNull);
        expect(json['dateModified'], isNull);
      });

      test('toJson output can round-trip back through fromJson', () {
        final original = MealDto.fromJson(fullMealJson());
        final roundTripped = MealDto.fromJson(original.toJson());

        expect(roundTripped.idMeal, original.idMeal);
        expect(roundTripped.strMeal, original.strMeal);
        expect(roundTripped.strCategory, original.strCategory);
        expect(roundTripped.strIngredient1, original.strIngredient1);
        expect(roundTripped.strMeasure1, original.strMeasure1);
        expect(roundTripped.strSource, original.strSource);
      });
    });

    group('constructor', () {
      test('creates instance with all fields provided', () {
        final meal = MealDto(
          idMeal: '1',
          strMeal: 'Pizza',
          strCategory: 'Italian',
          strArea: 'Italy',
          strIngredient1: 'Dough',
          strMeasure1: '1 cup',
        );

        expect(meal.idMeal, '1');
        expect(meal.strMeal, 'Pizza');
        expect(meal.strCategory, 'Italian');
        expect(meal.strIngredient1, 'Dough');
        expect(meal.strMeasure1, '1 cup');
      });

      test('creates instance with no fields — all default to null', () {
        final meal = MealDto();

        expect(meal.idMeal, isNull);
        expect(meal.strMeal, isNull);
        expect(meal.strCategory, isNull);
        expect(meal.strIngredient1, isNull);
        expect(meal.strMeasure1, isNull);
      });
    });
  });
}
