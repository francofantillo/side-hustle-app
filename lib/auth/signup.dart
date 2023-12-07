import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/auth/otp_verification.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
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
  final _loginFormKey = GlobalKey<FormState>();
  late final AuthCubit bloc;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isTCAndPPAccepted = false;

  @override
  void initState() {
    bloc = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      body: Form(
        key: _loginFormKey,
        child: SingleChildScrollView(
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
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: textWidget(text: AppStrings.helloThere),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: textWidget(
                      text: AppStrings.registerYourSelf,
                      fontSize: AppDimensions.textHeadingSize,
                      fontFamily: AppFont.gilroyBold,
                      fontWeight: AppDimensions.headingFontWeight,
                      color: AppColors.textBlackColor),
                ),
                height(AppDimensions.fieldsVerticalSpacingBetween + 0.01.sw),
                const CustomTextFormField(
                  isShowShadow: true,
                  isShowBoarder: false,
                  label: AppStrings.firstName,
                ),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                const CustomTextFormField(
                  isShowShadow: true,
                  isShowBoarder: false,
                  label: AppStrings.lastName,
                ),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                const CustomTextFormField(
                  isShowShadow: true,
                  isShowBoarder: false,
                  label: AppStrings.emailAddress,
                ),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                PhoneNumberTextField(
                  isShowShadow: true,
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
                  isShowShadow: true,
                  isShowBoarder: false,
                  label: AppStrings.zipCode,
                ),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                const CustomTextFormField(
                  isShowShadow: true,
                  isShowBoarder: false,
                  label: AppStrings.password,
                ),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                const CustomTextFormField(
                  isShowShadow: true,
                  isShowBoarder: false,
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
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: AppStrings.agreeToSideHustle,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize:
                                      AppDimensions.textSizeTermsAndConditions,
                                  fontFamily: AppFont.gilroyRegular,
                                  color: AppColors.blackColor),
                            ),
                            TextSpan(
                              text: AppStrings.termsAndConditions,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      AppDimensions.textSizeTermsAndConditions,
                                  fontFamily: AppFont.gilroySemiBold,
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
                                  fontFamily: AppFont.gilroyRegular,
                                  color: AppColors.blackColor),
                            ),
                            TextSpan(
                              text: AppStrings.privacyPolicy,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      AppDimensions.textSizeTermsAndConditions,
                                  fontFamily: AppFont.gilroySemiBold,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomMaterialButton(
                      name: AppStrings.register,
                      onPressed: () async {
                        print('Button Pressed');
                        // if (_loginFormKey.currentState!.validate()) {
                        //   // await bloc.signUpCubit(firstName: )
                        // } else {
                        //
                        // }
                        // await bloc.signUpCubit(firstName: )
                        Navigator.pushNamed(
                            context, AppRoutes.otpVerificationScreenRoute,
                            arguments:
                                const OtpVerificationScreen(isSocial: true));
                      }),
                ),
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
                              fontFamily: AppFont.gilroyRegular,
                              color: AppColors.greyColor),
                        ),
                        TextSpan(
                          text: AppStrings.login,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.textSizeTermsAndConditions,
                            fontFamily: AppFont.gilroyBold,
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
      ),
    );
  }
}
