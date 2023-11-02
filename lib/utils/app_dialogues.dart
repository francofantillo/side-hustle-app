import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDialogues {
  /// Post your Side Hustle Dialogue
  static AwesomeDialog postSideHustleDialogue(
      {required BuildContext context,
      Widget? body,
      bool? dismissOnTouchOutside}) {
    return AwesomeDialog(
        // width: 1.sw,
        context: context,
        dismissOnTouchOutside: dismissOnTouchOutside ?? false,
        dialogType: DialogType.noHeader,
        animType: AnimType.rightSlide,
        alignment: Alignment.center,
        body: body);
  }
}
