abstract final class EndPoints {
  EndPoints._();

  static const String login = 'auth/signin';
  static const String register = 'auth/signup';
  static const String updateUserData = 'auth/editProfile';
  static const String forgotPassword = 'auth/forgotPassword';
  static const String verifyOtp = 'auth/verifyResetCode';
  static const String resetPassword = 'auth/resetPassword';
  static const String getMusclesRandom = 'muscles/random';
  static const String getMusclesGroup = 'muscles';
  static const String getCategories =
      'https://www.themealdb.com/api/json/v1/1/categories.php';
  static const String getSpecificMusclesGroup = 'musclesGroup/{id}';
}
