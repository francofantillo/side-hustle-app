import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AppDialogues {
  /// Post your Side Hustle Dialogue
  static AwesomeDialog postSideHustleDialogue(
      {required BuildContext context,
      Widget? body,
      bool? dismissOnTouchOutside}) {
    return AwesomeDialog(
        context: context,
        dismissOnTouchOutside: dismissOnTouchOutside ?? false,
        dialogType: DialogType.noHeader,
        animType: AnimType.rightSlide,
        alignment: Alignment.center,
        body: body);
  }
}
