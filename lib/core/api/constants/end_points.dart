abstract final class EndPoints {
  EndPoints._();

  static const String login = 'auth/signin';
  static const String register = 'auth/signup';
  static const String updateUserData = 'auth/editProfile';
  static const String forgotPassword = 'auth/forgotPassword';
  static const String verifyOtp = 'auth/verifyResetCode';
  static const String resetPassword = 'auth/resetPassword';
  static const String getAllMusclesGroups = 'muscles';
  static const String getMusclesByMusclesGroupID = 'musclesGroup/{id}';
  static const String changePassword = 'auth/change-password';
}
