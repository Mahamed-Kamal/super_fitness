sealed class ChangePasswordEvents {}

class ChangePasswordNavToSettings extends ChangePasswordEvents {}

class ChangePasswordShowSuccessSnackBar extends ChangePasswordEvents {}

class ChangePasswordShowErrorSnackBar extends ChangePasswordEvents {
  String errorMsg;

  ChangePasswordShowErrorSnackBar(this.errorMsg);
}
