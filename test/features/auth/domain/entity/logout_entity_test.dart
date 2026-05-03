import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness/features/auth/domain/entity/logout_entity.dart';

void main() {
  test('test creational of logoutEntity with real values ', () {
    final result = LogoutEntity(message: 'message');
    expect(result, isA<LogoutEntity>());
    expect(result.message, 'message');
  });
  test('test creational of logoutEntity with null values ', () {
    final result = LogoutEntity(message: null);
    expect(result, isA<LogoutEntity>());
    expect(result.message, isNull);
  });
}
