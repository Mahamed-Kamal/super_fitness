import 'package:super_fitness/core/error_handling/result.dart';

abstract interface class ChatAiDataSource {
  Future<Result<String>> sendMessage(String prompt);
}
