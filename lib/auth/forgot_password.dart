import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_hustle/auth/otp_verification.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';
import 'package:side_hustle/utils/validation/extensions/field_validator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotPasswordFormKey = GlobalKey<FormState>();
  late final AuthCubit _bloc;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    _bloc = BlocProvider.of<AuthCubit>(context);
    _bloc.initControllers();
    super.initState();
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
      body: Builder(builder: (builderContext) {
        return Form(
          key: _forgotPasswordFormKey,
          child: SingleChildScrollView(
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
                  textWidget(
                      text: AppStrings.inOrderTo,
                      maxLines: 2,
                      fontSize: AppDimensions.textSizeSmall),
                  height(AppDimensions.welcomeBackSpacingBetween),
                  CustomTextFormField(
                    controller: _bloc.emailControllerSignup,
                    hintText: "Enter your email address",
                    keyboardType: TextInputType.emailAddress,
                    isShowShadow: true,
                    fieldValidator: (value) {
                      return value?.validateEmail;
                    },
                    onChanged: (value) {
                      print("Email: $value");
                    },
                  ),
                  height(AppDimensions.loginButtonVerticalSpacingBetween),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomMaterialButton(
                        name: AppStrings.continueText,
                        textColor: AppColors.whiteColor,
                        onPressed: () async {
                          print('Button Pressed');
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (_forgotPasswordFormKey.currentState!.validate()) {
                            await _bloc
                                .forgotPasswordCubit(
                              context: context,
                              mounted: mounted,
                            )
                                .then((value) {
                              if (value == 1) {
                                Navigator.pushNamed(context,
                                    AppRoutes.otpVerificationScreenRoute,
                                    arguments: OtpVerificationScreen(
                                      isForgotPassword: true,
                                      email: _bloc.emailControllerSignup.text,
                                    ));
                                // Navigator.pushNamed(context, AppRoutes.otpVerificationScreenRoute,
                                //     arguments: const OtpVerificationScreen(isForgotPassword: true));
                              }
                            });
                          }
                          // Navigator.pushNamed(
                          //     context, AppRoutes.otpVerificationScreenRoute,
                          //     arguments:
                          //         const OtpVerificationScreen(isSocial: false));
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
