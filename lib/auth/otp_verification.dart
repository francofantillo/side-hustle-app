import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
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
      showAppBar: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: _formArea(context),
    );
  }

  Widget _formArea(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.rootPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // backButton(onPressed: () {
            //   Navigator.pop(context);
            // }),
            // height(AppDimensions.fieldsVerticalSpacingBetween),
            Center(
              child: textWidget(
                  text: AppStrings.otpVerification,
                  color: AppColors.textBlackColor,
                  fontFamily: AppFont.gilroyBold,
                  fontSize: AppDimensions.textHeadingSize,
                  fontWeight: AppDimensions.headingFontWeight),
            ),
            height(AppDimensions.forgotPasswordSpacingBetween),
            Center(
                child: textWidget(
                    text: AppStrings.otpTextBody,
                    color: AppColors.backIconBackgroundColor.withOpacity(0.9),
                    fontSize: AppDimensions.textSizeSmall,
                    textAlign: TextAlign.center,
                    maxLines: 3)),
            height(AppDimensions.welcomeBackSpacingBetween + 20),
            _otpPinField(context),
            height(AppDimensions.loginButtonVerticalSpacingBetween + 20),
            _timer(),
            height(AppDimensions.loginButtonVerticalSpacingBetween + 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: customMaterialButton(
                  name:
                      enableResend ? AppStrings.reSend : AppStrings.continueText,
                  onPressed: () {
                    print('Button Pressed'); //
                    if (enableResend) {
                      /// Reset Timer
                      secondsRemaining = 59;
                      enableResend = false;
                      currentSeconds = 0;
                    } else {
                      if (widget.isSocial) {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.walkthroughScreenRoute);
                      } else {
                        Navigator.pushNamed(
                            context, AppRoutes.resetPasswordScreenRoute);
                      }
                    }
                  }),
            ),
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
        backgroundColor: AppColors.backIconBackgroundColor.withOpacity(0.08),
        textColor: AppColors.greyColor,
      ),
    );
  }

  Widget _otpPinField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CustomPinCodeTextField(onComplete: (value) async {
        FocusManager.instance.primaryFocus?.unfocus();
        if (widget.isSocial) {
        } else if (!widget.isSocial) {}
      }),
    );
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
      padding: const EdgeInsets.all(14.0), // Adjust the padding as needed
      child: textWidget(
        text: text,
        fontSize: AppDimensions.textSizeVerySmall
      ),
    );
  }
}
