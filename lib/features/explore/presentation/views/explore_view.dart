import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/sliver_extension.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/screen_image_background.dart';
import 'package:super_fitness/features/explore/presentation/widgets/fitness_categories.dart';
import 'package:super_fitness/features/explore/presentation/widgets/recommendation_today.dart';
import 'package:super_fitness/features/explore/presentation/widgets/upcoming_workouts.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenImageBackground(
      imagePath: AssetsManager.exploreBg,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("hi Omar"),
                subtitle: Text("Let’s start your day"),
                trailing: CircleAvatar(),
              ),
            ),
            const SizedBox(height: 24).toSliver,
            const _SessionWidget(title: "Category", widget: Categories()),
            const SizedBox(height: 24).toSliver,
            const _SessionWidget(
              title: "Recommendation to day",
              widget: RecommendationToDay(),
            ),
            const SizedBox(height: 24).toSliver,
            _SessionWidget(
              title: "Upcoming Workouts",

              widget: UpcomingWorkout(),
            ),
            const SizedBox(height: 8).toSliver,
            const RecommendationToDay().toSliver,
            const SizedBox(height: 24).toSliver,
            _SessionWidget(
              title: "Recommendation For You",
              widget: RecommendationToDay(),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionWidget extends StatelessWidget {
  final String title;
  final Widget widget;
  final void Function()? onTap;

  const _SessionWidget({required this.title, required this.widget, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: theme.semiBold16),
            if (onTap != null)
              GestureDetector(
                onTap: onTap,
                child: Text(
                  "See All",
                  style: theme.regular14.copyWith(
                    decoration: TextDecoration.underline,
                    color: theme.primary,
                    decorationColor: theme.primary,
                  ),
                ),
              ),
          ],
        ),
        widget,
      ],
    ).toSliver;
  }
}
