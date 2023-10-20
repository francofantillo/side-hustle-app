import 'dart:async';

import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/custom_pin_code_textField.dart';

class OtpVerificationScreen extends StatefulWidget {
  final bool isSocial;

  const OtpVerificationScreen({super.key, required this.isSocial});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  int secondsRemaining = 59;
  bool enableResend = false;
  Timer? timer;
  int currentSeconds = 0;

  String get timerText {
    return '${((secondsRemaining - currentSeconds) ~/ 60).toString().padLeft(2, '0')} : ${((secondsRemaining - currentSeconds) % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (secondsRemaining != 0) {
          setState(() {
            secondsRemaining--;
          });
        } else {
          setState(() {
            enableResend = true;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      body: _formArea(context),
    );
  }

  Widget _formArea(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.rootPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backButton(onPressed: () {
              Navigator.pop(context);
            }),
            height(AppDimensions.fieldsVerticalSpacingBetween),
            Center(
              child: textWidget(
                  text: AppStrings.otpVerification,
                  color: AppColors.textBlackColor,
                  fontSize: AppDimensions.textHeadingSize,
                  fontWeight: AppDimensions.headingFontWeight),
            ),
            height(AppDimensions.forgotPasswordSpacingBetween),
            Center(
                child: textWidget(
                    text: AppStrings.otpTextBody, textAlign: TextAlign.center)),
            height(AppDimensions.welcomeBackSpacingBetween),
            _otpPinField(context),
            height(AppDimensions.loginButtonVerticalSpacingBetween),
            _timer(),
            height(AppDimensions.loginButtonVerticalSpacingBetween),
            customMaterialButton(
                name: enableResend ? AppStrings.reSend : AppStrings.continueText,
                onPressed: () {
                  print('Button Pressed'); //
                  /// Reset Timer
                  secondsRemaining = 59;
                  enableResend = false;
                  currentSeconds = 0;
                }),
            // enableResend ? _resendCodeButton() : const SizedBox.shrink(),
            // _spaceBelowButton(),
          ],
        ),
      ),
    );
  }

  Widget _timer() {
    return Center(
      child: RoundedText(
        text: enableResend ? timerText : "Resend in $timerText",
        backgroundColor: AppColors.backIconBackgroundColor,
        textColor: AppColors.greyColor,
      ),
    );
  }

  Widget _otpPinField(BuildContext context) {
    return CustomPinCodeTextField(onComplete: (value) async {
      FocusManager.instance.primaryFocus?.unfocus();
      if (widget.isSocial) {
      } else if (!widget.isSocial) {}
    });
  }
}

class RoundedText extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const RoundedText({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
      ),
      padding: const EdgeInsets.all(10.0), // Adjust the padding as needed
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 18.0, // Adjust the font size as needed
        ),
      ),
    );
  }
}
