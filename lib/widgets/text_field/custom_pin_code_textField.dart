import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/themes.dart';

class CustomPinCodeTextField extends StatefulWidget {
  final Function onComplete;
  final TextEditingController controller;

  const CustomPinCodeTextField(
      {super.key, required this.onComplete, required this.controller});

  @override
  State<CustomPinCodeTextField> createState() => _CustomPinCodeTextFieldState();
}

class _CustomPinCodeTextFieldState extends State<CustomPinCodeTextField> {
  String currentText = "";

  // TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      keyboardType: TextInputType.number,
      // backgroundColor: AppColors.backgroundColor,
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      textStyle: TextStyle(
          fontSize: AppDimensions.otpTextSize,
          fontFamily: AppFont.gilroyBold,
          fontWeight: FontWeight.bold,
          color: AppColors.textBlackColor),
      pinTheme: Themes.pinCodeFieldTheme,
      animationDuration: const Duration(milliseconds: 300),
      cursorColor: Colors.white,
      enableActiveFill: true,
      controller: widget.controller,
      onCompleted: (v) {
        widget.onComplete(v);
        // Navigator.pushANDRemoveUntil(context, MaterialPageRoute(builder: (context) => const Login()), (route) => false);
      },
      onChanged: (value) {
        setState(() {
          currentText = value;
        });
      },
      beforeTextPaste: (text) {
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }
}
