import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/auth/otp_verification.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/custom_cache_image.dart';
import 'package:side_hustle/widgets/text/checkbox.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/phone_textField.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

import '../widgets/size_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.rootPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: CustomCacheImage(
                    showLoading: false,
                    imageHeight: AppDimensions.loginLogoSize,
                    assetImage: AssetsPath.logo,
                  ),
                ),
              ),
              textWidget(text: AppStrings.helloThere),
              textWidget(
                  text: AppStrings.registerYourSelf,
                  fontSize: AppDimensions.textHeadingSize,
                  fontFamily: AppFont.gilroyBold,
                  fontWeight: AppDimensions.headingFontWeight,
                  color: AppColors.textBlackColor),
              height(AppDimensions.fieldsVerticalSpacingBetween),
              const CustomTextFormField(
                label: AppStrings.firstName,
              ),
              height(AppDimensions.fieldsVerticalSpacingBetween),
              const CustomTextFormField(
                label: AppStrings.lastName,
              ),
              height(AppDimensions.fieldsVerticalSpacingBetween),
              const CustomTextFormField(
                label: AppStrings.emailAddress,
              ),
              height(AppDimensions.fieldsVerticalSpacingBetween),
              PhoneNumberTextField(
                onChanged: (phone) {
                  print("$phone");
                },
                onCountryChanged: (country) {
                  print(
                      "country: ${country?.name}, dialCode: ${country?.dialCode}, code: ${country?.code}");
                },
              ),
              height(AppDimensions.fieldsVerticalSpacingBetween),
              const CustomTextFormField(
                label: AppStrings.zipCode,
                // fillColor: AppColors.productTextFieldColor,
              ),
              height(AppDimensions.fieldsVerticalSpacingBetween),
              const CustomTextFormField(
                label: AppStrings.password,
              ),
              height(AppDimensions.fieldsVerticalSpacingBetween),
              const CustomTextFormField(
                label: AppStrings.confirmPassword,
              ),
              height(AppDimensions.agreeToSideHustleSpacing),
              // height(AppDimensions.loginButtonVerticalSpacingBetween - 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CheckboxWidget(
                    onChanged: (newValue) {
                      print('Checkbox value changed: $newValue');
                    },
                  ),
                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: AppStrings.agreeToSideHustle,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize:
                                    AppDimensions.textSizeTermsAndConditions,
                                fontFamily: AppFont.gilroy,
                                color: AppColors.blackColor),
                          ),
                          TextSpan(
                            text: AppStrings.termsAndConditions,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    AppDimensions.textSizeTermsAndConditions,
                                fontFamily: AppFont.gilroy,
                                color: AppColors.blackColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("Clicked");
                                Navigator.pushNamed(context,
                                    AppRoutes.termsAndConditionsScreenRoute);
                              },
                          ),
                          TextSpan(
                            text: ' & ',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize:
                                    AppDimensions.textSizeTermsAndConditions,
                                fontFamily: AppFont.gilroy,
                                color: AppColors.blackColor),
                          ),
                          TextSpan(
                            text: AppStrings.privacyPolicy,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    AppDimensions.textSizeTermsAndConditions,
                                fontFamily: AppFont.gilroy,
                                color: AppColors.blackColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("Clicked");
                                Navigator.pushNamed(context,
                                    AppRoutes.privacyPolicyScreenRoute);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              height(AppDimensions.loginButtonVerticalSpacingBetween - 4),
              customMaterialButton(
                  name: AppStrings.register,
                  onPressed: () {
                    print('Button Pressed');
                    Navigator.pushNamed(
                        context, AppRoutes.otpVerificationScreenRoute,
                        arguments:
                        const OtpVerificationScreen(isSocial: true));
                  }),
              height(AppDimensions.loginButtonVerticalSpacingBetween),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: AppStrings.alreadyAMember,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: AppDimensions.textSizeTermsAndConditions,
                            fontFamily: AppFont.gilroy,
                            color: AppColors.greyColor),
                      ),
                      TextSpan(
                        text: AppStrings.login,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimensions.textSizeTermsAndConditions,
                          fontFamily: AppFont.gilroy,
                          color: AppColors.primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                            print("Clicked");
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
