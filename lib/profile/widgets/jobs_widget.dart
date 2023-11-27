import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ProfileJobsWidget extends StatelessWidget {
  final String? myJobsCount;
  final String? name;
  final Function()? onTap;

  const ProfileJobsWidget({super.key, this.myJobsCount, this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // onTap: (){},
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: AppColors.backIconBackgroundColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textWidget(
                  text: myJobsCount ?? "",
                  // color: AppColors.primaryColor,
                  color: const Color(0xFF3896EE),
                  fontFamily: AppFont.gilroyBold,
                  fontSize: AppDimensions.textSizeNormal + 4.sp,
                  fontWeight: FontWeight.bold),
              textWidget(
                  text: name ?? "",
                  fontFamily: AppFont.gilroySemiBold,
                  // color: AppColors.textBlackColor,
                  color: const Color(0xFF565656),
                  fontSize: AppDimensions.textSizeVerySmall)
            ],
          )),
    );
  }
}
