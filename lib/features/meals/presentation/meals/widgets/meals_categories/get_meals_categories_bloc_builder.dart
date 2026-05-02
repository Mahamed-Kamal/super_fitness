import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/extensions/context_spacing_extension.dart';
import 'package:super_fitness/core/widgets/lottie_error.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_category_entity.dart';
import 'package:super_fitness/features/meals/presentation/meals/view_model/meals_intent.dart';
import 'package:super_fitness/features/meals/presentation/meals/view_model/meals_view_model.dart';
import 'package:super_fitness/features/meals/presentation/meals/widgets/meals_async_placeholder.dart';
import 'package:super_fitness/features/meals/presentation/meals/widgets/meals_categories/meals_category_pill.dart';

class GetMealsCategoriesBlocBuilder extends StatelessWidget {
  const GetMealsCategoriesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsViewModel, MealsState>(
      buildWhen: (previous, current) =>
          previous.categoriesState != current.categoriesState ||
          previous.selectedCategoryIndex != current.selectedCategoryIndex,
      builder: (context, state) {
        if (state.categoriesState.isInitial ||
            state.categoriesState.isLoading) {
          return const MealsAsyncLoading(
            messageKey: 'meals.loading_categories',
          );
        }
        if (state.categoriesState.isError) {
          return LottieError(
            message: state.categoriesState.errorMessage ?? "",
            onRetry: () => context.read<MealsViewModel>().doIntent(
              const GetMealsCategoriesIntent(),
            ),
          );
        }
        if (state.categoriesState.isLoaded) {
          final listCategories =
              state.categoriesState.data ?? <MealCategoryEntity>[];
          if (listCategories.isEmpty) {
            return const MealsInfoMessage(messageKey: 'meals.no_categories');
          }
          return _MealsCategoryStrip(state: state, categories: listCategories);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _MealsCategoryStrip extends StatelessWidget {
  final MealsState state;
  final List<MealCategoryEntity> categories;

  const _MealsCategoryStrip({required this.state, required this.categories});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<MealsViewModel>();
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        itemCount: categories.length,
        separatorBuilder: (_, _) => context.w(12),
        itemBuilder: (context, index) {
          return MealsCategoryPill(
            label: categories[index].name,
            selected: state.selectedCategoryIndex == index,
            onTap: () => viewModel.doIntent(SelectMealCategoryIntent(index)),
          );
        },
      ),
    );
  }
}
