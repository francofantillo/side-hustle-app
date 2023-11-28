import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
          padding: EdgeInsets.only(
              left: AppDimensions.rootPadding,
              right: AppDimensions.rootPadding,
              bottom: AppDimensions.rootPadding),
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
              height(0.03.sh),
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
              const CustomTextFormField(
                  label: AppStrings.currentPassword, isPasswordField: true),
              height(0.07.sw),
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
              const CustomTextFormField(
                  label: AppStrings.newPassword, isPasswordField: true),
              height(0.02.sh),
              const CustomTextFormField(
                  label: AppStrings.confirmPassword, isPasswordField: true),
              height(0.05.sh),
              BulletedListItem(
                text: AppStrings.passwordRequirement,
                maxLines: 2,
              ),
              height(0.02.sh),
              BulletedListItem(
                text: AppStrings.passwordCombination,
                maxLines: 2,
              ),
              height(0.02.sh),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: CustomMaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textColor: AppColors.whiteColor,
                    name: AppStrings.changPassword,
                    borderRadius: AppDimensions.buttonBorderRadius),
              ),
              height(0.04.sh),
            ],
          ),
        ),
      ),
    );
  }
}
