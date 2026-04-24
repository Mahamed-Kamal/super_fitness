import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/features/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/circle_back_button.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/collapsed_app_bar.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/hero_sliver.dart';
import 'package:super_fitness/features/meals/presentation/meal_details/widgets/instructions_section.dart';

import 'ingredients_section.dart';

class MealDetailBody extends StatefulWidget {
  final MealEntity meal;

  const MealDetailBody({super.key, required this.meal});

  @override
  State<MealDetailBody> createState() => _MealDetailBodyState();
}

class _MealDetailBodyState extends State<MealDetailBody>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  static const double _heroHeight = 320.0;
  static const double _collapsedBarHeight = 56.0;

  bool _showAppBar = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
  }

  void _onScroll() {
    final shouldShow =
        _scrollController.offset > _heroHeight - _collapsedBarHeight - 20;
    if (shouldShow != _showAppBar) {
      setState(() => _showAppBar = shouldShow);
      shouldShow ? _fadeController.forward() : _fadeController.reverse();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScreenBackdrop(
    containerColor: Color(0x73000000),
    image: AssetsManager.homeBackground,
    child: Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            HeroSliver(meal: widget.meal, heroHeight: _heroHeight),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ingredients',
                      style: context.appTheme.semiBold18.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GlassContainer(
                      child: IngredientsSection(
                        ingredients: widget.meal.ingredients,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Instructions',
                      style: context.appTheme.semiBold18.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (widget.meal.instructions.isNotEmpty)
                      GlassContainer(
                        child: InstructionsSection(
                          text: widget.meal.instructions,
                        ),
                      ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: CollapsedAppBar(title: widget.meal.title),
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          child: CircleBackButton(),
        ),
      ],
    ),
  );
}
