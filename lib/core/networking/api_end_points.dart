// EndPoints: the endpoints of the api
abstract class EndPoint {
  //TODO: change these values
  static const String baseUrl = "";
  static const String login = "auth/login";
  static const String register = "users/";
  static const String refreshToken = "auth/refresh-token";
}

// ApiKeys: the keys of the api
abstract class ApiKey {
  //TODO: change these values
  static const String statusCode = "statusCode";
  static const String errorMessage = "message";
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  // static const String email = 'email';
  // static const String password = 'password';
  // static const String id = 'id';
}

// ApiHeaderKey: the header keys of the api
abstract class ApiHeaderKey {
  static const String authorization = "Authorization";
  static const String bearer = "Bearer ";
  static const String acceptLanguage = "Accept-Language";

  static String getAuthorizationValue({required String? accessToken}) =>
      "${ApiHeaderKey.bearer} $accessToken";
}
