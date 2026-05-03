import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness/core/di/di.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/utils/assets_manager/assets_manager.dart';
import 'package:super_fitness/features/profile/presentation/view_model/profile_view_model.dart';
import '../../../profile/presentation/view_model/profile_states.dart';

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
      title: BlocBuilder<ProfileViewModel, ProfileStates>(
        bloc: getIt.get<ProfileViewModel>(),
        builder: (context, state) {
          final user = state.userData?.data;
          if (user != null) {
            final firstName=user.firstName;
            return Text(
            "${"${"chat.hi".tr()} "}$firstName",
              textAlign: TextAlign.center,
              style: theme.medium16,
            );
          }
          return Text(
            'chat.hi'.tr(),
            textAlign: TextAlign.center,
            style: theme.medium16,
          );
        },
      ),
      subtitle: Text(
        'chat.smartCoachSubtitle'.tr(),
        textAlign: TextAlign.center,
        style: theme.semiBold24.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
