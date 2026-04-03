import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/features/app_section/view_model/app_section_view_model.dart';
import 'package:super_fitness/features/chat_ai/presentation/views/chat_ai_view.dart';
import 'package:super_fitness/features/explore/presentation/views/explore_view.dart';
import 'package:super_fitness/features/profile/presentation/views/profile_view.dart';
import 'package:super_fitness/features/workouts/presentation/views/workouts_view.dart';

class AppSectionView extends StatefulWidget {
  const AppSectionView({super.key});

  @override
  State<AppSectionView> createState() => _AppSectionViewState();
}

class _AppSectionViewState extends State<AppSectionView> {
  final List<Widget> _screens = [
    ExploreView(),
    ChatAiView(),
    WorkoutsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.select(
      (AppSectionViewModel vm) => vm.state.currentIndex,
    );
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: _buildBottomNavBar(currentIndex),
      body: _screens[currentIndex],
    );
  }

  Widget _buildBottomNavBar(int currentPage) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.only(left: 32, right: 32, bottom: 31),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          currentIndex: currentPage,
          showUnselectedLabels: false,

          onTap: (currentIndex) {
            context.read<AppSectionViewModel>().doIntent(currentIndex);
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsManager.exploreSvg),
              activeIcon: SvgPicture.asset(AssetsManager.selectedExploreSvg),
              label: 'navigation.explore'.tr(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsManager.chatSvg),
              label: 'navigation.chatAi'.tr(),
              activeIcon: SvgPicture.asset(AssetsManager.selectedChatSvg),
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(AssetsManager.selectedGymSvg),
              icon: SvgPicture.asset(AssetsManager.gymSvg),
              label: 'navigation.workouts'.tr(),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsManager.profileSvg),
              activeIcon: SvgPicture.asset(AssetsManager.selectedProfileSvg),
              label: 'navigation.profile'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
