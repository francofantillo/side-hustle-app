import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
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
      showAppBar: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
        backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: SingleChildScrollView(
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
                child: textWidget(text: AppStrings.pleaseEnterNewPassword, fontSize: AppDimensions.textSizeSmall),
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
              const CustomTextFormField(
                  isShowShadow: true,
                  isShowBoarder: false,
                  label: AppStrings.newPassword, isPasswordField: true),
              height(AppDimensions.fieldsVerticalSpacingBetween),
              const CustomTextFormField(
                  isShowShadow: true,
                  isShowBoarder: false,
                  label: AppStrings.confirmPassword, isPasswordField: true),
              height(AppDimensions.fieldsVerticalSpacingBetween),
              BulletedListItem(
                text: AppStrings.atLeast12,
              ),
              height(0.02.sw),
              BulletedListItem(
                text: AppStrings.aCombinationOfUpper,
              ),
              height(AppDimensions.loginButtonVerticalSpacingBetween),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomMaterialButton(
                    name: AppStrings.continueText,
                    onPressed: () {
                      print('Button Pressed');
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.loginScreenRoute, (route) => false);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
