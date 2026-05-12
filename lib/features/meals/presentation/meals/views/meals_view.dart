import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/core/widgets/super_fitness_app_bar.dart';
import 'package:super_fitness/features/meals/presentation/meals/view_model/meals_intent.dart';
import 'package:super_fitness/features/meals/presentation/meals/view_model/meals_view_model.dart';
import 'package:super_fitness/features/meals/presentation/meals/widgets/meals_by_category/get_meals_by_category_bloc_builder.dart';
import 'package:super_fitness/features/meals/presentation/meals/widgets/meals_categories/get_meals_categories_bloc_builder.dart';

class MealsView extends StatefulWidget {
  const MealsView({super.key});

  @override
  State<MealsView> createState() => _MealsViewState();
}

class _MealsViewState extends State<MealsView> {
  StreamSubscription<MealsUIEvents>? _uiEventsSubscription;

  @override
  void initState() {
    super.initState();
    _listenToUIEvents();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<MealsViewModel>().doIntent(const GetMealsCategoriesIntent());
    });
  }

  void _listenToUIEvents() {
    _uiEventsSubscription = context
        .read<MealsViewModel>()
        .uiEventsStream
        .listen((event) {
          if (!mounted) return;
          switch (event) {
            case NavigateToMealsDetails():
              Navigator.pushNamed(
                context,
                AppRoutes.mealDetails,
                arguments: [event.meal.id, event.meals],
              );
          }
        });
  }

  @override
  void dispose() {
    _uiEventsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SuperFitnessAppBar(
        title: 'meals.food_recommendation'.tr(),
        showBack: true,
      ),
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      body: RefreshIndicator(
        onRefresh: () async => context.read<MealsViewModel>().doIntent(
          const GetMealsCategoriesIntent(),
        ),
        child: ScreenBackdrop(
          image: AssetsManager.homeBackground,
          child: const SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GetMealsCategoriesBlocBuilder(),
                  GetMealsByCategoryBlocBuilder(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
