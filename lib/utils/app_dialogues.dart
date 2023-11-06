import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';

class AppDialogues {
  /// Post your Side Hustle Dialogue
  static AwesomeDialog postSideHustleDialogue(
      {required BuildContext context,
      Widget? body,
      Color? dialogBackgroundColor,
      bool? dismissOnTouchOutside}) {
    return AwesomeDialog(
        // width: 1.sw,
        dialogBackgroundColor: dialogBackgroundColor,
        context: context,
        dismissOnTouchOutside: dismissOnTouchOutside ?? false,
        dialogType: DialogType.noHeader,
        animType: AnimType.scale,
        alignment: Alignment.center,
        body: body);
  }

  /// Post your Side Hustle Dialogue
  static AwesomeDialog logoutDialogue(
      {required BuildContext context,
        Widget? body,
        Color? dialogBackgroundColor,
        bool? dismissOnTouchOutside}) {
    return AwesomeDialog(
      // width: 1.sw,
        dialogBackgroundColor: dialogBackgroundColor ?? AppColors.primaryColor,
        context: context,
        dismissOnTouchOutside: dismissOnTouchOutside ?? false,
        dialogType: DialogType.noHeader,
        animType: AnimType.scale,
        alignment: Alignment.center,
        body: body);
  }

}
