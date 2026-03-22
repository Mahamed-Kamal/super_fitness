import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/api/execute_api.dart';
import 'package:super_fitness/core/error_handling/result.dart';

void main() {
  test('returns SuccessResponse with data', () async {
    final result = await executeApi(() async => 'ok');

    expect(result, isA<SuccessResponse<String>>());
    expect((result as SuccessResponse<String>).data, 'ok');
  });

  test('returns FailureResponse when call throws', () async {
    final result = await executeApi<String>(() async {
      throw Exception('boom');
    });

    expect(result, isA<FailureResponse<String>>());
    expect((result as FailureResponse<String>).errorMessage, isNotEmpty);
  });
}
