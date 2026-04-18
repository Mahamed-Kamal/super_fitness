import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/domain/entity/reset_password_entity.dart';

void main() {
  test('test creational of ResetPasswordEntity with real values ', () {
    final result = ResetPasswordEntity(message: 'message', info: 'info');
    expect(result, isA<ResetPasswordEntity>());
    expect(result.message, 'message');
    expect(result.info, 'info');
  });
  test('test creational of ResetPasswordEntity with null values ', () {
    final result = ResetPasswordEntity(message: null, info: null);
    expect(result, isA<ResetPasswordEntity>());
    expect(result.message, isNull);
    expect(result.info, isNull);
  });
}
