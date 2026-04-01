import 'package:flutter/material.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/widgets/core_back_button.dart';
import 'package:super_fitness/core/widgets/custom_image_view.dart';

class SuperFitnessAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final bool showBack;
  final List<Widget>? actions;
  final bool centerTitle;
  final String? logo;

  const SuperFitnessAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.logo,
    this.centerTitle = true,
    this.showBack = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    final effectiveLeading =
        leading ?? (showBack && canPop ? const CoreBackButton() : null);

    return AppBar(
      automaticallyImplyLeading: false,
      leading: effectiveLeading,
      leadingWidth: effectiveLeading != null ? 56 : null,
      title: title != null
          ? Text(title!)
          : CustomImageView(
              imagePath: logo,
              fit: BoxFit.cover,
              width: 70,
              height: 48,
            ),
      centerTitle: centerTitle,
      actions: actions,
      backgroundColor: context.appTheme.surface.withAlpha(0),
    );
  }
}
