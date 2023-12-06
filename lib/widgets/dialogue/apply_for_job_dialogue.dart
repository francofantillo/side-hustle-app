import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/bottom_tabs/bottom_tabs.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class ApplyForJobDialogue extends StatelessWidget {
  const ApplyForJobDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            width(45.w),
            Expanded(
              child: textWidget(
                  text: AppStrings.applyForJob,
                  fontFamily: AppFont.gilroyBold,
                  textAlign: TextAlign.center,
                  fontSize: AppDimensions.textSizeNormal + 2.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor),
            ),
            // const Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                CustomIcon.cancel,
                size: 24,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RoundedCornersImage(
                // imageHeight: 0.2.sw,
                // imageWidth: 0.2.sw,
                imageHeight: 80.w,
                imageWidth: 80.w,
                boarderColor: Colors.transparent,
              ),
              width(0.02.sw),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                      text: AppStrings.carpenter,
                      fontFamily: AppFont.gilroyBold,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.textHeadingSizeViewForms,
                      color: AppColors.blackColor),
                  height(0.01.sh),
                  textWidget(
                      text: AppStrings.productPricingNumeric,
                      fontFamily: AppFont.gilroyBold,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.textPriceSizeViewForms,
                      color: AppColors.blackColor),
                ],
              )
            ],
          ),
        ),
        // height(0.02.sh),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageIcon(
                const AssetImage(AssetsPath.location),
                color: const Color(0xFF565656),
                size: 0.025.sh,
              ),
              width(0.02.sw),
              Expanded(
                child: textWidget(
                    text: AppStrings.locationText,
                    maxLines: 2,
                    fontSize: AppDimensions.textLocationSizeViewForms),
              ),
            ],
          ),
        ),
        // height(0.02.sh),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageIcon(
                const AssetImage(AssetsPath.calender),
                color: const Color(0xFF565656),
                size: 0.025.sh,
              ),
              width(0.02.sw),
              Expanded(
                child: textWidget(
                    text: AppStrings.jobDateText,
                    fontSize: AppDimensions.textLocationSizeViewForms),
              ),
            ],
          ),
        ),
        // height(0.02.sh),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.access_time_filled_rounded,
                size: AppDimensions.imageIconSizeTextFormField,
                color: const Color(0xFF565656),
              ),
              width(0.02.sw),
              Expanded(
                child: textWidget(
                    text: AppStrings.jobTimeText,
                    fontSize: AppDimensions.textLocationSizeViewForms),
              ),
            ],
          ),
        ),
        // height(0.05.sw),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: CustomTextFormField(
              hintText: AppStrings.enterTheBidAmount,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: false)
              // keyboardType: TextInputType.numberWithOptions(signed: false),
              ),
        ),
        // height(0.02.sh),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomMaterialButton(
              borderRadius: AppDimensions.defaultMaterialButtonRadiusHome,
              // height: AppDimensions.defaultMaterialButtonHeightHome,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.bottomTabsScreenRoute,
                    arguments: const BottomTabsScreen(
                      currentIndex: 1,
                      wantedTabCurrentIndex: 1,
                    ),
                    (route) => false);
              },
              name: AppStrings.submit),
        ),
        height(0.02.sh),
      ],
    );
  }
}
