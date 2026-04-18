import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/domain/entity/forget_password_entity.dart';

void main() {
  test('test creational of ForgotPasswordEntity with real values ', () {
    final result = ForgotPasswordEntity(message: 'message', info: 'info');
    expect(result, isA<ForgotPasswordEntity>());
    expect(result.message, 'message');
    expect(result.info, 'info');
  });
  test('test creational of ForgotPasswordEntity with null values ', () {
    final result = ForgotPasswordEntity(message: null, info: null);
    expect(result, isA<ForgotPasswordEntity>());
    expect(result.message, isNull);
    expect(result.info, isNull);
  });
}
