import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_conversation_entity.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_message_entity.dart';

void main() {
  group('ChatConversationEntity', () {
    test(
      'create() returns New Conversation title when no user message exists',
      () {
        final messages = [ChatMessageEntity(text: 'Hi there', isUser: false)];

        final conversation = ChatConversationEntity.create(messages);

        expect(conversation.title, 'New Conversation');
        expect(conversation.messages, messages);
        expect(conversation.id, isNotEmpty);
        expect(conversation.createdAt, isNotNull);
        expect(conversation.lastUpdated, isNotNull);
      },
    );

    test('create() uses the first user message as title', () {
      final messages = [
        ChatMessageEntity(text: 'This is my question', isUser: true),
        ChatMessageEntity(text: 'Assistant answer', isUser: false),
      ];

      final conversation = ChatConversationEntity.create(messages);

      expect(conversation.title, 'This is my question');
      expect(conversation.messages, messages);
    });

    test(
      'create() truncates long first user message title to 50 characters',
      () {
        final longMessage = 'A' * 60;
        final messages = [ChatMessageEntity(text: longMessage, isUser: true)];

        final conversation = ChatConversationEntity.create(messages);

        expect(conversation.title, '${longMessage.substring(0, 50)}...');
      },
    );

    test('copyWith updates only the provided fields', () {
      final original = ChatConversationEntity.create([
        ChatMessageEntity(text: 'User message', isUser: true),
      ]);

      final updated = original.copyWith(
        title: 'Updated title',
        lastUpdated: original.lastUpdated.add(const Duration(minutes: 1)),
      );

      expect(updated.id, original.id);
      expect(updated.title, 'Updated title');
      expect(updated.createdAt, original.createdAt);
      expect(updated.lastUpdated, isNot(original.lastUpdated));
      expect(updated.messages, original.messages);
    });

    test('toJson and fromJson preserve all fields', () {
      final original = ChatConversationEntity.create([
        ChatMessageEntity(text: 'How are you?', isUser: true),
        ChatMessageEntity(text: 'I am fine', isUser: false),
      ]);

      final json = original.toJson();
      final recreated = ChatConversationEntity.fromJson(json);

      expect(recreated.id, original.id);
      expect(recreated.title, original.title);
      expect(
        recreated.createdAt.toIso8601String(),
        original.createdAt.toIso8601String(),
      );
      expect(
        recreated.lastUpdated.toIso8601String(),
        original.lastUpdated.toIso8601String(),
      );
      expect(recreated.messages, hasLength(2));
      expect(recreated.messages[0].text, 'How are you?');
      expect(recreated.messages[0].isUser, true);
      expect(recreated.messages[1].text, 'I am fine');
      expect(recreated.messages[1].isUser, false);
    });
  });
}
