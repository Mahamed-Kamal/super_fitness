import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/chat_ai/data/repo/chat_ai_repo_impl.dart';
import 'package:super_fitness/features/chat_ai/data/data_source/chat_ai_data_source.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_conversation_entity.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_message_entity.dart';

import 'chat_ai_repo_impl_test.mocks.dart';

@GenerateMocks([ChatAiDataSource])
void main() {
  late ChatAiDataSource mockDataSource;
  late ChatAiRepoImpl repo;

  const requestPrompt = 'Hello AI';
  final responseMessage = ChatMessageEntity(text: 'Hi there', isUser: false);
  final conversation = ChatConversationEntity(
    id: '123',
    title: 'Hello AI',
    createdAt: DateTime.parse('2024-01-01T12:00:00Z'),
    lastUpdated: DateTime.parse('2024-01-01T12:00:00Z'),
    messages: [
      ChatMessageEntity(text: requestPrompt, isUser: true),
      responseMessage,
    ],
  );

  setUp(() {
    SharedPreferences.setMockInitialValues({});

    // Provide dummies for the types Mockito is struggling with
    provideDummy<Result<String>>(SuccessResponse(data: ''));
    provideDummy<Result<ChatMessageEntity>>(
      SuccessResponse(data: responseMessage),
    );

    mockDataSource = MockChatAiDataSource();
    repo = ChatAiRepoImpl(mockDataSource);
  });

  group('ChatAiRepoImpl', () {
    test('sendMessage should return a SuccessResponse with entity', () async {
      when(
        mockDataSource.sendMessage(requestPrompt),
      ).thenAnswer((_) async => SuccessResponse(data: responseMessage.text));
      final result = await repo.sendMessage(prompt: requestPrompt);
      expect(result, isA<SuccessResponse<ChatMessageEntity>>());
      expect(
        (result as SuccessResponse<ChatMessageEntity>).data.text,
        'Hi there',
      );
      expect(result.data.isUser, false);
    });

    test(
      'sendMessage should return a FailureResponse when the data source fails',
      () async {
        when(mockDataSource.sendMessage(requestPrompt)).thenAnswer(
          (_) async => FailureResponse(errorMessage: 'Network error'),
        );
        final result = await repo.sendMessage(prompt: requestPrompt);
        expect(result, isA<FailureResponse<ChatMessageEntity>>());
        expect(
          (result as FailureResponse<ChatMessageEntity>).errorMessage,
          'Network error',
        );
      },
    );

    test('saveConversation should persist new conversation', () async {
      await repo.saveConversation(conversation);

      final conversations = await repo.getAllConversations();
      expect(conversations, hasLength(1));
      expect(conversations.first.id, conversation.id);
      expect(conversations.first.title, 'Hello AI');
      expect(conversations.first.messages, hasLength(2));
    });

    test('deleteConversation should remove stored conversation', () async {
      await repo.saveConversation(conversation);
      await repo.deleteConversation(conversation.id);

      final conversations = await repo.getAllConversations();
      expect(conversations, isEmpty);
    });

    test('getConversation should return the matching conversation', () async {
      await repo.saveConversation(conversation);

      final loadedConversation = await repo.getConversation(conversation.id);
      expect(loadedConversation, isNotNull);
      expect(loadedConversation!.id, conversation.id);
    });

    test('getConversation should return null for missing id', () async {
      await repo.saveConversation(conversation);

      final loadedConversation = await repo.getConversation('missing-id');
      expect(loadedConversation, isNull);
    });
  });
}
