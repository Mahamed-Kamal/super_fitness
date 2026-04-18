import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/features/auth/presentation/widget/register_from_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'hey_there'.tr(),
              style: context.appTheme.regular16.copyWith(fontSize: 18),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'create_an_account'.tr(),
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
            child: RegisterFormWidget(),
          ),
        ],
      ),
    );
  }
}
