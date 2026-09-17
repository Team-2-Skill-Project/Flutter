abstract final class AppRoutes {
  AppRoutes._();

  // Splash & Onboarding
  static const String kSplashView = '/';
  static const String kOnboardingView = '/onboarding';

  // Authentication
  static const String kLoginView = '/login';
  static const String kRegisterView = '/register';
  static const String kForgetPasswordView = '/forgotPassword';
  static const String kOtpVerificationView = '/otp';
  static const String kCreateNewPasswordView = '/createNewPassword';
  static const String kPasswordChangedSuccessView = '/passwordChangedSuccess';

  // Main
  static const String kHomeView = '/home';

  // Jobs
  static const String kJobsSearchView = '/jobs/search';
  static const String kJobDetailsView = '/jobs/details';

  // WebView
  static const String kWebView = '/webView';

  // Deprecated aliases kept for backwards compatibility
  @Deprecated('Use kJobsSearchView instead')
  static const String jobsSearch = kJobsSearchView;

  @Deprecated('Use kJobDetailsView instead')
  static const String jobDetails = kJobDetailsView;
}
