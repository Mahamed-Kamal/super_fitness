part of 'forget_password_view_model.dart';

class ForgetPasswordState extends Equatable {
  final BaseState<ForgotPasswordEntity>? forgotPasswordState;
  final BaseState<VerifyResetCodeEntity>? verifyResetCodeState;
  final BaseState<ResetPasswordEntity>? resetPasswordState;

  final int resendRemainingSeconds;
  final String? email;

  const ForgetPasswordState({
    this.forgotPasswordState,
    this.verifyResetCodeState,
    this.resetPasswordState,
    this.resendRemainingSeconds = 0,
    this.email,
  });
  @override
  List<Object?> get props => [
    forgotPasswordState,
    verifyResetCodeState,
    resetPasswordState,
    resendRemainingSeconds,
    email,
  ];
  ForgetPasswordState copyWith({
    BaseState<ForgotPasswordEntity>? forgotPasswordState,
    BaseState<VerifyResetCodeEntity>? verifyResetCodeState,
    BaseState<ResetPasswordEntity>? resetPasswordState,
    int? resendRemainingSeconds,
    String? email,
    bool clearEmail = false,
  }) {
    return ForgetPasswordState(
      forgotPasswordState: forgotPasswordState ?? this.forgotPasswordState,
      verifyResetCodeState: verifyResetCodeState ?? this.verifyResetCodeState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      resendRemainingSeconds:
          resendRemainingSeconds ?? this.resendRemainingSeconds,
      email: clearEmail ? null : (email ?? this.email),
    );
  }
}
