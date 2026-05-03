import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:super_fitness/core/widgets/lottie_error.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/presentation/meals/view_model/meals_intent.dart';
import 'package:super_fitness/features/meals/presentation/meals/view_model/meals_view_model.dart';
import 'package:super_fitness/features/meals/presentation/meals/widgets/meals_by_category/meal_recommendation_card.dart';
import 'package:super_fitness/features/meals/presentation/meals/widgets/meals_async_placeholder.dart';

class GetMealsByCategoryBlocBuilder extends StatelessWidget {
  const GetMealsByCategoryBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealsViewModel, MealsState>(
      buildWhen: (previous, current) =>
          previous.mealsState != current.mealsState ||
          previous.selectedCategoryIndex != current.selectedCategoryIndex,
      builder: (context, state) {
        if (state.mealsState.isInitial || state.mealsState.isLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Skeletonizer(
              enabled: true,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) => MealRecommendationCard(
                  meal: state.mealsState.data?[index] ?? MealEntity(),
                  onTap: () {},
                ),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
              ),
            ),
          );
        }
        if (state.mealsState.isError) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: LottieError(
              message:
                  state.mealsState.errorMessage ?? 'meals.meals_error'.tr(),
              onRetry: () => context.read<MealsViewModel>().doIntent(
                const GetMealsByCategoryIntent(),
              ),
            ),
          );
        }
        if (state.mealsState.isLoaded) {
          final list = state.mealsState.data ?? <MealEntity>[];
          if (list.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(top: 24),
              child: MealsInfoMessage(messageKey: 'meals.no_meals'),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return MealRecommendationCard(
                  meal: list[index],
                  onTap: () => context.read<MealsViewModel>().doIntent(
                    MealCardClickedIntent(list[index]),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
