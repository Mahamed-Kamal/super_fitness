import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/domain/entity/verify_reset_code_entity.dart';

void main() {
  test('test creational of VerifyResetCodeEntity with real values ', () {
    final result = VerifyResetCodeEntity(message: 'message');
    expect(result, isA<VerifyResetCodeEntity>());
    expect(result.message, 'message');
  });
  test('test creational of VerifyResetCodeEntity with null values ', () {
    final result = VerifyResetCodeEntity(message: null);
    expect(result, isA<VerifyResetCodeEntity>());
    expect(result.message, isNull);
  });
}
