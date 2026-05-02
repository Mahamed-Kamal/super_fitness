import 'package:injectable/injectable.dart';
import 'package:super_fitness/core/api/execute_api.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/chat_ai/data/data_source/chat_ai_data_source.dart';

import '../../../../core/app_services/gemini_ai_service.dart';

@LazySingleton(as: ChatAiDataSource)
class ChatAiDataSourceImpl implements ChatAiDataSource {
  final GeminiAiService _service;

  ChatAiDataSourceImpl(this._service);
  @override
  Future<Result<String>> sendMessage(String prompt) =>
      executeApi(() => _service.getResponse(prompt));
}
