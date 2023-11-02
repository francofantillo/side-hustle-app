import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/bottom_tabs/bottom_tabs.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/wanted_job/wanted_job.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            width(0.18.sw),
            textWidget(
                text: AppStrings.applyForJob,
                fontSize: AppDimensions.textSizeNormal,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor),
            const Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                CustomIcon.cancel,
                size: 26,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RoundedCornersImage(
                imageHeight: 70.h,
                imageWidth: 70.h,
                boarderColor: Colors.transparent,
              ),
              width(0.02.sw),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                      text: AppStrings.carpenter,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.textHeadingSizeHome,
                      color: AppColors.blackColor),
                  height(0.01.sh),
                  textWidget(
                      text: AppStrings.productPricingNumeric,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimensions.textSizeNormal,
                      color: AppColors.blackColor),
                ],
              )
            ],
          ),
        ),
        height(0.02.sh),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageIcon(
                const AssetImage(AssetsPath.location),
                color: AppColors.greyColorNoOpacity,
                size: 0.025.sh,
              ),
              width(0.02.sw),
              Expanded(
                child: textWidget(
                    text: AppStrings.locationText,
                    maxLines: 2,
                    fontSize: AppDimensions.textSizePerHead),
              ),
            ],
          ),
        ),
        height(0.02.sh),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageIcon(
                const AssetImage(AssetsPath.calender),
                color: AppColors.greyColorNoOpacity,
                size: 0.025.sh,
              ),
              width(0.02.sw),
              Expanded(
                child: textWidget(
                    text: AppStrings.jobDateText,
                    fontSize: AppDimensions.textSizePerHead),
              ),
            ],
          ),
        ),
        height(0.02.sh),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageIcon(
                const AssetImage(AssetsPath.time),
                color: AppColors.greyColorNoOpacity,
                size: 0.025.sh,
              ),
              width(0.02.sw),
              Expanded(
                child: textWidget(
                    text: AppStrings.jobTimeText,
                    fontSize: AppDimensions.textSizePerHead),
              ),
            ],
          ),
        ),
        height(0.03.sh),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomTextFormField(
            hintText: AppStrings.enterTheBidAmount,
            keyboardType: TextInputType.numberWithOptions(signed: false),
          ),
        ),
        height(0.02.sh),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: customMaterialButton(
              borderRadius: AppDimensions.defaultMaterialButtonRadiusHome,
              height: AppDimensions.defaultMaterialButtonHeightHome,
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
