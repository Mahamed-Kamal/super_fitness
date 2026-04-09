
sealed class ForgetPasswordIntent {}


class SendResetPasswordCodeIntent extends ForgetPasswordIntent {
  final String email;
  SendResetPasswordCodeIntent(this.email);
}
class VerifyResetCodeIntent extends ForgetPasswordIntent {
  final String verificationCode;
  VerifyResetCodeIntent(this.verificationCode);
}

class ResendOtpIntent extends ForgetPasswordIntent {

}





sealed class ForgetPasswordUiIntent {}
class ShowToast extends ForgetPasswordUiIntent {
  final String message;
  final bool isError;

  ShowToast({required this.message, required this.isError});
}

class NavigateToOtpViewIntent extends ForgetPasswordUiIntent {}
class NavigateToResetPasswordViewIntent extends ForgetPasswordUiIntent {}
