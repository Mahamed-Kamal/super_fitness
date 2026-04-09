part of 'forget_password_view_model.dart';

class ForgetPasswordState extends Equatable {
  final BaseState<ForgotPasswordEntity>? forgotPasswordState;
  final BaseState<VerifyResetCodeEntity>? verifyResetCodeState;
  final int resendRemainingSeconds;
  final String? email;

  const ForgetPasswordState({
    this.forgotPasswordState,
    this.verifyResetCodeState,
    this.resendRemainingSeconds= 0 ,
    this.email,
  });
  @override
  List<Object?> get props => [
    forgotPasswordState,
    verifyResetCodeState,
    resendRemainingSeconds,
    email,
  ];
  ForgetPasswordState copyWith({
    BaseState<ForgotPasswordEntity>? forgotPasswordState,
    BaseState<VerifyResetCodeEntity>? verifyResetCodeState,
    int? resendRemainingSeconds,
    String? email,
  }) {
    return ForgetPasswordState(
      forgotPasswordState: forgotPasswordState ?? this.forgotPasswordState,
      verifyResetCodeState: verifyResetCodeState ?? this.verifyResetCodeState,
      resendRemainingSeconds:
          resendRemainingSeconds ?? this.resendRemainingSeconds,
      email: email ?? this.email,
    );
  }
}
