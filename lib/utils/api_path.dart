
class API {

  /// Base Url
  static const String BASE_URL = "https://side-hustle.trangotech.dev/api";

  static const String SIGNUP = "${BASE_URL}/auth/register";
  static const String VERIFIFY_OTP = "${BASE_URL}/auth/verify-token";
  static const String LOGIN = "${BASE_URL}/auth/login";
  static const String FORGOT_PASSWORD = "${BASE_URL}/auth/forgot-password";
  static const String RESET_PASSWORD = "${BASE_URL}/auth/set-password";
  static const String CHANGE_PASSWORD = "${BASE_URL}/change-password";
  static const String LOGOUT = "${BASE_URL}/logout";

}