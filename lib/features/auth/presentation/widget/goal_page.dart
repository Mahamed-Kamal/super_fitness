import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/features/auth/presentation/widget/select_goal_and_level_widget.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  String _selectedGoal = "";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("what_is_your_goal".tr(), style: context.appTheme.semiBold24),

          Text(
            "this_helps_us_to_create_a_personalized_plan".tr(),
            style: context.appTheme.regular14,
            textAlign: TextAlign.center,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
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
                        children: [
                          _buildGoalItem("Gain Weight"),
                          _buildGoalItem("Lose Weight"),
                          _buildGoalItem("Get Fitter"),
                          _buildGoalItem("Gain More Flexible"),
                          _buildGoalItem("Learn The Basics"),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _selectedGoal.isEmpty
                            ? null
                            : () => widget.pageController.animateToPage(
                                6,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
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

  Widget _buildGoalItem(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SelectGoalAndLevelWidget(
        title: title,
        isSelected: _selectedGoal == title,
        onTap: () => setState(() => _selectedGoal = title),
      ),
    );
  }
}
