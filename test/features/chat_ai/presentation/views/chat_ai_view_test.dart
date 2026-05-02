import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/core/route_manager/app_routes.dart';
import 'package:super_fitness/features/chat_ai/presentation/views/chat_ai_view.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets(
    'ChatAiView renders get started UI and navigates to SmartCoachChatView',
    (tester) async {
      await tester.pumpWidget(
        EasyLocalization(
          saveLocale: false,
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          child: Builder(
            builder: (context) {
              return MaterialApp(
                locale: context.locale,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                theme: DarkTheme().themeData,
                routes: {
                  AppRoutes.smartChatAi: (_) =>
                      const SizedBox(key: Key('smart-chat-route')),
                },
                home: const ChatAiView(),
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('chat.getStarted'.tr()), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('smart-chat-route')), findsOneWidget);
    },
  );
}
