import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/context_spacing_extension.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';

class EditProfileTapToEditField extends StatelessWidget {
  final String prefixTitle;
  final TextEditingController controller;
  final VoidCallback onClickTap;
  final bool enabled;

  const EditProfileTapToEditField({
    super.key,
    required this.prefixTitle,
    required this.controller,
    required this.onClickTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              prefixTitle,
              style: context.appTheme.semiBold16.copyWith(
                fontSize: 14,
                color: context.appTheme.onBackground,
              ),
            ),
            context.w(6),
            InkWell(
              onTap: enabled ? onClickTap : null,
              child: Text(
                "profile.tap_to_edit".tr(),
                style: context.appTheme.semiBold16.copyWith(
                  color: context.appTheme.primary,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        context.h(8),
        TextFormField(
          controller: controller,
          readOnly: true,
          enabled: enabled,
          onTap: enabled ? onClickTap : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: context.appTheme.inputOutline.withValues(alpha: 0.20),
          ),
        ),
      ],
    );
  }
}
