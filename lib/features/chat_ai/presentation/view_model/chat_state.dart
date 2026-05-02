import 'package:equatable/equatable.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_conversation_entity.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_message_entity.dart';

class ChatState extends Equatable {
  final BaseState<List<ChatMessageEntity>> message;
  final BaseState<List<ChatConversationEntity>> conversations;
  final ChatConversationEntity? currentConversation;

  const ChatState({
    required this.message,
    required this.conversations,
    this.currentConversation,
  });

  ChatState copyWith({
    BaseState<List<ChatMessageEntity>>? message,
    BaseState<List<ChatConversationEntity>>? conversations,
    ChatConversationEntity? currentConversation,
  }) => ChatState(
    message: message ?? this.message,
    conversations: conversations ?? this.conversations,
    currentConversation: currentConversation,
  );

  @override
  List<Object?> get props => [message, conversations, currentConversation];
}

sealed class ChatIntent {}

final class LoadConversationsIntent extends ChatIntent {}

final class StartNewConversationIntent extends ChatIntent {}

final class DeleteConversationIntent extends ChatIntent {
  final String conversationId;
  DeleteConversationIntent(this.conversationId);
}

final class LoadConversationIntent extends ChatIntent {
  final String conversationId;
  LoadConversationIntent(this.conversationId);
}

final class SendMessageIntent extends ChatIntent {
  final String message;
  SendMessageIntent(this.message);
}
