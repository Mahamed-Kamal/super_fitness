import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entity/forget_password_entity.dart';
import 'package:super_fitness/features/auth/domain/repo/auth_repo.dart';
import 'package:super_fitness/features/auth/domain/use_cases/forgot_password_use_case.dart';

import 'forgot_password_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo authRepo;
  late ForgetPasswordUseCase useCase;
  late ForgotPasswordEntity forgotPasswordEntity;

  setUp(() {
    authRepo = MockAuthRepo();
    useCase = ForgetPasswordUseCase(authRepo);
    forgotPasswordEntity = ForgotPasswordEntity(message: "");
    provideDummy<Result<ForgotPasswordEntity>>(
      SuccessResponse(data: forgotPasswordEntity),
    );
  });
  test(' test call forgotPasswordUseCase it should return success', () async {
    when(authRepo.forgotPassword(email: "email")).thenAnswer((_) async {
      return SuccessResponse<ForgotPasswordEntity>(data: forgotPasswordEntity);
    });

    final result = await useCase.call(email: 'email');
    expect(result, isA<SuccessResponse<ForgotPasswordEntity>>());
    verify(useCase.call(email: 'email')).called(1);
  });
  test(' test call forgotPasswordUseCase it should return failure', () async {
    when(authRepo.forgotPassword(email: "email")).thenAnswer((_) async {
      return FailureResponse<ForgotPasswordEntity>(errorMessage: "error");
    });
    final result = await useCase.call(email: 'email');

    expect(result, isA<FailureResponse<ForgotPasswordEntity>>());

    verify(useCase.call(email: 'email')).called(1);
  });
}
