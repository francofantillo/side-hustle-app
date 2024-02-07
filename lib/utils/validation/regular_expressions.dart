import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegularExpressions {
  RegularExpressions._();

  static RegExp PASSWORD_VALID_REGIX =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  static RegExp EMAIL_VALID_REGIX = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
  static MaskTextInputFormatter MASK_TEXT_FORMATTER_PHONE_NO =
      MaskTextInputFormatter(
    mask: '+1(###) ###-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  // MaskTextInputFormatter for price field allow only numbers and  decimal points
  static MaskTextInputFormatter MASK_TEXT_FORMATTER_CARD_NO = MaskTextInputFormatter(
      mask: '####-####-####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter MASK_TEXT_FORMATTER_PRICE = MaskTextInputFormatter(
    mask: '###.###.###.###', // You can adjust the mask as needed
    filter: {"#": RegExp(r'[0-9]')}, // Allow only digits (0-9)
    type: MaskAutoCompletionType.lazy,
  );

  static FilteringTextInputFormatter PRICE_FORMATTER = FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"));

}
