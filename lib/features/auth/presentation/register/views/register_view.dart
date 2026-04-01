import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/core/widgets/super_fitness_app_bar.dart';
import 'package:super_fitness/features/auth/presentation/widget/age_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/gender_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/goal_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/hight_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/level_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/register_page.dart';
import 'package:super_fitness/features/auth/presentation/widget/step_progress_indicator.dart';
import 'package:super_fitness/features/auth/presentation/widget/weight_page.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late PageController pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);

    pageController.addListener(() {
      if (pageController.hasClients) {
        int next = pageController.page!.round();
        if (_currentPage != next) {
          setState(() {
            _currentPage = next;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackdrop(
        image: AssetsManager.authBackground,
        child: Column(
          children: [
            SuperFitnessAppBar(
              showBack: true,
              logo: AssetsManager.appLogoSvg,
              leading: _currentPage > 0
                  ? IconButton(
                      onPressed: () {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.appTheme.primary,
                        ),
                        child: SvgPicture.asset(AssetsManager.icBackSvg),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            if (_currentPage > 0) ...[
              const SizedBox(height: 20),
              StepProgressIndicator(currentStep: _currentPage),
            ],

            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: getPages.length,
                itemBuilder: (context, index) => getPages[index],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> get getPages => [
    RegisterPage(pageController: pageController),
    GenderPage(pageController: pageController),
    AgePage(pageController: pageController),
    WeightPage(pageController: pageController),
    HightPage(pageController: pageController),
    GoalPage(pageController: pageController),
    LevelPage(pageController: pageController),
  ];
}
