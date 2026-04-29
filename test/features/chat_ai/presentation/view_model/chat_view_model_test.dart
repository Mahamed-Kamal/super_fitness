import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_conversation_entity.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_message_entity.dart';
import 'package:super_fitness/features/chat_ai/domain/repo/chat_ai_repo.dart';
import 'package:super_fitness/features/chat_ai/presentation/view_model/chat_view_model.dart';
import 'package:super_fitness/features/chat_ai/presentation/view_model/chat_state.dart';

class TestChatAiRepo implements ChatAiRepo {
  Future<Result<ChatMessageEntity>> Function({required String prompt})?
  sendMessageCallback;
  Future<List<ChatConversationEntity>> Function()? getAllConversationsCallback;
  Future<void> Function(ChatConversationEntity conversation)?
  saveConversationCallback;
  Future<void> Function(String conversationId)? deleteConversationCallback;
  Future<ChatConversationEntity?> Function(String conversationId)?
  getConversationCallback;

  @override
  Future<ChatConversationEntity?> getConversation(String conversationId) {
    return getConversationCallback?.call(conversationId) ?? Future.value(null);
  }

  @override
  Future<List<ChatConversationEntity>> getAllConversations() {
    return getAllConversationsCallback?.call() ?? Future.value([]);
  }

  @override
  Future<Result<ChatMessageEntity>> sendMessage({required String prompt}) {
    return sendMessageCallback?.call(prompt: prompt) ??
        Future.value(FailureResponse(errorMessage: 'No response callback'));
  }

  @override
  Future<void> saveConversation(ChatConversationEntity conversation) {
    return saveConversationCallback?.call(conversation) ?? Future.value();
  }

  @override
  Future<void> deleteConversation(String conversationId) {
    return deleteConversationCallback?.call(conversationId) ?? Future.value();
  }
}

void main() {
  late TestChatAiRepo mockRepo;
  late ChatViewModel sut;

  const testPrompt = 'Hello chat';
  final responseMessage = ChatMessageEntity(text: 'Hi there', isUser: false);

  setUp(() {
    mockRepo = TestChatAiRepo();
    mockRepo.getAllConversationsCallback = () async => [];
    mockRepo.saveConversationCallback = (_) async {};
    sut = ChatViewModel(mockRepo);
  });

  test(
    'initial load should request conversations and emit loaded state',
    () async {
      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(sut.state.conversations.requestState, RequestState.loaded);
      expect(sut.state.conversations.data, isEmpty);
      expect(sut.state.message.requestState, RequestState.init);
    },
  );

  test('SendMessageIntent should add user and assistant messages', () async {
    mockRepo.sendMessageCallback = ({required String prompt}) async {
      return SuccessResponse(data: responseMessage);
    };

    sut.doIntent(SendMessageIntent(testPrompt));
    await Future<void>.delayed(const Duration(milliseconds: 100));

    expect(sut.state.message.data, hasLength(2));
    expect(sut.state.message.data![0].text, testPrompt);
    expect(sut.state.message.data![1].text, responseMessage.text);
    expect(sut.state.message.data![1].isUser, false);
  });
}
