import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
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
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.rootPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton(onPressed: () {
                Navigator.pop(context);
              }),
              height(AppDimensions.fieldsVerticalSpacingBetween),
              textWidget(
                  text: AppStrings.setNewPassword,
                  color: AppColors.textBlackColor,
                  fontSize: AppDimensions.textHeadingSize,
                  fontWeight: AppDimensions.headingFontWeight),
              height(AppDimensions.forgotPasswordSpacingBetween),
              textWidget(text: AppStrings.pleaseEnterNewPassword),
              height(AppDimensions.welcomeBackSpacingBetween),
              textWidget(
                  text: AppStrings.setNewPassword,
                  color: AppColors.textBlackColor,
                  fontWeight: AppDimensions.headingFontWeight),
              height(AppDimensions.fieldsVerticalSpacingBetween),
              const CustomTextFormField(
                  label: AppStrings.newPassword, isPasswordField: true),
              height(AppDimensions.fieldsVerticalSpacingBetween),
              const CustomTextFormField(
                  label: AppStrings.confirmPassword, isPasswordField: true),
              height(AppDimensions.fieldsVerticalSpacingBetween),
              BulletedListItem(
                text: AppStrings.atLeast12,
              ),
              BulletedListItem(
                text: AppStrings.aCombinationOfUpper,
              ),
              height(AppDimensions.loginButtonVerticalSpacingBetween),
              customMaterialButton(
                  name: AppStrings.continueText,
                  onPressed: () {
                    print('Button Pressed');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
