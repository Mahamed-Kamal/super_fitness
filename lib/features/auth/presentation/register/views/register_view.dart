import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/core/widgets/show_toast.dart';
import 'package:super_fitness/core/widgets/super_fitness_app_bar.dart';
import 'package:super_fitness/features/auth/presentation/widget/age_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/gender_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/goal_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/height_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/level_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/register_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/step_progress_indicator.dart';
import 'package:super_fitness/features/auth/presentation/widget/weight_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_event.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RegisterViewModel>().eventStream.listen((event) {
        if (!mounted) return;
        switch (event) {
          case NavigateFromRegisterToLoginEvent():
            Navigator.pop(context);
          case UserRegisterFailedEvent():
            Toast.showToast(context, event.message, isError: true);
          case RegisterCompletedEvent():
            Toast.showToast(context, 'registration_successful'.tr());
            Navigator.pop(context);
        }
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.read<RegisterViewModel>().doIntent(RegisterStepNavBackIntent());
      },
      child: BlocListener<RegisterViewModel, RegisterState>(
        listenWhen: (prev, curr) => prev.currentStep != curr.currentStep,
        listener: (context, state) {
          if (pageController.hasClients) {
            pageController.animateToPage(
              state.currentStep,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        },
        child: BlocBuilder<RegisterViewModel, RegisterState>(
          builder: (context, state) {
            return Scaffold(
              body: ScreenBackdrop(
                image: AssetsManager.authBackground,
                child: Column(
                  children: [
                    SuperFitnessAppBar(
                      showBack: true,
                      logo: AssetsManager.appLogoSvg,
                      leading: state.currentStep > 0
                          ? IconButton(
                              onPressed: () => context
                                  .read<RegisterViewModel>()
                                  .doIntent(RegisterStepNavBackIntent()),
                              icon: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context.appTheme.primary,
                                ),
                                child: SvgPicture.asset(
                                  AssetsManager.icBackSvg,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),

                    if (state.currentStep > 0) ...[
                      const SizedBox(height: 20),
                      StepProgressIndicator(currentStep: state.currentStep),
                    ],

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: PageView.builder(
                          controller: pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _getPages(context).length,
                          itemBuilder: (context, index) =>
                              _getPages(context)[index],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _getPages(BuildContext context) => [
    RegisterPage(pageController: pageController),
    GenderPage(),
    AgePage(),
    WeightPage(),
    HeightPage(),
    GoalPage(),
    LevelPage(),
  ];
}
