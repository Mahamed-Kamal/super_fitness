import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/core/widgets/screen_image_background.dart';
import 'package:super_fitness/features/on_boarding/controller/page_view_controller.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final _onBoardingModel = OnboardingModel.onBoardingModel;
  late final PageViewController _pageController;
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  void initState() {
    _pageController = PageViewController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenImageBackground(
      appBar: _buildAppBar(),
      imagePath: AssetsManager.onBoardingBackground,
      child: Stack(
        children: [_buildOnboardingImage(), _buildOnboardingContent()],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actionsPadding: EdgeInsets.only(right: 17),
      actions: [
        ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (context, value, child) {
            if (value == _onBoardingModel.length - 1) {
              return SizedBox.shrink();
            }
            return GestureDetector(
              onTap: () =>
                  _pageController.skipToLastPage(_onBoardingModel.length - 1),
              child: Text("onboarding.skip".tr()),
            );
          },
        ),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  Widget _buildRowButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          onPressed: _pageController.navigateToPreviousPage,
          child: Text("onboarding.back".tr()),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          onPressed: _pageController.navigateToNextPage,
          child: ValueListenableBuilder(
            valueListenable: _currentPage,
            builder: (context, value, child) {
              if (value == _onBoardingModel.length - 1) {
                return Text("onboarding.doIt".tr());
              }
              return Text("onboarding.next".tr());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOnboardingContent() {
    final theme = context.appTheme;
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: GlassContainer(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 31),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        child: ValueListenableBuilder<int>(
          valueListenable: _currentPage,
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    _onBoardingModel[value].title,
                    style: theme.semiBold24.copyWith(height: 1.40),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),

                Text(
                  _onBoardingModel[value].desc,
                  style: theme.regular16.copyWith(height: 1.40),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),

                SizedBox(height: 24),
                _buildIndicator(),
                SizedBox(height: 24),
                ValueListenableBuilder(
                  valueListenable: _currentPage,
                  builder: (context, value, child) {
                    if (value == 0) {
                      return ElevatedButton(
                        onPressed: _pageController.navigateToNextPage,
                        child: Text("onboarding.next".tr()),
                      );
                    }
                    return _buildRowButtons();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildIndicator() => Align(
    alignment: Alignment.center,
    child: SmoothPageIndicator(
      controller: _pageController.controller, // PageController
      count: _onBoardingModel.length,
      effect: ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
        dotColor: Colors.white,
      ),
      onDotClicked: (index) {},
    ),
  );

  Widget _buildOnboardingImage() {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController.controller,
      onPageChanged: (value) => _currentPage.value = value,
      itemCount: _onBoardingModel.length,
      itemBuilder: (context, index) =>
          Image.asset(_onBoardingModel[index].image, height: 516),
    );
  }
}

final class OnboardingModel {
  final String image;
  final String title;
  final String desc;

  const OnboardingModel({
    required this.image,
    required this.title,
    required this.desc,
  });

  static final List<OnboardingModel> onBoardingModel = [
    OnboardingModel(
      image: AssetsManager.onBoardingScreenOne,
      title: "onboarding.title1".tr(),
      desc: "onboarding.desc1".tr(),
    ),
    OnboardingModel(
      image: AssetsManager.onBoardingScreenTwo,
      title: "onboarding.title2".tr(),
      desc: "onboarding.desc2".tr(),
    ),
    OnboardingModel(
      image: AssetsManager.onBoardingScreenThree,
      title: "onboarding.title3".tr(),
      desc: "onboarding.desc3".tr(),
    ),
  ];
}
