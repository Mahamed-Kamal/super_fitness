import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/theme/fonts/my_font_weight.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/features/auth/domain/entities/activity_level.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';
import 'package:super_fitness/features/auth/presentation/widget/select_goal_and_level_widget.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({super.key});

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  ActivityLevel? _selectedLevel;

  final Map<String, ActivityLevel> _levelOptions = {
    'rookie'.tr(): ActivityLevel.rookie,
    'beginner'.tr(): ActivityLevel.beginner,
    'intermediate'.tr(): ActivityLevel.intermediate,
    'advanced'.tr(): ActivityLevel.advanced,
    'expert'.tr(): ActivityLevel.expert,
  };

  @override
  void initState() {
    super.initState();
    final savedLevel = context
        .read<RegisterViewModel>()
        .state
        .formData
        .activityLevel;
    if (savedLevel.isNotEmpty) {
      _selectedLevel = ActivityLevel.values.byName(savedLevel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterViewModel, RegisterState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "your_regular_physical".tr(),
                style: context.appTheme.semiBold24.copyWith(
                  fontWeight: MyFontWeight.extraBold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
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
                            children: _levelOptions.entries
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: SelectGoalAndLevelWidget(
                                      title: e.key,
                                      isSelected: _selectedLevel == e.value,
                                      onTap: () => setState(
                                        () => _selectedLevel = e.value,
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
                          child: state.requestState == RequestState.loading
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: _selectedLevel == null
                                      ? null
                                      : () => context
                                            .read<RegisterViewModel>()
                                            .doIntent(
                                              FinishRegisterIntent(
                                                activityLevel: _selectedLevel!,
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
      },
    );
  }
}
