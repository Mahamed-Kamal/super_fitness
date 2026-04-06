import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/theme/fonts/my_font_weight.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/features/auth/domain/entities/user_goal.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/features/auth/presentation/widget/select_goal_and_level_widget.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  UserGoal? _selectedGoal;

  final Map<String, UserGoal> _goalOptions = {
    'gain_weight'.tr(): UserGoal.gainWeight,
    'lose_weight'.tr(): UserGoal.loseWeight,
    'get_fitter'.tr(): UserGoal.getFitter,
    'gain_more_flexible'.tr(): UserGoal.gainMoreFlexible,
    'learn_the_basics'.tr(): UserGoal.learnTheBasics,
  };

  @override
  void initState() {
    super.initState();
    final savedGoal = context.read<RegisterViewModel>().state.formData.goal;
    if (savedGoal.isNotEmpty) {
      _selectedGoal = _goalOptions.values.firstWhere(
        (g) => g.name == savedGoal,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "what_is_your_goal".tr(),
            style: context.appTheme.semiBold24.copyWith(
              fontWeight: MyFontWeight.extraBold,
            ),
          ),
          Text(
            "personalized_plan_subtitle".tr(),
            style: context.appTheme.regular14,
          ),
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
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: SelectGoalAndLevelWidget(
                                  title: e.key,
                                  isSelected: _selectedGoal == e.value,
                                  onTap: () =>
                                      setState(() => _selectedGoal = e.value),
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
                        onPressed: _selectedGoal == null
                            ? null
                            : () => context.read<RegisterViewModel>().doIntent(
                                SwitchViewToSelectActivityLevel(
                                  goal: _selectedGoal!,
                                ),
                              ),
                        child: Text("next".tr()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
