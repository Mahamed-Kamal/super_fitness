import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/features/profile/presentation/view_model/profile_events.dart';
import 'package:super_fitness/features/profile/presentation/view_model/profile_states.dart';
import 'package:super_fitness/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:super_fitness/features/profile/presentation/views/widget/app_web_view.dart';
import 'package:super_fitness/features/profile/presentation/views/widget/main_profile_item.dart';
import '../../../../core/widgets/custom_image_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileViewModel profileViewModel;

  @override
  void initState() {
    profileViewModel = context.read<ProfileViewModel>();
    super.initState();
    profileViewModel.uiEvents.listen((event) {
      if (!mounted) return;
      switch (event) {
        case OnLogoutClickIntent():
        //showLogoutDialog(context);
        case OnPrivacyClickIntent():
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AppWebView(
                  url:
                      "https://elevate-flutter-team.github.io/fitness-app-webviews/privacy-policy.html",
                  title: "Privacy policy",
                ),
              ),
            );
          }
        case OnHeloClickIntent():
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AppWebView(
                  url:
                      "https://elevate-flutter-team.github.io/fitness-app-webviews/security.html",
                  title: "Help",
                ),
              ),
            );
          }
        case OnLSecurityClickIntent():
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AppWebView(
                  url:
                      "https://elevate-flutter-team.github.io/fitness-app-webviews/security.html",
                  title: "Security",
                ),
              ),
            );
          }
        case OnEditProfileClickIntent():
        // TODO: Handle this case.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: context.appTheme.medium20).tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<ProfileViewModel, ProfileStates>(
              builder: (context, state) {
                if (state.userData?.requestState == RequestState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                var data = state.userData?.data;
                return Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: context.appTheme.backgroundColor,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomImageView(
                          imagePath:
                              data?.photo ?? "assets/images/ic_profile.svg",
                          width: 80,
                          height: 80,
                          radius: const BorderRadius.all(Radius.circular(40)),
                        ),
                      ),
                    ),
                    Text(
                      "${data?.firstName ?? ""} ${data?.lastName ?? ""}",
                      style: context.appTheme.semiBold18,
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
            MainProfileItem(
              title: 'Edit Profile'.tr(),
              onTap: () => profileViewModel.doEvent(OnEditProfileClickIntent()),
              prefix: const Icon(
                Icons.person,
                size: 17.5,
                color: Color(0xFFFF4500),
              ),
              suffix: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFFFF4500),
              ),
            ),
            const SizedBox(height: 10),
            MainProfileItem(
              prefix: const Icon(
                Icons.language,
                size: 18,
                color: Color(0xFFFF4500),
              ),
              title:
                  "${'Select Language '
                          '(${context.locale.languageCode == 'ar' ? 'Arabic' : 'English'})'}  "
                      .tr(),
              suffix: Switch(
                value: isArabic,
                onChanged: (bool value) {
                  if (value) {
                    context.setLocale(const Locale('ar'));
                  } else {
                    context.setLocale(const Locale('en'));
                  }

                  setState(() {});
                },
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFFFF4500),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey.shade300,

                trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              ),
              onTap: () {},
            ),

            const SizedBox(height: 10),

            MainProfileItem(
              title: 'Security'.tr(),
              onTap: () => profileViewModel.doEvent(OnLSecurityClickIntent()),
              prefix: const Icon(
                Icons.security,
                size: 17.5,
                color: Color(0xFFFF4500),
              ),
              suffix: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFFFF4500),
              ),
            ),
            const SizedBox(height: 10),

            MainProfileItem(
              title: 'Privacy Policy'.tr(),
              onTap: () => profileViewModel.doEvent(OnPrivacyClickIntent()),
              prefix: const Icon(
                Icons.policy,
                size: 16,
                color: Color(0xFFFF4500),
              ),
              suffix: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFFFF4500),
              ),
            ),
            const SizedBox(height: 10),

            MainProfileItem(
              title: 'Help'.tr(),
              onTap: () => profileViewModel.doEvent(OnHeloClickIntent()),
              prefix: const Icon(
                Icons.help_outline,
                size: 16,
                color: Color(0xFFFF4500),
              ),
              suffix: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFFFF4500),
              ),
            ),
            const SizedBox(height: 10),
            MainProfileItem(
              title: 'logout'.tr(),
              onTap: () => profileViewModel.doEvent(OnLogoutClickIntent()),
              prefix: const Icon(
                Icons.logout,
                size: 16,
                color: Color(0xFFFF4500),
              ),
              suffix: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFFFF4500),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
