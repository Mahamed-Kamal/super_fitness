import 'package:super_fitness/features/chat_ai/domain/entities/chat_message_entity.dart';

class ChatConversationEntity {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final List<ChatMessageEntity> messages;

  ChatConversationEntity({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.lastUpdated,
    required this.messages,
  });

  // Generate title from first user message
  factory ChatConversationEntity.create(List<ChatMessageEntity> messages) {
    final userMessages = messages.where((msg) => msg.isUser).toList();
    final title = userMessages.isNotEmpty
        ? userMessages.first.text.length > 50
              ? '${userMessages.first.text.substring(0, 50)}...'
              : userMessages.first.text
        : 'New Conversation';

    final now = DateTime.now();
    return ChatConversationEntity(
      id: now.millisecondsSinceEpoch.toString(),
      title: title,
      createdAt: now,
      lastUpdated: now,
      messages: messages,
    );
  }

  ChatConversationEntity copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? lastUpdated,
    List<ChatMessageEntity>? messages,
  }) {
    return ChatConversationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'messages': messages
          .map((msg) => {'text': msg.text, 'isUser': msg.isUser})
          .toList(),
    };
  }

  factory ChatConversationEntity.fromJson(Map<String, dynamic> json) {
    return ChatConversationEntity(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      lastUpdated: DateTime.parse(json['lastUpdated']),
      messages: (json['messages'] as List)
          .map(
            (msg) =>
                ChatMessageEntity(text: msg['text'], isUser: msg['isUser']),
          )
          .toList(),
    );
  }
}
