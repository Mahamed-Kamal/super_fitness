import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/app_services/gemini_ai_service.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/chat_ai/data/data_source/chat_ai_data_source_impl.dart';

import 'chat_ai_data_source_impl_test.mocks.dart';

@GenerateMocks([GeminiAiService])
void main() {
  late GeminiAiService mockGeminiAiService;
  late ChatAiDataSourceImpl chatAiDataSourceImpl;

  const testPrompt = 'Hello, how are you?';
  const testResponse = 'I am fine, thank you!';

  setUp(() {
    mockGeminiAiService = MockGeminiAiService();
    chatAiDataSourceImpl = ChatAiDataSourceImpl(mockGeminiAiService);
  });

  group('ChatAiDataSourceImpl', () {
    test(
      'should return SuccessResponse when sendMessage is successful',
      () async {
        provideDummy<Result<String>>(SuccessResponse(data: testResponse));
        when(
          mockGeminiAiService.getResponse(testPrompt),
        ).thenAnswer((_) async => testResponse);
        final result = await chatAiDataSourceImpl.sendMessage(testPrompt);
        expect(result, isA<SuccessResponse<String>>());
        expect((result as SuccessResponse<String>).data, testResponse);
      },
    );

    test(
      'should return FailureResponse when sendMessage throws exception',
      () async {
        provideDummy<Result<String>>(FailureResponse(errorMessage: 'error'));

        when(
          mockGeminiAiService.getResponse(testPrompt),
        ).thenThrow(Exception((_) async => testResponse));
        final result = await chatAiDataSourceImpl.sendMessage(testPrompt);

        expect(result, isA<FailureResponse<String>>());
        expect((result as FailureResponse<String>).errorMessage, isNotNull);
      },
    );
  });
}
