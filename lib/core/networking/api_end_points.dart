///* EndPoints: the endpoints of the api
abstract class EndPoint {
  //TODO: change these values
  static const String baseUrl = '';
  static const String login = 'auth/login';
  static const String register = 'users/';
  static const String refreshToken = 'auth/refresh-token';
  static const String verifyOtp = 'auth/verify-otp';
  static const String resendOtp = 'auth/resend-otp';
  static const String resetPassword = 'auth/reset-password';
  static const String chatMessage = 'chatbot/chat';
  static const String savedJobs = 'saved-jobs';
  static String saveJob(dynamic jobPostId) => 'jobs/$jobPostId/save';
}

///* ApiKeys: the keys of the api
abstract class ApiKey {
  //TODO: change these values
  static const String statusCode = 'statusCode';
  static const String errorMessage = 'message';
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String email = 'email';
  static const String otp = 'otp';
  static const String newPassword = 'new_password';
  static const String page = 'page';
  static const String perPage = 'per_page';
  static const String jobId = 'job_id';
  static const String isSaved = 'is_saved';
  // static const String password = 'password';
  // static const String id = 'id';
}

///* ApiHeaderKey: the header keys of the api
abstract class ApiHeaderKey {
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer ';
  static const String acceptLanguage = 'Accept-Language';

  static String getAuthorizationValue({required String? accessToken}) =>
      '${ApiHeaderKey.bearer} $accessToken';
}
