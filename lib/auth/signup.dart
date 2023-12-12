import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/validation/extensions/field_validator.dart';
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
  final _signupFormKey = GlobalKey<FormState>();
  late final AuthCubit _bloc;

  // final TextEditingController _firstNameController = TextEditingController();
  // final TextEditingController _lastNameController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // PhoneNumber? _phoneNumber;
  // final TextEditingController _zipCodeController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _confirmPasswordController = TextEditingController();
  // bool isTCAndPPAccepted = false;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AuthCubit>(context);
    _bloc.initControllers();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      body: Form(
        key: _signupFormKey,
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
                CustomTextFormField(
                  controller: _bloc.firstNameController,
                  isShowShadow: true,
                  isShowBoarder: false,
                  label: AppStrings.firstName,
                  fieldValidator: (value) =>
                      value?.validateEmpty(AppStrings.firstName),
                ),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                CustomTextFormField(
                  controller: _bloc.lastNameController,
                  isShowShadow: true,
                  isShowBoarder: false,
                  label: AppStrings.lastName,
                  fieldValidator: (value) =>
                      value?.validateEmpty(AppStrings.lastName),
                ),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                CustomTextFormField(
                  controller: _bloc.emailControllerSignup,
                  isShowShadow: true,
                  isShowBoarder: false,
                  label: AppStrings.emailAddress,
                  fieldValidator: (value) => value?.validateEmail,
                ),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                PhoneNumberTextField(
                  isShowShadow: true,
                  validator: (value) async {
                    return value?.number == ""
                        ? "".validateEmpty("Phone Number")
                        : null;
                  },
                  onChanged: (phone) {
                    _bloc.phoneNumber = phone;
                    print("$phone");
                    print(
                        "countryISOCode: ${phone?.countryISOCode}, countryCode: ${phone?.countryCode}, number: ${phone?.number}");
                    // print("${phoneNumber?.countryCode}${phoneNumber?.number}");
                  },
                  onCountryChanged: (country) {
                    print(
                        "countryName: ${country?.name}, dialCode: ${country?.dialCode}, code: ${country?.code}");
                  },
                ),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                CustomTextFormField(
                  controller: _bloc.zipCodeController,
                  isShowShadow: true,
                  isShowBoarder: false,
                  label: AppStrings.zipCode,
                  fieldValidator: (value) =>
                      value?.validateEmpty(AppStrings.zipCode),
                ),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                CustomTextFormField(
                  controller: _bloc.passwordControllerSignup,
                  // fieldValidator: (value) =>
                  //     value?.validateEmpty(AppStrings.password),
                  isShowShadow: true,
                  isShowBoarder: false,
                  label: AppStrings.password,
                  fieldValidator: (value) => value?.validatePassword,
                ),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                CustomTextFormField(
                  controller: _bloc.confirmPasswordControllerSignup,
                  fieldValidator: (value) => value?.validateConfirmPassword(
                      _bloc.passwordControllerSignup.text,
                      _bloc.confirmPasswordControllerSignup.text),
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
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_signupFormKey.currentState!.validate()) {
                          await _bloc.signUpCubit(
                            context: context,
                            mounted: mounted,
                          );
                        }
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
                              fontSize:
                                  AppDimensions.textSizeTermsAndConditions,
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
