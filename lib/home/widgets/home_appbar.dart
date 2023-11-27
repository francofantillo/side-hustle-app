import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class HomeAppBar extends StatelessWidget {
  final BuildContext contextBuilder;

  const HomeAppBar({super.key, required this.contextBuilder});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButtonWithBackground(
          height: .12.sw,
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
        width(AppDimensions.topIconsSpacing),
        CircularCacheImageWidget(
          showLoading: true,
          boarderColor: AppColors.primaryColor,
          imageHeight: 42.h,
          imageWidth: 42.h,
          assetImage: AssetsPath.brandonProfile,
          // image: AlphaAppData.dpProfile,
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
        IconButtonWithBackground(
          height: .12.sw,
          width: .12.sw,
          borderRadius: 40,
          backgroundColor: Colors.transparent,
          iconColor: AppColors.greyColorNoOpacity,
          iconSize: 20,
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.notificationsScreenRoute);
          },
          iconPath: AssetsPath.notificationBell,
        ),
      ],
    );
  }
}
