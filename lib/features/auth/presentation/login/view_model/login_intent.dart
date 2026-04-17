sealed class Intent {}

final class LoginIntent extends Intent {
  final String email;
  final String password;
  LoginIntent({required this.email, required this.password});
}

final class FormChangedIntent extends Intent {
  final String email;
  final String password;

  FormChangedIntent({required this.email, required this.password});
}

final class RegisterIntent extends Intent {}

final class ForgetPasswordIntent extends Intent {}

sealed class LoginUIEvents {}

final class LoginViewShowToast extends LoginUIEvents {
  final String message;
  final bool isError;

  LoginViewShowToast({
    this.message = "Something went wrong",
    this.isError = false,
  });
}

final class NavigateToRegister extends LoginUIEvents {}

final class NavigateToForgetPassword extends LoginUIEvents {}
