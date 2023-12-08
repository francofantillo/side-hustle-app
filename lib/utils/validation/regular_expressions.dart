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
}
