
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:side_hustle/utils/app_colors.dart';

class Themes {
  static PinTheme pinCodeFieldTheme = PinTheme(
      shape: PinCodeFieldShape.underline,
      borderRadius: BorderRadius.circular(5),
      fieldHeight: 50,
      fieldWidth: 40,
      selectedFillColor: AppColors.whiteColor,
      activeFillColor: Colors.white,
      activeColor: AppColors.primaryColor,
      inactiveFillColor: Colors.white,
      inactiveColor: AppColors.greyColor
  );
}