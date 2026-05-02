import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/chat_ai/data/mapper/chati_ai_mapper.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_message_entity.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_conversation_entity.dart';
import 'package:super_fitness/features/chat_ai/domain/repo/chat_ai_repo.dart';

import '../data_source/chat_ai_data_source.dart';

@LazySingleton(as: ChatAiRepo)
class ChatAiRepoImpl implements ChatAiRepo {
  final ChatAiDataSource _dataSource;
  static const String _conversationsKey = 'chat_conversations';

  ChatAiRepoImpl(this._dataSource);

  @override
  Future<Result<ChatMessageEntity>> sendMessage({
    required String prompt,
  }) async {
    final response = await _dataSource.sendMessage(prompt);
    switch (response) {
      case SuccessResponse<String>():
        return SuccessResponse(data: response.data.toEntity());
      case FailureResponse<String>():
        return FailureResponse(errorMessage: response.errorMessage);
    }
  }

  @override
  Future<List<ChatConversationEntity>> getAllConversations() async {
    final prefs = await SharedPreferences.getInstance();
    final conversationsJson = prefs.getStringList(_conversationsKey) ?? [];

    return conversationsJson
        .map((json) => ChatConversationEntity.fromJson(jsonDecode(json)))
        .toList()
      ..sort(
        (a, b) => b.lastUpdated.compareTo(a.lastUpdated),
      ); // Sort by most recent
  }

  @override
  Future<void> saveConversation(ChatConversationEntity conversation) async {
    final prefs = await SharedPreferences.getInstance();
    final conversations = await getAllConversations();

    // Remove existing conversation with same ID if exists
    conversations.removeWhere((c) => c.id == conversation.id);

    // Add the new/updated conversation
    conversations.add(conversation);

    // Keep only last 50 conversations to avoid storage issues
    if (conversations.length > 50) {
      conversations.removeRange(0, conversations.length - 50);
    }

    final conversationsJson = conversations
        .map((c) => jsonEncode(c.toJson()))
        .toList();

    await prefs.setStringList(_conversationsKey, conversationsJson);
  }

  @override
  Future<void> deleteConversation(String conversationId) async {
    final prefs = await SharedPreferences.getInstance();
    final conversations = await getAllConversations();

    conversations.removeWhere((c) => c.id == conversationId);

    final conversationsJson = conversations
        .map((c) => jsonEncode(c.toJson()))
        .toList();

    await prefs.setStringList(_conversationsKey, conversationsJson);
  }

  @override
  Future<ChatConversationEntity?> getConversation(String conversationId) async {
    final conversations = await getAllConversations();
    return conversations.where((c) => c.id == conversationId).firstOrNull;
  }
}
