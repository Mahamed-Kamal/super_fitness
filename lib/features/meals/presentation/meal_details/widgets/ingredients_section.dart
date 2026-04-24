import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/ingredient_row.dart';

class IngredientsSection extends StatelessWidget {
  final List<MapEntry<String, String>> ingredients;

  const IngredientsSection({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final validIngredients = ingredients
        .where((entry) => entry.key.trim().isNotEmpty)
        .toList();

    if (ingredients.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text('No ingredients available.'),
      );
    } else {
      return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: validIngredients.length,
        separatorBuilder: (_, _) => Divider(
          color: context.appTheme.borderMuted,
          height: 1,
          thickness: 1,
        ),
        itemBuilder: (_, index) {
          final entry = validIngredients[index];
          return IngredientRow(name: entry.key, measure: entry.value);
        },
      );
    }
  }
}
