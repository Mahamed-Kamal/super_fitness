import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/features/auth/presentation/widget/select_goal_and_level_widget.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  String _selectedLevel = "";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "your regular physical".tr(),
            style: context.appTheme.semiBold24,
          ),

          Text(
            "activity level ?".tr(),
            style: context.appTheme.regular14,
            textAlign: TextAlign.center,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              child: GlassContainer(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 1,
                          vertical: 20,
                        ),
                        children: [
                          _buildGoalItem("Rookie", "level1"),
                          _buildGoalItem("Beginner", "level2"),
                          _buildGoalItem("Intermediate", "level3"),
                          _buildGoalItem("Advanced", "level4"),
                          _buildGoalItem("True Beast", "level5"),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _selectedLevel.isEmpty ? null : () => {},
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

  Widget _buildGoalItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SelectGoalAndLevelWidget(
        title: title,
        isSelected: _selectedLevel == title,
        onTap: () => setState(() => _selectedLevel = title),
      ),
    );
  }
}
