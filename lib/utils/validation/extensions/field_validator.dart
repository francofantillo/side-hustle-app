import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_validation_messages.dart';
import 'package:side_hustle/utils/constants.dart';
import 'package:side_hustle/utils/validation/regular_expressions.dart';

extension FieldValidator on String {
  //-------------- Email Validator -------------------
  get validateEmail {
    if (!RegularExpressions.EMAIL_VALID_REGIX.hasMatch(this) && isNotEmpty) {
      return AppValidationMessages.EMAIL_INVALID_ERROR;
    } else if (isEmpty) {
      return AppValidationMessages.EMAIL_EMPTY_ERROR;
    }
    return null;
  }

  bool get isValidCardNumber {
    final numberRegExp = RegExp(r"^[0-9]");
    return numberRegExp.hasMatch(this);
  }

  //---------------- Password Validator -----------------
  get validatePassword {
    if (isEmpty) {
      return AppValidationMessages.PASSWORD_EMPTY_ERROR;
    } else if (length < Constants.passwordFieldLength) {
      return AppValidationMessages.PASSWORD_INVALID_LENGTH_ERROR;
    } else if (!RegularExpressions.PASSWORD_VALID_REGIX.hasMatch(this) &&
        isNotEmpty) {
      return AppValidationMessages.PASSWORD_INVALID_ERROR;
    }
    return null;
  }

  //---------------- Empty Validator -----------------
  validateEmpty(String name) {
    if (isEmpty) {
      return '$name Field can\'t be empty.';
    } else {
      return null;
    }
  }

  //---------------- Phone Number Validator ----------
  get validatePhoneNumber {
    if (isEmpty) {
      return AppValidationMessages.PHONE_NO_EMPTY_ERROR;
    }
    // if (length < 10) {
    //   return AppValidationMessages.PHONE_NO_INVALID_LENGTH;
    // }
    else {
      return null;
    }
  }

//--------------Confirm Password Validator--------//
  String? validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return AppValidationMessages.CONFIRM_PASSWORD_EMPTY_ERROR;
    } else if (!(password == confirmPassword)) {
      return AppValidationMessages.PASSWORD_DIFFERENT_ERROR;
    } else {
      return null;
    }
  }

  //---------------- Card Cvv Validator -----------------
  String? validateCvv(cvv) {
    if (isNotEmpty) {
      if (cvv.length < 3) {
        return AppStrings.cardCVVValidation;
      } else {
        return null;
      }
    } else {
      return AppStrings.cardCVVRequired;
    }
  }

  //---------------- Card Cvv Validator -----------------
  String? validateCardNumber(cardNumber) {
    print("cardNumber: $cardNumber");
    if (cardNumber!.isNotEmpty) {
      if (cardNumber.length < 19) {
        return AppStrings.cardNumberValidation;
      } else {
        return null;
      }
    } else {
      return AppStrings.cardNumberRequired;
    }
    return null;
  }

  get validateNewPassword {
    if (isEmpty) {
      return AppValidationMessages.NEW_PASSWORD_EMPTY_ERROR;
    }
    /*else if (this.length < 8) {
      return AppValidationMessages.PASSWORD_INVALID_LENGTH_ERROR;
    }*/
    else if (!RegularExpressions.PASSWORD_VALID_REGIX.hasMatch(this) &&
        isNotEmpty) {
      return AppValidationMessages.PASSWORD_INVALID_ERROR;
    }
    return null;
  }

  String? validateChangeNewPassword(String oldPassword, String newPassword) {
    if (newPassword.isEmpty) {
      return AppValidationMessages.NEW_PASSWORD_EMPTY_ERROR;
    }
    /*else if (newPassword.length < 8) {
      return AppValidationMessages.PASSWORD_INVALID_LENGTH_ERROR;
    } */
    else if (!RegularExpressions.PASSWORD_VALID_REGIX.hasMatch(newPassword) &&
        isNotEmpty) {
      return AppValidationMessages.PASSWORD_INVALID_ERROR;
    } else if (oldPassword == newPassword) {
      return AppValidationMessages.PASSWORD_SAME_ERROR;
    } else {
      return null;
    }
  }

  //--------------New Confirm Password Validator--------//
  String? validateNewConfirmPassword(
      String newPassword, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return AppValidationMessages.CONFIRM_NEW_PASSWORD_EMPTY_ERROR;
    } else if (!(newPassword == confirmPassword)) {
      return AppValidationMessages.NEW_PASSWORD_DIFFERENT_ERROR;
    } else {
      return null;
    }
  }

  //--------------New Confirm Password Tutor Validator--------//
  String? validateNewConfirmTutorPassword(
      String newPassword, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return AppValidationMessages.CONFIRM_PASSWORD_EMPTY_ERROR;
    } else if (!(newPassword == confirmPassword)) {
      return AppValidationMessages.NEW_PASSWORD_DIFFERENT_ERROR;
    } else {
      return null;
    }
  }

  //--------------New Confirm Password Validator--------//
  String? validateChangeNewConfirmPassword(
      String newPassword, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return AppValidationMessages.CONFIRM_NEW_PASSWORD_EMPTY_ERROR;
    } else if (!(newPassword == confirmPassword)) {
      return AppValidationMessages.CONFIRM_NEW_PASSWORD_DIFFERENT_ERROR;
    } else {
      return null;
    }
  }

//---------------- OTP Validator ---------------
  String? validateOtp(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }

//   String? validateEmpty(String value) {
//     if (value == '') {
//       return "Field can't be empty";
//     }
//     return null;
//   }

// get validateNewPassword {
//   if (isEmpty) {
//     return "New password field can't be empty";
//   } else if (!RegularExpressions.PASSWORD_VALID_REGIX.hasMatch(this) && isNotEmpty) {
//     return 'New ${AppValidationMessages.PASSWORD_INVALID_ERROR_TEXT}';
//   }
//   return null;
// }
//---------------- Name Validator -----------------
  validateName(String message) {
    if (isEmpty) {
      return "Name field can't be empty";
    }
    /*else if (this.length < 8) {
      return AppValidationMessages.PASSWORD_INVALID_LENGTH_ERROR;
    } */
    else if (message.length > 30 && isNotEmpty) {
      return AppValidationMessages.NAME_ERROR;
    }
    return null;
  }

  //---------------- Bio Validator -----------------
  validateBio(String message) {
    if (isEmpty) {
      return "Bio field can't be empty";
    }
    /*else if (this.length < 8) {
      return AppValidationMessages.PASSWORD_INVALID_LENGTH_ERROR;
    } */
    else if (message.length > 275 && isNotEmpty) {
      return AppValidationMessages.BIO_ERROR;
    }
    return null;
  }

  //--------------------- old password -----------------
  get validateOldPassword {
    if (isEmpty) {
      return AppValidationMessages.OLD_PASSWORD_EMPTY_ERROR;
    }
    /*else if (this.length < 8) {
      return AppValidationMessages.PASSWORD_INVALID_LENGTH_ERROR;
    }*/
    else if (!RegularExpressions.PASSWORD_VALID_REGIX.hasMatch(this) &&
        isNotEmpty) {
      return AppValidationMessages.PASSWORD_INVALID_LENGTH_ERROR;
    }
    return null;
  }

  //---------------------  password -----------------
  get validateLoginPassword {
    if (isEmpty) {
      return AppValidationMessages.PASSWORD_EMPTY_ERROR;
    } else if (this.length < Constants.passwordFieldLength) {
      return AppValidationMessages.PASSWORD_INVALID_LENGTH_ERROR;
    }
    return null;
  }
}
