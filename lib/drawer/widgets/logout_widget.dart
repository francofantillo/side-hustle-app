import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class LogoutDialogueWidget extends StatelessWidget {
  const LogoutDialogueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                textWidget(
                    text: AppStrings.logout,
                    fontFamily: AppFont.gilroyBold,
                    fontSize: AppDimensions.textHeadingSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                    textAlign: TextAlign.center),
                height(0.03.sh),
                textWidget(
                    text: AppStrings.logoutMessage,
                    fontSize: AppDimensions.textSizeNormal,
                    maxLines: 2,
                    color: AppColors.whiteColor,
                    textAlign: TextAlign.center),
                height(0.03.sh),
                customMaterialButton(
                    height: 10.h,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(context,
                          AppRoutes.splashScreenRoute, (route) => false);
                    },
                    name: AppStrings.logout,
                    textColor: AppColors.appRedColor,
                    color: AppColors.whiteColor),
                height(0.03.sh),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: textWidget(
                        text: AppStrings.keepMeLoggedIn,
                        fontSize: AppDimensions.textSizeNormal,
                        color: AppColors.whiteColor,
                        textAlign: TextAlign.center),
                  ),
                ),
                height(0.04.sh),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
