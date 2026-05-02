abstract final class EndPoints {
  EndPoints._();

  static const String login = 'auth/signin';
  static const String register = 'auth/signup';
  static const String updateUserData = 'auth/editProfile';
  static const String uploadProfilePhoto = 'auth/upload-photo';
  static const String getProfileData = 'auth/profile-data';
  static const String forgotPassword = 'auth/forgotPassword';
  static const String verifyOtp = 'auth/verifyResetCode';
  static const String resetPassword = 'auth/resetPassword';
}
