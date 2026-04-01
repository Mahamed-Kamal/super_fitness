import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key, required this.pageController});
  final PageController pageController;
  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String? selectedGender;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "TELL US ABOUT YOURSELF!",
            style: context.appTheme.semiBold24,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "TO GIVE YOU A BETTER EXPERIENCE WE NEED\nTO KNOW YOUR GENDER",
            style: context.appTheme.regular14.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),

          GlassContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildGenderItem(
                  label: "Male",
                  icon: AssetsManager.icMaleSvg,
                  isSelected: selectedGender == "male",
                  onTap: () {
                    setState(() => selectedGender = "male");
                  },
                ),
                const SizedBox(width: 40),

                _buildGenderItem(
                  label: "Female",
                  icon: AssetsManager.icFemaleSvg,
                  isSelected: selectedGender == "female",
                  onTap: () {
                    setState(() => selectedGender = "female");
                  },
                ),
                const SizedBox(width: 50),
                ElevatedButton(
                  onPressed: selectedGender == null
                      ? null
                      : () {
                          widget.pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
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
