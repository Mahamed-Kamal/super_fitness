const String _mainPath = "assets/svgs";
const String _imagesPath = "assets/images";

abstract final class AssetsManager {
  // =============== Animations ===============

  static const String lottieError = 'assets/animation/lottie_error.json';

  // =============== Images ===============
  static const String appLogoSvg = 'assets/images/app_logo.svg';
  static const String onBoarding1Gif = 'assets/images/on_boarding1.gif';
  static const String robotSkippingGif = 'assets/images/robot_skipping.gif';

  static const String authBackground = 'assets/images/auth_background.png';
  static const String chatBackground = 'assets/images/chat_background.jpg';
  static const String homeBackground = 'assets/images/home_background.jpg';
  static const String profileBackground =
      'assets/images/profile_background.jpg';
  static const String placeholder = 'assets/images/placeholder.png';

  // =================== Onboarding ===================
  static const String onBoardingBackground = "assets/images/onboarding_bg.png";
  static const String onBoardingScreenOne =
      "assets/images/onboarding_screen_one.png";
  static const String onBoardingScreenTwo =
      "assets/images/onboarding_screen_two.png";
  static const String onBoardingScreenThree =
      "assets/images/onboarding_screen_three.png";

  // =============== Icons ===============
  static const String icGymSvg = 'assets/images/ic_gym.svg';
  static const String icHomeSvg = 'assets/images/ic_home.svg';
  static const String icChatAiSvg = 'assets/images/ic_chatAi.svg';
  static const String icProfileSvg = 'assets/images/ic_profile.svg';
  static const String icMaleSvg = 'assets/images/ic_male.svg';
  static const String icFemaleSvg = 'assets/images/ic_female.svg';
  static const String icBackSvg = 'assets/images/ic_back.svg';

  // ======================= SVG =======================
  static const String exploreSvg = '$_mainPath/explore.svg';
  static const String chatSvg = '$_mainPath/chat_ai.svg';
  static const String gymSvg = '$_mainPath/gym.svg';
  static const String profileSvg = '$_mainPath/profile.svg';
  static const String selectedExploreSvg = '$_mainPath/select_explore.svg';
  static const String selectedChatSvg = '$_mainPath/select_chat_ai.svg';
  static const String selectedGymSvg = '$_mainPath/select_gym.svg';
  static const String selectedProfileSvg = '$_mainPath/select_profile.svg';
  static const String arrowBackSvg = '$_mainPath/arrow_back.svg';
  static const String drawerSvg = "$_mainPath/drawer.svg";

  // ======================= Smart Chat =======================

  static const String smartChatBg = 'assets/images/smart_chat_bg.png';
  static const String robot = "assets/images/robot.png";
  //===========================Explore===========================
  static const String exploreBg = "$_imagesPath/explore_bg.png";
  static const String trainer = "$_imagesPath/trainer.png";
  static const String yoga = "$_imagesPath/yoga.png";
  static const String gym = "$_imagesPath/gym.png";
  static const String aerobics = "$_imagesPath/aerobics.png";
  static const String fitness = "$_imagesPath/fitness.png";
  static const String gymComingSoon = "$_imagesPath/gym_coming_soon.jpg";
}
