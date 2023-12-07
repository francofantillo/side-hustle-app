import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AppDialogues {
  /// Post your Side Hustle Dialogue
  static AwesomeDialog noHeaderDialogue(
      {required BuildContext context,
      Widget? body,
      Color? backgroundColor,
      bool? dismissOnTouchOutside}) {
    return AwesomeDialog(
        // width: 1.sw,
        // dialogBorderRadius: BorderRadius.circular(30), // Set the desired border radius
        dialogBackgroundColor: backgroundColor ?? Colors.white,
        context: context,
        dismissOnTouchOutside: dismissOnTouchOutside ?? false,
        dialogType: DialogType.noHeader,
        animType: AnimType.scale,
        alignment: Alignment.center,
        body: body);
  }

}
