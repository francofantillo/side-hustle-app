
class API {

  /// Base Url
  static const String BASE_URL = "https://side-hustle.trangotech.dev/api";

  /// Auth
  static const String SIGNUP = "${BASE_URL}/auth/register";
  static const String VERIFIFY_OTP = "${BASE_URL}/auth/verify-token";
  static const String RESEND_OTP = "${BASE_URL}/auth/resend-otp-token";
  static const String LOGIN = "${BASE_URL}/auth/login";
  static const String FORGOT_PASSWORD = "${BASE_URL}/auth/forgot-password";
  static const String RESET_PASSWORD = "${BASE_URL}/auth/set-password";
  static const String CHANGE_PASSWORD = "${BASE_URL}/change-password";
  static const String LOGOUT = "${BASE_URL}/logout";

  /// Card
  static const String ADD_CARD = "${BASE_URL}/add-card";

  /// Side Hustle
  static const String ADD_PRODUCT_OR_SERVICE = "${BASE_URL}/add-product";

  /// Events
  static const String GET_EVENTS = "${BASE_URL}/events";
  static const String GET_EVENT_DETAILS = "${BASE_URL}/event-detail";
  static const String GET_INTERESTED_EVENT = "${BASE_URL}/interested-in-event";

  /// Favourites
  static const String GET_FAVOURITES = "${BASE_URL}/view-favourite";
  static const String ADD_TO_FAVOURITES = "${BASE_URL}/add-to-favourite";
  static const String REMOVE_FROM_FAVOURITES = "${BASE_URL}/remove-from-favourite";

  /// Resume
  static const String UPDATE_RESUME = "${BASE_URL}/update-resume";
  static const String GET_RESUME = "${BASE_URL}/resume";

}