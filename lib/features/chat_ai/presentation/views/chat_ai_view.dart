import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:super_fitness/core/extensions/theme_context_extension.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/core/widgets/glass_container.dart';
import 'package:super_fitness/core/widgets/screen_image_background.dart';
import 'package:super_fitness/features/chat_ai/presentation/widgets/chat_drawer.dart';
import '../../../../core/utils/assets_manager/assets_manager.dart';

class ChatAiView extends StatelessWidget {
  const ChatAiView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenImageBackground(
      imagePath: AssetsManager.smartChatBg,
      drawer: ChatDrawer(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // ChatAppBar(),
              Expanded(child: _GetStartView()),
            ],
          ),
        ),
      ),
    );
  }
}

class _GetStartView extends StatelessWidget {
  const _GetStartView();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Column(
      children: [
        Expanded(child: Image.asset(AssetsManager.robot)),
        GlassContainer(
          padding: EdgeInsets.all(40),
          borderRadius: BorderRadius.circular(40),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'chat.introTitle'.tr(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: theme.semiBold24.copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.smartChatAi);
                },
                child: Text('chat.getStarted'.tr()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
