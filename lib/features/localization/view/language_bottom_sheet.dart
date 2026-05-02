import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/core/widgets/screen_backdrop.dart';
import 'package:super_fitness/features/localization/model/app_language.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBackdrop(
        image: AssetsManager.authBackground,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Change Language".tr(),
                style: context.appTheme.semiBold24.copyWith(
                  color: context.appTheme.primary[50],
                ),
              ),
              const SizedBox(height: 20),

              RadioGroup<AppLanguage>(
                groupValue: getCurrentLanguage(context),
                onChanged: (AppLanguage? newValue) {
                  if (newValue == null) return;
                  context.setLocale(newValue.locale);
                  Navigator.pop(context);
                },
                child: Column(
                  children: AppLanguage.values.map((language) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: RadioListTile<AppLanguage>(
                        value: language,
                        title: Text(
                          language.displayName.tr(),
                          style: context.appTheme.medium16.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        activeColor: context.appTheme.primary,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
    );
  }

  AppLanguage getCurrentLanguage(BuildContext context) {
    final locale = context.locale;

    return AppLanguage.values.firstWhere(
      (lang) => lang.locale.languageCode == locale.languageCode,
      orElse: () => AppLanguage.english,
    );
  }
}
