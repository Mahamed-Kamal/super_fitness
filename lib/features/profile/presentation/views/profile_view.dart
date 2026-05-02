import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/features/localization/model/app_language.dart';
import 'package:super_fitness/features/localization/view/language_bottom_sheet.dart';
import 'package:super_fitness/features/profile/presentation/view_model/profile_events.dart';
import 'package:super_fitness/features/profile/presentation/view_model/profile_states.dart';
import 'package:super_fitness/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:super_fitness/features/profile/presentation/views/widget/main_profile_item.dart';

import '../../../../core/widgets/custom_image_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

final profileViewModel = getIt.get<ProfileViewModel>();

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    final profileViewModel = context.read<ProfileViewModel>();
    super.initState();
    profileViewModel.uiEvents.listen((event) {
      if (!mounted) return;
      switch (event) {
        case GetUserDataEvent():
          {}

        case OnLanguageClickIntent():
          showLanguageBottomSheet();

        case OnLogoutClickIntent():
        //showLogoutDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLanguage currentLanguage = AppLanguage.values.firstWhere(
      (lang) => lang.locale.languageCode == (context.locale.languageCode),
      orElse: () => AppLanguage.english,
    );
    final profileViewModel = context.read<ProfileViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: context.appTheme.medium20).tr(),
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Icon(Icons.notifications_none_sharp),
            ),
            onTap: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            BlocBuilder<ProfileViewModel, ProfileStates>(
              bloc: profileViewModel,
              builder: (context, state) {
                if (state.userData?.requestState == RequestState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.userData?.requestState == RequestState.error) {
                  return Text(
                    state.userData?.errorMessage ?? "something went wrong".tr(),
                  );
                } else {
                  var state = profileViewModel.state.userData?.data;

                  return Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: context.appTheme.backgroundColor,
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CustomImageView(
                            imagePath:
                                state?.photo ?? "assets/images/ic_profile.svg",
                            width: 80,
                            height: 80,
                            radius: const BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
                      ),
                      Text(
                        "${state?.firstName ?? ""} ${state?.lastName ?? ""}",
                        style: context.appTheme.semiBold18,
                      ),

                      SizedBox(height: 20),
                    ],
                  );
                }
              },
            ),
            MainProfileItem(
              prefix: const Icon(Icons.translate_rounded, size: 18),
              title: 'language'.tr(),
              suffix: TextButton(
                style: TextButton.styleFrom(),
                onPressed: () =>
                    profileViewModel.doEvent(OnLanguageClickIntent()),
                child: Text(
                  currentLanguage.displayName.tr(),
                  style: context.appTheme.regular12.copyWith(
                    color: context.appTheme.primary,
                  ),
                ),
              ),
              onTap: () => profileViewModel.doEvent(OnLanguageClickIntent()),
            ),
            MainProfileItem(
              title: 'logout'.tr(),
              onTap: () => profileViewModel.doEvent(OnLogoutClickIntent()),
              prefix: const Icon(Icons.logout, size: 16),
              suffix: const Icon(Icons.logout, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  showLanguageBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      //isScrollControlled: true,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      showDragHandle: true,
      builder: (context) => Container(
        //   height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          color: Colors.transparent,

          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: const LanguageBottomSheet(),
      ),
    );
  }
}
