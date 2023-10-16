import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:side_hustle/drawer/app_drawer.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text_field/phone_textField.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      drawer: const AppDrawer(),
      body: Builder(builder: (builderContext) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.rootPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                backButton(() {
                  Navigator.pop(builderContext);
                }),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                textWidget(
                    text: AppStrings.forgotPassword,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textHeadingSize,
                    fontWeight: AppDimensions.headingFontWeight),
                height(AppDimensions.forgotPasswordSpacingBetween),
                textWidget(text: AppStrings.inOrderTo),
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
                customMaterialButton(
                    name: AppStrings.continueText,
                    onPressed: () {
                      print('Button Pressed');
                      // Navigator.pushNamed(
                      //     context, AppRoutes.otpVerificationScreenRoute,
                      //     arguments:
                      //         const OtpVerificationScreen(isSocial: false)); How to open from that
                      Scaffold.of(builderContext).openDrawer();
                    }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
