import 'package:flutter/material.dart';
import 'package:side_hustle/auth/otp_verification.dart';
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
import 'package:side_hustle/widgets/text_field/phone_textField.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
        backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: Builder(builder: (builderContext) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.rootPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // backButton(onPressed: () {
                //   Navigator.pop(builderContext);
                // }),
                // height(AppDimensions.fieldsVerticalSpacingBetween),
                textWidget(
                    text: AppStrings.forgotPassword,
                    color: AppColors.textBlackColor,
                    fontFamily: AppFont.gilroyBold,
                    fontSize: AppDimensions.textHeadingSize,
                    fontWeight: AppDimensions.headingFontWeight),
                height(AppDimensions.forgotPasswordSpacingBetween),
                textWidget(text: AppStrings.inOrderTo, maxLines: 2, fontSize: AppDimensions.textSizeSmall),
                height(AppDimensions.welcomeBackSpacingBetween),
                PhoneNumberTextField(
                  onChanged: (phone) {
                    print("$phone");
                  },
                  onCountryChanged: (country) {
                    print(
                        "dialCode: ${country?.dialCode}, code: ${country?.code}");
                  },
                ),
                height(AppDimensions.loginButtonVerticalSpacingBetween),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: customMaterialButton(
                      name: AppStrings.continueText,
                      onPressed: () {
                        print('Button Pressed');
                        Navigator.pushNamed(
                            context, AppRoutes.otpVerificationScreenRoute,
                            arguments:
                                const OtpVerificationScreen(isSocial: false));
                      }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
