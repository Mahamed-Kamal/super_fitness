import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      trailing: GestureDetector(
        onTap: () {
          final scaffold = Scaffold.maybeOf(context);
          if (scaffold != null) {
            scaffold.openEndDrawer();
          }
        },
        child: SvgPicture.asset(AssetsManager.drawerSvg),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: CircleAvatar(
          backgroundColor: theme.primary,
          child: SvgPicture.asset(AssetsManager.arrowBackSvg),
        ),
      ),
      title: Text(
        'chat.hiAhmed'.tr(),
        textAlign: TextAlign.center,
        style: theme.medium16,
      ),
      subtitle: Text(
        'chat.smartCoachSubtitle'.tr(),
        textAlign: TextAlign.center,
        style: theme.semiBold24.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
