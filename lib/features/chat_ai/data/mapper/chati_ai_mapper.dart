import 'package:super_fitness/features/chat_ai/domain/entities/chat_message_entity.dart';

extension ChatiAiMapper on String {
  ChatMessageEntity toEntity() {
    return ChatMessageEntity(text: this, isUser: false);
  }
}
