import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness/core/bloc/base_state.dart';
import 'package:super_fitness/core/error_handling/result.dart';
import 'package:super_fitness/features/auth/domain/entity/forget_password_entity.dart';
import 'package:super_fitness/features/auth/domain/entity/reset_password_entity.dart';
import 'package:super_fitness/features/auth/domain/entity/verify_reset_code_entity.dart';
import 'package:super_fitness/features/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:super_fitness/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:super_fitness/features/auth/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:super_fitness/features/auth/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'forget_password_view_model_test.mocks.dart';

@GenerateMocks([
  ForgetPasswordUseCase,
  VerifyResetCodeUseCase,
  ResetPasswordUseCase,
])
void main() {
  late MockForgetPasswordUseCase mockForgetPasswordUseCase;
  late MockVerifyResetCodeUseCase mockVerifyResetCodeUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;

  late ForgetPasswordViewModel viewModel;
  late ForgotPasswordEntity forgotPasswordEntity;
  late ResetPasswordEntity resetPasswordEntity;
  late VerifyResetCodeEntity verifyResetCodeEntity;

  setUp(() {
    mockForgetPasswordUseCase = MockForgetPasswordUseCase();
    mockVerifyResetCodeUseCase = MockVerifyResetCodeUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    forgotPasswordEntity = ForgotPasswordEntity(message: "");
    resetPasswordEntity = ResetPasswordEntity(message: "");
    verifyResetCodeEntity = VerifyResetCodeEntity(message: "");
    viewModel = ForgetPasswordViewModel(
      mockForgetPasswordUseCase,
      mockVerifyResetCodeUseCase,
      mockResetPasswordUseCase,
    );
    provideDummy<Result<VerifyResetCodeEntity>>(
      SuccessResponse(data: verifyResetCodeEntity),
    );
    provideDummy<Result<ResetPasswordEntity>>(
      SuccessResponse(data: resetPasswordEntity),
    );
    provideDummy<Result<ForgotPasswordEntity>>(
      SuccessResponse(data: forgotPasswordEntity),
    );
  });
  blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
    'emits [loading, success] when _sendResetPasswordCode returns Success',
    build: () {
      when(mockForgetPasswordUseCase.call(email: "email")).thenAnswer((
        _,
      ) async {
        return SuccessResponse<ForgotPasswordEntity>(
          data: forgotPasswordEntity,
        );
      });
      return viewModel;
    },
    act: (ForgetPasswordViewModel viewModel) =>
        viewModel.doIntent(SendResetPasswordCodeIntent("email")),
    expect: () {
      var state = const ForgetPasswordState(
        forgotPasswordState: BaseState(requestState: RequestState.loading),
      );
      return [
        state.copyWith(
          forgotPasswordState: const BaseState<ForgotPasswordEntity>(
            requestState: RequestState.loading,
          ),
          email: 'email',
          resendRemainingSeconds: 0,
        ),

        state.copyWith(
          forgotPasswordState: BaseState<ForgotPasswordEntity>(
            data: forgotPasswordEntity,
            requestState: RequestState.loaded,
          ),
          email: 'email',
        ),
        state.copyWith(
          forgotPasswordState: BaseState<ForgotPasswordEntity>(
            data: forgotPasswordEntity,
            requestState: RequestState.loaded,
          ),
          email: 'email',
          resendRemainingSeconds: 30,
        ),
      ];
    },
  );
  blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
    'emits [loading, error] when _sendResetPasswordCode returns Failure',
    build: () {
      when(mockForgetPasswordUseCase.call(email: "email")).thenAnswer((
        _,
      ) async {
        return FailureResponse<ForgotPasswordEntity>(errorMessage: "error");
      });
      return viewModel;
    },
    act: (ForgetPasswordViewModel viewModel) =>
        viewModel.doIntent(SendResetPasswordCodeIntent("email")),
    expect: () {
      var state = const ForgetPasswordState(
        forgotPasswordState: BaseState(requestState: RequestState.loading),
      );
      return [
        state.copyWith(
          forgotPasswordState: const BaseState<ForgotPasswordEntity>(
            requestState: RequestState.loading,
          ),
          email: 'email',
          resendRemainingSeconds: 0,
        ),
        state.copyWith(
          forgotPasswordState: BaseState<ForgotPasswordEntity>(
            errorMessage: "error",
            requestState: RequestState.error,
          ),
          email: 'email',
        ),
      ];
    },
  );

  blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
    'emits [loading, success] when _verifyResetCode returns Success',
    build: () {
      when(mockVerifyResetCodeUseCase.call(resetCode: "123")).thenAnswer((
        _,
      ) async {
        return SuccessResponse<VerifyResetCodeEntity>(
          data: verifyResetCodeEntity,
        );
      });
      return viewModel;
    },
    act: (ForgetPasswordViewModel viewModel) =>
        viewModel.doIntent(VerifyResetCodeIntent("123")),
    expect: () {
      var state = const ForgetPasswordState(
        verifyResetCodeState: BaseState(requestState: RequestState.loading),
      );
      return [
        state.copyWith(
          verifyResetCodeState: const BaseState<VerifyResetCodeEntity>(
            requestState: RequestState.loading,
          ),
        ),
        state.copyWith(
          verifyResetCodeState: BaseState<VerifyResetCodeEntity>(
            data: verifyResetCodeEntity,
            requestState: RequestState.loaded,
          ),
        ),
      ];
    },
  );
  blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
    'emits [loading, error] when _verifyResetCode returns Failure',
    build: () {
      when(mockVerifyResetCodeUseCase.call(resetCode: "123")).thenAnswer((
        _,
      ) async {
        return FailureResponse<VerifyResetCodeEntity>(errorMessage: "error");
      });
      return viewModel;
    },
    act: (ForgetPasswordViewModel viewModel) =>
        viewModel.doIntent(VerifyResetCodeIntent("123")),
    expect: () {
      var state = const ForgetPasswordState(
        verifyResetCodeState: BaseState(requestState: RequestState.loading),
      );
      return [
        state.copyWith(
          verifyResetCodeState: const BaseState<VerifyResetCodeEntity>(
            requestState: RequestState.loading,
          ),
        ),
        state.copyWith(
          verifyResetCodeState: BaseState<VerifyResetCodeEntity>(
            errorMessage: "error",
            requestState: RequestState.error,
          ),
        ),
      ];
    },
  );

  blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
    'emits [loading, success] when _resetPassword returns Success',
    build: () {
      when(
        mockResetPasswordUseCase.call(
          email: "email",
          newPassword: "newPassword",
        ),
      ).thenAnswer((_) async {
        return SuccessResponse<ResetPasswordEntity>(data: resetPasswordEntity);
      });
      return viewModel;
    },
    act: (ForgetPasswordViewModel viewModel) =>
        viewModel.doIntent(ResetPasswordIntent("email", "newPassword")),
    expect: () {
      var state = const ForgetPasswordState(
        resetPasswordState: BaseState(requestState: RequestState.loading),
      );
      return [
        state.copyWith(
          resetPasswordState: const BaseState<ResetPasswordEntity>(
            requestState: RequestState.loading,
          ),
        ),
        state.copyWith(
          resetPasswordState: BaseState<ResetPasswordEntity>(
            data: resetPasswordEntity,
            requestState: RequestState.loaded,
          ),
        ),
      ];
    },
  );
  blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
    'emits [loading, error] when _resetPassword returns Failure',
    build: () {
      when(
        mockResetPasswordUseCase.call(
          email: "email",
          newPassword: "newPassword",
        ),
      ).thenAnswer((_) async {
        return FailureResponse<ResetPasswordEntity>(errorMessage: "error");
      });
      return viewModel;
    },
    act: (ForgetPasswordViewModel viewModel) =>
        viewModel.doIntent(ResetPasswordIntent("email", "newPassword")),
    expect: () {
      var state = const ForgetPasswordState(
        resetPasswordState: BaseState(requestState: RequestState.loading),
      );
      return [
        state.copyWith(
          resetPasswordState: const BaseState<ResetPasswordEntity>(
            requestState: RequestState.loading,
          ),
        ),
        state.copyWith(
          resetPasswordState: BaseState<ResetPasswordEntity>(
            errorMessage: "error",
            requestState: RequestState.error,
          ),
        ),
      ];
    },
  );
}
