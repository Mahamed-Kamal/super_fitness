import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/chat_ai/data/mapper/chati_ai_mapper.dart';
import 'package:super_fitness/features/chat_ai/domain/entities/chat_message_entity.dart';

void main() {
  group('ChatiAiMapper', () {
    test(
      'String.toEntity returns ChatMessageEntity with the correct values',
      () {
        const prompt = 'Hello, how are you?';

        final entity = prompt.toEntity();

        expect(entity, isA<ChatMessageEntity>());
        expect(entity.text, prompt);
        expect(entity.isUser, isFalse);
      },
    );
  });
}
