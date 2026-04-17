import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entity/reset_password_entity.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';
import 'package:super_fitness/features/auth/domain/use_cases/reset_password_use_case.dart';

import 'forgot_password_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo authRepo;
  late ResetPasswordUseCase useCase;
  late ResetPasswordEntity resetPasswordEntity;

  setUp(() {
    authRepo = MockAuthRepo();
    useCase = ResetPasswordUseCase(authRepo);
    resetPasswordEntity = ResetPasswordEntity(message: "");
    provideDummy<Result<ResetPasswordEntity>>(
      SuccessResponse(data: resetPasswordEntity),
    );
  });
  test(' test call resetPasswordUseCase it should return success', () async {
    when(
      authRepo.resetPassword(email: "email", newPassword: "newPassword"),
    ).thenAnswer((_) async {
      return SuccessResponse<ResetPasswordEntity>(data: resetPasswordEntity);
    });

    final result = await useCase.call(
      email: 'email',
      newPassword: "newPassword",
    );
    expect(result, isA<SuccessResponse<ResetPasswordEntity>>());
    verify(useCase.call(email: 'email', newPassword: "newPassword")).called(1);
  });
  test(' test call forgotPasswordUseCase it should return failure', () async {
    when(
      authRepo.resetPassword(email: "email", newPassword: "newPassword"),
    ).thenAnswer((_) async {
      return FailureResponse<ResetPasswordEntity>(errorMessage: "error");
    });
    final result = await useCase.call(
      email: 'email',
      newPassword: "newPassword",
    );

    expect(result, isA<FailureResponse<ResetPasswordEntity>>());

    verify(useCase.call(email: 'email', newPassword: "newPassword")).called(1);
  });
}
