import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/context_spacing_extension.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/theme/fonts/my_font_weight.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/core/widgets/super_fitness_app_bar.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';
import 'package:super_fitness/features/auth/presentation/widget/select_goal_and_level_widget.dart';

class EditGoalSelectionPage extends StatefulWidget {
  final UserGoal initialGoal;

  const EditGoalSelectionPage({super.key, required this.initialGoal});

  @override
  State<EditGoalSelectionPage> createState() => _EditGoalSelectionPageState();
}

class _EditGoalSelectionPageState extends State<EditGoalSelectionPage> {
  late UserGoal _selectedGoal;
  late final Map<String, UserGoal> _goalOptions;

  @override
  void initState() {
    super.initState();
    _selectedGoal = widget.initialGoal;
    _goalOptions = {
      "gain_weight".tr(): UserGoal.gainWeight,
      "lose_weight".tr(): UserGoal.loseWeight,
      "get_fitter".tr(): UserGoal.getFitter,
      "gain_more_flexible".tr(): UserGoal.gainMoreFlexible,
      "learn_the_basics".tr(): UserGoal.learnTheBasics,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SuperFitnessAppBar(logo: AssetsManager.appLogoSvg),

      body: ScreenBackdrop(
        image: AssetsManager.homeBackground,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "what_is_your_goal".tr(),
                  style: context.appTheme.semiBold24.copyWith(
                    fontWeight: MyFontWeight.extraBold,
                  ),
                ),
                context.h(8),
                Text(
                  "personalized_plan_subtitle".tr(),
                  style: context.appTheme.regular14,
                ),
                context.h(16),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: GlassContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 1,
                                vertical: 20,
                              ),
                              children: _goalOptions.entries
                                  .map(
                                    (entry) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12,
                                      ),
                                      child: SelectGoalAndLevelWidget(
                                        title: entry.key,
                                        isSelected:
                                            _selectedGoal == entry.value,
                                        onTap: () => setState(
                                          () => _selectedGoal = entry.value,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () =>
                                  Navigator.pop(context, _selectedGoal),
                              child: Text("done".tr()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditLevelSelectionPage extends StatefulWidget {
  final ActivityLevel initialLevel;

  const EditLevelSelectionPage({super.key, required this.initialLevel});

  @override
  State<EditLevelSelectionPage> createState() => _EditLevelSelectionPageState();
}

class _EditLevelSelectionPageState extends State<EditLevelSelectionPage> {
  late ActivityLevel _selectedLevel;
  late final Map<String, ActivityLevel> _levelOptions;

  @override
  void initState() {
    super.initState();
    _selectedLevel = widget.initialLevel;
    _levelOptions = {
      "rookie".tr(): ActivityLevel.rookie,
      "beginner".tr(): ActivityLevel.beginner,
      "intermediate".tr(): ActivityLevel.intermediate,
      "advanced".tr(): ActivityLevel.advanced,
      "expert".tr(): ActivityLevel.expert,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SuperFitnessAppBar(logo: AssetsManager.appLogoSvg),
      body: ScreenBackdrop(
        image: AssetsManager.homeBackground,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "your_regular_physical".tr(),
                  style: context.appTheme.semiBold24.copyWith(
                    fontWeight: MyFontWeight.extraBold,
                  ),
                ),
                context.h(16),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: GlassContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 1,
                                vertical: 20,
                              ),
                              children: _levelOptions.entries
                                  .map(
                                    (entry) => Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12,
                                      ),
                                      child: SelectGoalAndLevelWidget(
                                        title: entry.key,
                                        isSelected:
                                            _selectedLevel == entry.value,
                                        onTap: () => setState(
                                          () => _selectedLevel = entry.value,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () =>
                                  Navigator.pop(context, _selectedLevel),
                              child: Text("done".tr()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
