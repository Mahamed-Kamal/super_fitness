import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/core/widgets/show_toast.dart';
import 'package:super_fitness/core/widgets/super_fitness_app_bar.dart';
import 'package:super_fitness/features/auth/presentation/change_password/view/change_password_form_widget.dart';
import 'package:super_fitness/features/auth/presentation/change_password/view_model/change_password_events.dart';
import 'package:super_fitness/features/auth/presentation/change_password/view_model/change_password_view_model.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  void initState() {
    super.initState();
    _initEventListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackdrop(
        image: AssetsManager.authBackground,
        child: Column(
          children: [
            SuperFitnessAppBar(showBack: true, logo: AssetsManager.appLogoSvg),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'create_a_new_password'.tr(),
                style: context.appTheme.regular16.copyWith(fontSize: 18),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'make_sure_its_8_characters_or_more'.tr(),
                style: context.appTheme.semiBold16.copyWith(fontSize: 20),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 20),
            GlassContainer(
              bottomLeft: const Radius.circular(50),
              bottomRight: const Radius.circular(50),
              topRight: const Radius.circular(50),
              topLeft: const Radius.circular(50),
              child: ChangePasswordFormWidget(),
            ),
          ],
        ),
      ),
    );
  }

  void _initEventListener() => WidgetsBinding.instance.addPostFrameCallback(
    (_) => context.read<ChangePasswordViewModel>().eventStream.listen((event) {
      if (!mounted) return;
      switch (event) {
        case ChangePasswordNavToSettings():
          Navigator.pop(context);
        case ChangePasswordShowSuccessSnackBar():
          Toast.showToast(context, 'password_changed_success'.tr());
        case ChangePasswordShowErrorSnackBar():
          Toast.showToast(context, event.errorMsg, isError: true);
      }
    }),
  );
}
