import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/bloc/base_cubit.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_conversation_entity.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_message_entity.dart';
import 'package:super_fitness/features/chat_ai/domain/repo/chat_ai_repo.dart';
import 'package:super_fitness/features/chat_ai/presentation/view_model/chat_state.dart';

@singleton
class ChatViewModel extends BaseCubit<ChatState, ChatIntent, void> {
  ChatViewModel(this._repo)
    : super(
        ChatState(message: BaseState.init(), conversations: BaseState.init()),
      ) {
    _loadConversations();
  }

  final ChatAiRepo _repo;

  Future<void> _loadConversations() async {
    emit(state.copyWith(conversations: BaseState.loading()));
    try {
      final conversations = await _repo.getAllConversations();
      emit(state.copyWith(conversations: BaseState.loaded(conversations)));
    } catch (e) {
      emit(
        state.copyWith(
          conversations: BaseState.error('Failed to load conversations'),
        ),
      );
    }
  }

  Future<void> _saveCurrentConversation() async {
    if (state.message.data != null && state.message.data!.isNotEmpty) {
      final conversation =
          state.currentConversation ??
          ChatConversationEntity.create(state.message.data!);

      final updatedConversation = conversation.copyWith(
        messages: state.message.data!,
        lastUpdated: DateTime.now(),
      );

      await _repo.saveConversation(updatedConversation);
      await _loadConversations(); // Refresh the list
    }
  }

  Future<void> _loadConversation(String conversationId) async {
    try {
      final conversation = await _repo.getConversation(conversationId);
      if (conversation != null) {
        emit(
          state.copyWith(
            message: BaseState.loaded(conversation.messages),
            currentConversation: conversation,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(message: BaseState.error('Failed to load conversation')),
      );
    }
  }

  Future<void> _startNewConversation() async {
    if (state.message.data != null && state.message.data!.isNotEmpty) {
      await _saveCurrentConversation();
    }

    emit(
      state.copyWith(message: BaseState.loaded([]), currentConversation: null),
    );
  }

  Future<void> _deleteConversation(String conversationId) async {
    try {
      await _repo.deleteConversation(conversationId);
      await _loadConversations();

      if (state.currentConversation?.id == conversationId) {
        emit(
          state.copyWith(
            message: BaseState.loaded([]),
            currentConversation: null,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          conversations: BaseState.error('Failed to delete conversation'),
        ),
      );
    }
  }

  Future<void> _sendMessage(String message) async {
    final newMessage = List<ChatMessageEntity>.from(state.message.data ?? []);
    final userMessage = ChatMessageEntity(text: message, isUser: true);
    newMessage.add(userMessage);

    final loadingMessage = ChatMessageEntity(text: 'Typing...', isUser: false);
    newMessage.add(loadingMessage);

    emit(state.copyWith(message: BaseState.loading(newMessage)));
    final response = await _repo.sendMessage(prompt: userMessage.text);

    newMessage.removeLast();

    switch (response) {
      case SuccessResponse<ChatMessageEntity>():
        newMessage.add(response.data);
        emit(state.copyWith(message: BaseState.loaded(newMessage)));
        await _saveCurrentConversation();
      case FailureResponse<ChatMessageEntity>():
        emit(
          state.copyWith(
            message: BaseState(
              requestState: RequestState.error,
              errorMessage: response.errorMessage,
              data: newMessage,
            ),
          ),
        );
        await _saveCurrentConversation();
    }
  }

  @override
  void doIntent(ChatIntent intent) {
    switch (intent) {
      case LoadConversationsIntent():
        _loadConversations();
      case StartNewConversationIntent():
        _startNewConversation();
      case DeleteConversationIntent():
        _deleteConversation(intent.conversationId);
      case LoadConversationIntent():
        _loadConversation(intent.conversationId);
      case SendMessageIntent():
        _sendMessage(intent.message);
    }
  }
}
