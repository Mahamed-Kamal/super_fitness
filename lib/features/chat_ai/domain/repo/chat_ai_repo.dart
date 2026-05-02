import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_message_entity.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_conversation_entity.dart';

abstract interface class ChatAiRepo {
  Future<Result<ChatMessageEntity>> sendMessage({required String prompt});
  Future<List<ChatConversationEntity>> getAllConversations();
  Future<void> saveConversation(ChatConversationEntity conversation);
  Future<void> deleteConversation(String conversationId);
  Future<ChatConversationEntity?> getConversation(String conversationId);
}
