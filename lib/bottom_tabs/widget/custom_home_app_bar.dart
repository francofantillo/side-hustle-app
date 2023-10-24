import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/images/circular_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class CustomHomeAppBarWidget extends StatelessWidget {
  final BuildContext contextBuilder;
  final String title;
  final bool? hideNotificationIcon;

  const CustomHomeAppBarWidget(
      {super.key,
      required this.contextBuilder,
      required this.title,
      this.hideNotificationIcon = false});

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
        width(.23.sw),
        Expanded(
          child: textWidget(
              text: title,
              color: AppColors.textBlackColor,
              fontSize: AppDimensions.customAppBarTitleTextSize,
              fontWeight: FontWeight.w500,
              fontFamily: AppFont.gilroyBold,
              maxLines: 1),
        ),
        hideNotificationIcon == false
            ? Image.asset(
                AssetsPath.notificationBell,
                // Set your desired height
                width: 20.h,
                // Set your desired width
                height: 20.h,
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
