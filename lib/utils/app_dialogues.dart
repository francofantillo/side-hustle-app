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

  static AwesomeDialog showCartClearInfo(
      {required BuildContext context, required Function()? onPressedOk}) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.info,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'You are trying to add product from different shop. Your cart will be cleared',
            style: TextStyle(fontStyle: FontStyle.normal),
          ),
        ),
      ),
      title: 'This is Ignored',
      desc: 'This is also Ignored',
      btnOkOnPress: onPressedOk,
      btnCancelOnPress: () {},
      btnCancelText: "Cacel",
    );
  }
}
