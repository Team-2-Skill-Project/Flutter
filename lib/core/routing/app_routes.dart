abstract final class AppRoutes {
  AppRoutes._();

  // Splash & Onboarding
  static const String kSplashView = '/';
  static const String kOnboardingView = '/onboarding';

  // Authentication
  static const String kLoginView = '/login';
  static const String kRegisterView = '/register';
  static const String kForgetPasswordView =
      '/forgotPassword';
  static const String kOtpVerificationView = '/otp';
  static const String kCreateNewPasswordView =
      '/createNewPassword';
  static const String kPasswordChangedSuccessView =
      '/passwordChangedSuccess';

  // Main
  static const String kHomeView = '/home';

  // Jobs
  static const String jobsSearch = '/jobs/search';
  static const String jobDetails = '/jobs/details';
}
