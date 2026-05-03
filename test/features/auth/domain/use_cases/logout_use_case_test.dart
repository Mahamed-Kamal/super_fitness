import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entity/logout_entity.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';
import 'package:super_fitness/features/auth/domain/use_cases/logout_use_case.dart';

import 'logout_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo authRepo;
  late LogoutUseCase useCase;
  late LogoutEntity logoutEntity;
  setUpAll(() {
    authRepo = MockAuthRepo();
    useCase = LogoutUseCase(authRepo);
    logoutEntity = LogoutEntity(message: '');
    provideDummy<Result<LogoutEntity>>(SuccessResponse(data: logoutEntity));
  });
  group('LogoutUseCase', () {
    test('test call logoutUseCase', () async {
      when(authRepo.logout()).thenAnswer((_) async {
        return SuccessResponse<LogoutEntity>(data: logoutEntity);
      });
      final result = await useCase.invoke();
      verify(useCase.invoke()).called(1);
      expect(result, isA<SuccessResponse<LogoutEntity>>());
    });
    test('test call logoutUseCase it should return failure', () async {
      when(authRepo.logout()).thenAnswer((_) async {
        return FailureResponse<LogoutEntity>(errorMessage: "error");
      });
      final result = await useCase.invoke();
      verify(useCase.invoke()).called(1);
      expect(result, isA<FailureResponse<LogoutEntity>>());
    });
  });
}
