import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/core/theme/app_theme/dark_theme.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_conversation_entity.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_message_entity.dart';
import 'package:super_fitness/features/chat_ai/domain/repo/chat_ai_repo.dart';
import 'package:super_fitness/features/chat_ai/presentation/view_model/chat_view_model.dart';
import 'package:super_fitness/features/chat_ai/presentation/views/smart_coach_view.dart';
import 'package:super_fitness/features/chat_ai/presentation/widgets/message_sender.dart';

class TestChatAiRepo implements ChatAiRepo {
  @override
  Future<void> deleteConversation(String conversationId) async {}

  @override
  Future<ChatConversationEntity?> getConversation(
    String conversationId,
  ) async => null;

  @override
  Future<List<ChatConversationEntity>> getAllConversations() async => [];

  @override
  Future<void> saveConversation(ChatConversationEntity conversation) async {}

  @override
  Future<Result<ChatMessageEntity>> sendMessage({
    required String prompt,
  }) async {
    return SuccessResponse(
      data: ChatMessageEntity(text: 'Assistant answer', isUser: false),
    );
  }
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets(
    'SmartCoachChatView renders empty state when there are no messages',
    (tester) async {
      final viewModel = ChatViewModel(TestChatAiRepo());

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
                home: BlocProvider.value(
                  value: viewModel,
                  child: const SmartCoachChatView(),
                ),
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(MessageSender), findsNothing);
      expect(find.byType(TextField), findsOneWidget);

      await viewModel.close();
    },
  );

  testWidgets('SmartCoachChatView shows the send button and input field', (
    tester,
  ) async {
    final viewModel = ChatViewModel(TestChatAiRepo());

    await tester.pumpWidget(
      MaterialApp(
        theme: DarkTheme().themeData,
        home: BlocProvider.value(
          value: viewModel,
          child: const SmartCoachChatView(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.send), findsOneWidget);

    await viewModel.close();
  });
}
