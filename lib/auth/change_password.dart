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

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _changPasswordFormKey = GlobalKey<FormState>();
  late final AuthCubit _bloc;

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
      body: Form(
        key: _changPasswordFormKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.rootPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: textWidget(
                    text: AppStrings.changPassword,
                    fontFamily: AppFont.gilroyBold,
                    fontSize: AppDimensions.textHeadingSize,
                    color: AppColors.textBlackColor,
                    fontWeight: AppDimensions.headingFontWeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: textWidget(
                      text: AppStrings.changPasswordHint,
                      maxLines: 2,
                      fontSize: AppDimensions.textSizeSmall),
                ),
                height(0.05.sw),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: textWidget(
                      text: AppStrings.currentPassword,
                      maxLines: 1,
                      color: AppColors.textBlackColor,
                      fontSize: AppDimensions.textSizeSmall,
                      fontFamily: AppFont.gilroyBold,
                      fontWeight: FontWeight.w500),
                ),
                CustomTextFormField(
                    controller: _bloc.existingPasswordController,
                    fieldValidator: (value) => value?.validatePassword,
                    isShowShadow: true,
                    isShowBoarder: false,
                    label: AppStrings.currentPassword,
                    isPasswordField: true),
                height(0.09.sw),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: textWidget(
                      text: AppStrings.setNewPassword,
                      maxLines: 1,
                      color: AppColors.textBlackColor,
                      fontSize: AppDimensions.textSizeSmall,
                      fontFamily: AppFont.gilroyBold,
                      fontWeight: FontWeight.w500),
                ),
                CustomTextFormField(
                    controller: _bloc.passwordControllerSignup,
                    fieldValidator: (value) => value?.validatePassword,
                    isShowShadow: true,
                    isShowBoarder: false,
                    label: AppStrings.newPassword,
                    isPasswordField: true),
                height(0.02.sw),
                CustomTextFormField(
                    controller: _bloc.confirmPasswordControllerSignup,
                    fieldValidator: (value) => value?.validateConfirmPassword(
                        _bloc.passwordControllerSignup.text,
                        _bloc.confirmPasswordControllerSignup.text),
                    isShowShadow: true,
                    isShowBoarder: false,
                    label: AppStrings.confirmPassword,
                    isPasswordField: true),
                height(0.05.sw),
                BulletedListItem(
                  text: AppStrings.passwordRequirement,
                  maxLines: 2,
                ),
                height(0.02.sw),
                BulletedListItem(
                  text: AppStrings.passwordCombination,
                  maxLines: 2,
                ),
                height(0.04.sw),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: CustomMaterialButton(
                    onPressed: () async {
                      // Navigator.pop(context);
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (_changPasswordFormKey.currentState!.validate()) {
                        await _bloc.changePasswordCubit(
                          context: context,
                          mounted: mounted,
                        );
                      }
                    },
                    textColor: AppColors.whiteColor,
                    name: AppStrings.changPassword,
                    // borderRadius: AppDimensions.buttonBorderRadius
                  ),
                ),
                height(0.04.sw),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
