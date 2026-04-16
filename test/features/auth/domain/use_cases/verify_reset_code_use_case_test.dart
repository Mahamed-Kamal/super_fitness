import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entity/verify_reset_code_entity.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';
import 'package:super_fitness/features/auth/domain/use_cases/verify_reset_code_use_case.dart';

import 'forgot_password_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo authRepo;
  late VerifyResetCodeUseCase useCase;
  late VerifyResetCodeEntity verifyResetCodeEntity;

  setUp(() {
    authRepo = MockAuthRepo();
    useCase = VerifyResetCodeUseCase(authRepo);
    verifyResetCodeEntity = VerifyResetCodeEntity(message: "");
    provideDummy<Result<VerifyResetCodeEntity>>(
      SuccessResponse(data: verifyResetCodeEntity),
    );
  });
  test(' test call resetPasswordUseCase it should return success', () async {
    when(authRepo.verifyOtp(resetCode: "123")).thenAnswer((_) async {
      return SuccessResponse<VerifyResetCodeEntity>(
        data: verifyResetCodeEntity,
      );
    });

    final result = await useCase.call(resetCode: "123");
    expect(result, isA<SuccessResponse<VerifyResetCodeEntity>>());
    verify(useCase.call(resetCode: "123")).called(1);
  });
  test(' test call forgotPasswordUseCase it should return failure', () async {
    when(authRepo.verifyOtp(resetCode: "123")).thenAnswer((_) async {
      return FailureResponse<VerifyResetCodeEntity>(errorMessage: "error");
    });
    final result = await useCase.call(resetCode: "123");

    expect(result, isA<FailureResponse<VerifyResetCodeEntity>>());

    verify(useCase.call(resetCode: "123")).called(1);
  });
}
