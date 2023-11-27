import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/rounded_image_with_background_color.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

import '../widgets/size_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackgroundWidget(

        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.rootPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height(AppDimensions.welcomeBackSpacingBetween),
                Center(
                    child: Container(
                      height: AppDimensions.loginLogoSize,
                      // width: .7.sw,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          image: DecorationImage(
                            image: AssetImage(
                              AssetsPath.logo,
                            ),
                          )),
                    )),
                height(AppDimensions.welcomeBackSpacingBetween),
                textWidget(text: AppStrings.helloThere),
                textWidget(
                  text: AppStrings.welcomeBack,
                  fontFamily: AppFont.gilroyBold,
                  fontSize: AppDimensions.textHeadingSize,
                  color: AppColors.textBlackColor,
                  fontWeight: AppDimensions.headingFontWeight,
                ),
                height(AppDimensions.welcomeBackSpacingBetween),
                const CustomTextFormField(
                  label: AppStrings.emailAddress,
                  // hintText: AppStrings.emailAddress,
                ),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                const CustomTextFormField(
                    label: AppStrings.password, isPasswordField: true),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                //
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.forgotPasswordScreenRoute);
                      },
                      child: textWidget(
                          text: AppStrings.forgotPasswordLogin,
                          fontFamily: AppFont.gilroyMedium,
                          color: AppColors.textBlackColor),
                    )),
                height(AppDimensions.loginButtonVerticalSpacingBetween),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: customMaterialButton(
                      name: AppStrings.login,
                      onPressed: () {
                        print('Button Pressed');
                        // EasyLoading.show();
                        // Navigator.pushNamed(context, AppRoutes.homeScreenRoute);
                        // Navigator.pushNamed(context, AppRoutes.homeScreenRoute);
                        Navigator.pushNamedAndRemoveUntil(context,
                            AppRoutes.bottomTabsScreenRoute, (route) => false);
                      }),
                ),
                height(AppDimensions.loginButtonVerticalSpacingBetween),
                Padding(
                    padding: EdgeInsets.only(
                        right: AppDimensions.orContinueWithPadding,
                        left: AppDimensions.orContinueWithPadding),
                    child: Image.asset(AssetsPath.continueWith)),
                height(AppDimensions.loginButtonVerticalSpacingBetween),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RoundedImageWithBackgroundColor(
                      onTap: () {},
                      assetPath: AssetsPath.google,
                      backgroundColor: AppColors.whiteColor,
                      socialButtonSize:
                          AppDimensions.socialButtonGoogleBackgroundSize,
                      imageHeight: AppDimensions.socialButtonImageGoogleSize,
                      imageWidth: AppDimensions.socialButtonImageGoogleSize,
                    ),
                    RoundedImageWithBackgroundColor(
                      onTap: () {},
                      assetPath: AssetsPath.apple,
                      backgroundColor: AppColors.whiteColor,
                      socialButtonSize:
                          AppDimensions.socialButtonBackgroundSize,
                      imageHeight: AppDimensions.socialButtonImageSize,
                      imageWidth: AppDimensions.socialButtonImageSize,
                    ),
                    RoundedImageWithBackgroundColor(
                      onTap: () {},
                      assetPath: AssetsPath.fb,
                      backgroundColor: AppColors.whiteColor,
                      socialButtonSize:
                          AppDimensions.socialButtonBackgroundSize,
                      imageHeight: AppDimensions.socialButtonImageSize,
                      imageWidth: AppDimensions.socialButtonImageSize,
                    ),
                  ],
                ),
                height(AppDimensions.loginButtonVerticalSpacingBetween - 4),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: AppStrings.continueWithGoogle,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: AppDimensions.textSizeTermsAndConditions,
                            fontFamily: AppFont.gilroyRegular,
                            color: AppColors.blackColor),
                      ),
                      TextSpan(
                        text: AppStrings.termsAndConditions,
                        style: TextStyle(
                            fontWeight: AppDimensions.headingFontWeight,
                            fontSize: AppDimensions.textSizeTermsAndConditions,
                            fontFamily: AppFont.gilroySemiBold,
                            color: AppColors.blackColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context,
                                AppRoutes.termsAndConditionsScreenRoute);
                            print("Clicked");
                          },
                      ),
                      TextSpan(
                        text: ' & ',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: AppDimensions.textSizeTermsAndConditions,
                            fontFamily: AppFont.gilroyRegular,
                            color: AppColors.blackColor),
                      ),
                      TextSpan(
                        text: AppStrings.privacyPolicy,
                        style: TextStyle(
                            fontWeight: AppDimensions.headingFontWeight,
                            fontSize: AppDimensions.textSizeTermsAndConditions,
                            fontFamily: AppFont.gilroySemiBold,
                            color: AppColors.blackColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                                context, AppRoutes.privacyPolicyScreenRoute);
                            print("Clicked");
                          },
                      ),
                    ],
                  ),
                ),
                height(AppDimensions.loginButtonVerticalSpacingBetween - 4),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: AppStrings.notAMember,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize:
                                  AppDimensions.textSizeTermsAndConditions,
                              fontFamily: AppFont.gilroyMedium,
                              color: AppColors.greyColor),
                        ),
                        TextSpan(
                          text: AppStrings.signUpNow,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.textSizeTermsAndConditions,
                            fontFamily: AppFont.gilroyBold,
                            color: AppColors.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("Clicked");
                              Navigator.pushNamed(
                                  context, AppRoutes.signupScreenRoute);
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
      ),
    );
  }
}
