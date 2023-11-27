import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class CustomHomeAppBarWidget extends StatelessWidget {
  final BuildContext contextBuilder;
  final String title;
  final bool? hideNotificationIcon, hideEditProfileIcon;

  const CustomHomeAppBarWidget(
      {super.key,
      required this.contextBuilder,
      required this.title,
      this.hideNotificationIcon = false,
      this.hideEditProfileIcon = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButtonWithBackground(
          // height: .074.sh,
          height: .12.sw,
          // width: .13.sw,
          width: .12.sw,
          borderRadius: 40,
          backgroundColor: AppColors.backIconBackgroundColor,
          iconColor: AppColors.primaryColor,
          iconSize: 14,
          onTap: () {
            Scaffold.of(contextBuilder).openDrawer();
          },
          iconPath: AssetsPath.drawer,
        ),
        // width(.23.sw),
        // width(.1.sw),
        Expanded(
          child: textWidget(
              text: title,
              color: AppColors.textBlackColor,
              fontSize: AppDimensions.textSizeNormal,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
              fontFamily: AppFont.gilroyBold,
              maxLines: 1),
        ),
        hideNotificationIcon == false
            // ? IconButtonWithBackground(
            //     // height: .074.sh,
            //     height: .12.sw,
            //     // width: .13.sw,
            //     width: .12.sw,
            //     borderRadius: 40,
            //     backgroundColor: AppColors.backIconBackgroundColor,
            //     iconColor: AppColors.primaryColor,
            //     iconSize: 14,
            //     onTap: () {
            //       print("clicked minus");
            //     },
            //     iconPath: AssetsPath.notificationBell,
            //   )
            ? IconButtonWithBackground(
                // height: .074.sh,
                height: .12.sw,
                // width: .13.sw,
                width: .12.sw,
                borderRadius: 40,
                backgroundColor: Colors.transparent,
                iconColor: AppColors.greyColorNoOpacity,
                iconSize: 20,
                onTap: () {
                  Navigator.pushNamed(
                      context, AppRoutes.notificationsScreenRoute);
                },
                iconPath: AssetsPath.notificationBell,
              )
            : const SizedBox.shrink(),
        hideEditProfileIcon == false
            ? IconButtonWithBackground(
                // height: .074.sh,
                height: .12.sw,
                // width: .13.sw,
                width: .12.sw,
                borderRadius: 40,
                backgroundColor: AppColors.backIconBackgroundColor,
                iconColor: AppColors.primaryColor,
                iconSize: 14,
                onTap: () {
                  print("clicked minus");
                },
                iconPath: AssetsPath.edit,
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
