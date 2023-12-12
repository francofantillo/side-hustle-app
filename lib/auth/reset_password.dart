import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/validation/extensions/field_validator.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/bullet_text_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _resetPasswordFormKey = GlobalKey<FormState>();
  late final AuthCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<AuthCubit>(context);
    _bloc.passwordControllerSignup = TextEditingController();
    _bloc.confirmPasswordControllerSignup = TextEditingController();
    // _bloc.initControllers();
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
      body: Form(
        key: _resetPasswordFormKey,
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
                //   Navigator.pop(context);
                // }),
                // height(AppDimensions.fieldsVerticalSpacingBetween),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: textWidget(
                      text: AppStrings.setNewPassword,
                      color: AppColors.textBlackColor,
                      fontFamily: AppFont.gilroyBold,
                      fontSize: AppDimensions.textHeadingSize,
                      fontWeight: AppDimensions.headingFontWeight),
                ),
                height(AppDimensions.forgotPasswordSpacingBetween),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: textWidget(
                      text: AppStrings.pleaseEnterNewPassword,
                      fontSize: AppDimensions.textSizeSmall),
                ),
                height(AppDimensions.welcomeBackSpacingBetween),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: textWidget(
                      text: AppStrings.setNewPassword,
                      color: AppColors.textBlackColor,
                      fontFamily: AppFont.gilroyBold,
                      fontSize: AppDimensions.textSizeSmall,
                      fontWeight: AppDimensions.headingFontWeight),
                ),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                CustomTextFormField(
                    controller: _bloc.passwordControllerSignup,
                    // fieldValidator: (value) =>
                    //     value?.validateEmpty(AppStrings.password),
                    fieldValidator: (value) => value?.validatePassword,
                    isShowShadow: true,
                    isShowBoarder: false,
                    label: AppStrings.newPassword,
                    isPasswordField: true),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                CustomTextFormField(
                    controller: _bloc.confirmPasswordControllerSignup,
                    fieldValidator: (value) => value?.validateConfirmPassword(
                        _bloc.passwordControllerSignup.text,
                        _bloc.confirmPasswordControllerSignup.text),
                    isShowShadow: true,
                    isShowBoarder: false,
                    label: AppStrings.confirmPassword,
                    isPasswordField: true),
                height(AppDimensions.fieldsVerticalSpacingBetween),
                BulletedListItem(
                  text: AppStrings.atLeast12,
                ),
                height(0.02.sw),
                BulletedListItem(
                  text: AppStrings.aCombinationOfUpper,
                  maxLines: 3,
                ),
                height(AppDimensions.loginButtonVerticalSpacingBetween),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomMaterialButton(
                      name: AppStrings.continueText,
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_resetPasswordFormKey.currentState!.validate()) {
                          await _bloc.resetPasswordCubit(
                            context: context,
                            mounted: mounted,
                          );
                        }
                        print('Button Pressed');
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
