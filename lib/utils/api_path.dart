
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
  static const String TERMS_AND_CONDITIONS = "${BASE_URL}/terms-and-conditions";
  static const String ABOUT_US = "${BASE_URL}/about-us";
  static const String PRIVACY_POLICY = "${BASE_URL}/privacy-policy";
  static const String HOW_TO_BE_HUSTLER = "${BASE_URL}/how-to-be-hustler";

  /// Card
  static const String ADD_CARD = "${BASE_URL}/add-card";
  static const String SET_DEFAULT_CARD = "${BASE_URL}/set-default-card";
  static const String GET_CARDS = "${BASE_URL}/cards";

  /// Side Hustle
  static const String ADD_PRODUCT_OR_SERVICE = "${BASE_URL}/add-product";

  /// Events
  static const String GET_EVENTS = "${BASE_URL}/events";
  static const String GET_EVENT_DETAILS = "${BASE_URL}/event-detail";
  static const String GET_INTERESTED_EVENT = "${BASE_URL}/interested-in-event";
  static const String POST_EVENT = "${BASE_URL}/add-event";
  static const String GET_MY_EVENTS = "${BASE_URL}/my-events";
  static const String GET_ATTENDEES = "${BASE_URL}/attendees";
  static const String UPDATE_ATTENDEES_STATUS = "${BASE_URL}/update-attendees-status";

  /// Favourites
  static const String GET_FAVOURITES = "${BASE_URL}/view-favourite";
  static const String ADD_TO_FAVOURITES = "${BASE_URL}/add-to-favourite";
  static const String REMOVE_FROM_FAVOURITES = "${BASE_URL}/remove-from-favourite";

  /// Resume
  static const String UPDATE_RESUME = "${BASE_URL}/update-resume";
  static const String GET_RESUME = "${BASE_URL}/resume";

  /// Wanted Job
  // static const String POST_JOB = "${BASE_URL}/";

}