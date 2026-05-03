sealed class LogoutEvents {}

sealed class LogoutUiEvents {}

class LogoutEvent extends LogoutEvents {}

class ShowToast extends LogoutUiEvents {
  String message;
  bool isError;

  ShowToast({required this.message, required this.isError});
}

class NavigateToLogin extends LogoutUiEvents {}

class NavigatePop extends LogoutUiEvents {}
