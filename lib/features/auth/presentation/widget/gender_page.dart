import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/features/auth/domain/entities/user_gender.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_intent.dart';
import 'package:super_fitness/features/auth/presentation/register/view_model/register_view_model.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  UserGender? selectedGender;

  @override
  void initState() {
    super.initState();
    final savedGender = context.read<RegisterViewModel>().state.formData.gender;
    if (savedGender.isNotEmpty) {
      selectedGender = UserGender.values.byName(savedGender);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "tell_us_about_yourself".tr(),
            style: context.appTheme.semiBold24,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "gender_subtitle".tr(),
            style: context.appTheme.regular14.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          GlassContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildGenderItem(
                  label: "male".tr(),
                  icon: AssetsManager.icMaleSvg,
                  isSelected: selectedGender == UserGender.male,
                  onTap: () => setState(() => selectedGender = UserGender.male),
                ),
                const SizedBox(width: 40),
                _buildGenderItem(
                  label: "female".tr(),
                  icon: AssetsManager.icFemaleSvg,
                  isSelected: selectedGender == UserGender.female,
                  onTap: () =>
                      setState(() => selectedGender = UserGender.female),
                ),
                const SizedBox(width: 50),
                ElevatedButton(
                  onPressed: selectedGender == null
                      ? null
                      : () => context.read<RegisterViewModel>().doIntent(
                          SwitchViewToSelectWeight(userGender: selectedGender!),
                        ),
                  child: Text("next".tr()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderItem({
    required String label,
    required String icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: isSelected ? context.appTheme.primary : Colors.white10,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.white : Colors.transparent,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                SvgPicture.asset(icon, height: 50),

                const SizedBox(height: 15),
                Text(
                  label,
                  style: context.appTheme.regular14.copyWith(
                    color: context.appTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
