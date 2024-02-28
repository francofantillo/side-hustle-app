class AppValidationMessages {
  static const String firstTimeNotSelected = "Please select start time";
  static const String timeValidation = "Please select a valid time";

  /// API Validations
  static const bool success = true;
  static const String failedMessage = "Something went wrong!";

  /// Fields Validation
  /***
      Email
   ***/
  static const String EMAIL_INVALID_ERROR = "Please enter valid email address.";
  static const String EMAIL_EMPTY_ERROR =
      "Email addrress field can\'t be empty.";

  /***
      Password
   ***/
  static const String PASSWORD_EMPTY_ERROR = "Password field can't be empty.";
  static const String OLD_PASSWORD_EMPTY_ERROR =
      "Existing Password field can't be empty.";
  // static const String PASSWORD_INVALID_LENGTH_ERROR =
  //     "Existing password incorrect";
  static const String PASSWORD_INVALID_LENGTH_ERROR =
      "At least 12 characters long but 14 or more is better.";

  static const String PASSWORD_INVALID_ERROR =
      "Password at least 12 characters long and contains at least 1 uppercase, 1 lowercase, 1 digit and 1 special character.";
  static const String NEW_PASSWORD_EMPTY_ERROR =
      "New Password field can't be empty.";

  /***
      PHONE NO
   ***/
  static const String PHONE_NO_EMPTY_ERROR =
      'Phone number field can\'t be empty.';
  static const String PHONE_NO_INVALID_LENGTH = 'Invalid phone number.';

  /***
      Confirm Password
   ***/
  static const String CONFIRM_PASSWORD_EMPTY_ERROR =
      "Confirm Password field can't be empty.";
  static const String CONFIRM_NEW_PASSWORD_EMPTY_ERROR =
      "New password field can’t be empty";
  static const String PASSWORD_SAME_ERROR =
      "Old password and New password can't be same";
  static const String PASSWORD_DIFFERENT_ERROR =
      "Password and Confirm Password must be same.";
  static const String NEW_PASSWORD_DIFFERENT_ERROR =
      " New Password and Confirm Password must be same.";
  static const String CONFIRM_NEW_PASSWORD_DIFFERENT_ERROR =
      " New Password and Confirm New Password must be same.";
  static const String LOGOUT_SUCCESSFULLY = "Logout successfully.";
  static const String NAME_ERROR = "Name can't be more than 30 characters.";
  static const String BIO_ERROR = "Bio can't be more than 275 characters.";

/***
    OTP
 ***/
  static const String OTP_CODE = "Please enter the complete otp";
}
