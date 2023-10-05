import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/circular_cache_image.dart';
import 'package:side_hustle/widgets/circular_image.dart';
import 'package:side_hustle/widgets/height_widget.dart';
import 'package:side_hustle/widgets/text_widget.dart';

Widget homeTopWidget(BuildContext contextBuilder) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      InkWell(
        onTap: () {
          Scaffold.of(contextBuilder).openDrawer();
        },
        child: CircularImageWidget(
            image: AssetsPath.drawer,
            imageSize: AppDimensions.drawerIconSizeHome),
      ),
      width(AppDimensions.topIconsSpacing),
      CircularCacheImageWidget(
        boarderColor: AppColors.primaryColor,
        imageSize: 42.h,
      ),
      width(0.03.sw),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWidget(
                text: AppStrings.welcomeHome,
                color: AppColors.textBlackColor,
                fontSize: AppDimensions.profileUserNameTextSize,
                maxLines: 1),
            textWidget(
                text: AppStrings.userName,
                color: AppColors.textBlackColor,
                fontSize: AppDimensions.profileEmailTextSize,
                fontWeight: FontWeight.w500,
                maxLines: 1),
          ],
        ),
      ),
      Image.asset(
        AssetsPath.notificationBell,
        // Set your desired height
        width: 20.h,
        // Set your desired width
        height: 20.h,
      )
    ],
  );
}

class HomeTopWidgets extends StatelessWidget {
  final BuildContext contextBuilder;

  const HomeTopWidgets({super.key, required this.contextBuilder});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Scaffold.of(contextBuilder).openDrawer();
          },
          child: CircularImageWidget(
              image: AssetsPath.drawer,
              imageSize: AppDimensions.drawerIconSizeHome),
        ),
        width(AppDimensions.topIconsSpacing),
        CircularCacheImageWidget(
          boarderColor: AppColors.primaryColor,
          imageSize: 42.h,
        ),
        width(0.03.sw),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textWidget(
                  text: AppStrings.welcomeHome,
                  color: AppColors.textBlackColor,
                  fontSize: AppDimensions.profileUserNameTextSize,
                  maxLines: 1),
              textWidget(
                  text: AppStrings.userName,
                  color: AppColors.textBlackColor,
                  fontSize: AppDimensions.profileEmailTextSize,
                  fontWeight: FontWeight.w500,
                  maxLines: 1),
            ],
          ),
        ),
        Image.asset(
          AssetsPath.notificationBell,
          // Set your desired height
          width: 20.h,
          // Set your desired width
          height: 20.h,
        )
      ],
    );
  }
}
