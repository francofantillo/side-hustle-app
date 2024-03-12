
class API {

  /// Base Url
  static const String BASE_URL = "https://side-hustle.trangotech.dev/api";
  static const String BASE_URL_IMAGE = "https://side-hustle.trangotech.dev/";
  static const String CHAT_SOCKET_API_BASE_URL = "http://socketside-hustle.trangotech.dev:3017";
  // static const String CHAT_SOCKET_API_BASE_URL = "http://socketconstruction-connect.trangotech.dev:3014";

  /////////////// SOCKET CHAT RESPONSE KEYS ////////////////
  static const String GET_MESSAGES_KEY = "get_messages";
  // static const String GET_MESSAGE_KEY = "get_message";
  static const String GET_MESSAGE_KEY = "message";
  static const String CONNECT_USER_KEY = "connect_user";
  /////////////// SOCKET CHAT EMIT EVENTS ////////////////
  static const String GET_MESSAGES_EVENT = "get_messages";
  static const String SEND_MESSAGE_EVENT = "message";
  static const String CONNECT_EVENT = "connect_user";

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
  static const String GET_PROFILE = "${BASE_URL}/your-profile";
  static const String UPDATE_FCM = "${BASE_URL}/update-fcm-token";
  static const String ALLOW_PUSH = "${BASE_URL}/is-notification";
  static const String GET_DASHBOARD = "${BASE_URL}/dashboard";
  static const String GET_Notifications = "${BASE_URL}/notifications";

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
  static const String ADD_SIDE_HUSTLE = "${BASE_URL}/add-product";
  static const String UPDATE_SIDE_HUSTLE = "${BASE_URL}/update-product";
  static const String GET_EDIT_PRODUCT_OR_SERVICE = "${BASE_URL}/edit-product";
  static const String GET_YOUR_SHOP = "${BASE_URL}/your-shop";
  static const String VIEW_SHOP = "${BASE_URL}/view-shop";
  static const String EDIT_YOUR_SHOP = "${BASE_URL}/edit-shop";
  static const String GET_DELETE_SIDEHUSTLE = "${BASE_URL}/delete-product";
  static const String GET_SIDEHUSTLE = "${BASE_URL}/products";
  static const String GET_SIDEHUSTLE_DETAIL = "${BASE_URL}/product-detail";
  /// Side Hustle Cart
  static const String ADD_TO_CART = "${BASE_URL}/add-cart";
  static const String UPDATE_CART = "${BASE_URL}/update-cart";
  static const String GET_SIDEHUSTLE_CART = "${BASE_URL}/view-cart";
  static const String CHECKOUT = "${BASE_URL}/place-order";
  static const String UPDATE_DELIVERY_ADDRESS = "${BASE_URL}/update-address";

  /// Chats
  static const String GET_CHAT_LIST = "${BASE_URL}/getChats";
  static const String BLOCKED_USERS_CHAT_LIST = "${BASE_URL}/blocked-users";
  static const String BLOCK_USER = "${BASE_URL}/block-user";
  static const String UN_BLOCK_USER = "${BASE_URL}/unblock-user";
  static const String GET_MESSAGES = "${BASE_URL}/getChatMessages";
  static const String UPLOAD_IMAGE = "${BASE_URL}/chatFileUpload";
}