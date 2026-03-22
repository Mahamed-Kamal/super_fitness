import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/core/error_handling/result.dart';

void main() {
  group('Result Equality', () {
    test('Success objects with same data should be equal', () {
      expect(SuccessResponse(data: 10), SuccessResponse(data: 10));
      expect(SuccessResponse(data: 10), isNot(SuccessResponse(data: 11)));
    });

    test('Failure objects with same message should be equal', () {
      expect(
        FailureResponse(errorMessage: 'error'),
        FailureResponse(errorMessage: 'error'),
      );
    });
  });
}
