
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

  /// Events
  static const String GET_EVENTS = "${BASE_URL}/events";
  static const String GET_EVENT_DETAILS = "${BASE_URL}/event-detail";
  static const String GET_INTERESTED_EVENT = "${BASE_URL}/interested-in-event";
  static const String POST_EVENT = "${BASE_URL}/add-event";
  static const String EDIT_EVENT = "${BASE_URL}/update-event";
  static const String GET_EDIT_EVENT = "${BASE_URL}/edit-event";
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
  static const String DELETE_PDF = "${BASE_URL}/delete-resume";

  /// Wanted Job
  static const String GET_WANTED_JOBS = "${BASE_URL}/wanted-jobs";
  static const String GET_JOBS_DETAIL = "${BASE_URL}/job-detail";
  static const String POST_JOB = "${BASE_URL}/add-job";
  static const String EDIT_JOB = "${BASE_URL}/update-job";
  static const String GET_EDIT_JOB = "${BASE_URL}/edit-job";
  static const String APPLYFOR_JOB = "${BASE_URL}/apply-for-job";
  static const String GET_MY_JOBS = "${BASE_URL}/my-jobs";
  static const String GET_JOB_REQUESTS = "${BASE_URL}/job-requests";
  static const String UPDATE_JOB_REQUESTS = "${BASE_URL}/update-job-request-status";
  static const String UPDATE_JOB_STATUS = "${BASE_URL}/update-job-status";
  static const String ADD_JOB_REVIEW = "${BASE_URL}/add-review";

  /// Side Hustle
  static const String ADD_PRODUCT_OR_SERVICE = "${BASE_URL}/add-product";
  static const String GET_YOUR_SHOP = "${BASE_URL}/your-shop";

}