import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ViewJob extends StatefulWidget {
  const ViewJob({super.key});

  @override
  State<ViewJob> createState() => _ViewJobState();
}

class _ViewJobState extends State<ViewJob> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.viewJob,
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
              const ImageSlider(),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                        text: AppStrings.carpenter,
                        fontWeight: FontWeight.w500,
                        fontSize: AppDimensions.textHeadingSizeHome,
                        color: AppColors.textBlackColor),
                    textWidget(
                        text: AppStrings.productPricingNumeric,
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions.textSizeNormal,
                        color: AppColors.textBlackColor),
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
                      size: AppDimensions.applyForJobIconSize,
                    ),
                    width(0.02.sw),
                    Expanded(
                      child: textWidget(
                          text: AppStrings.locationText,
                          maxLines: 2,
                          fontSize: AppDimensions.textSizeVerySmall),
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
                      size: AppDimensions.applyForJobIconSize,
                    ),
                    width(0.02.sw),
                    Expanded(
                      child: textWidget(
                          text: AppStrings.jobDateText,
                          fontSize: AppDimensions.textSizeVerySmall),
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
                      size: AppDimensions.applyForJobIconSize,
                    ),
                    width(0.02.sw),
                    Expanded(
                      child: textWidget(
                          text: AppStrings.jobTimeText,
                          fontSize: AppDimensions.textSizeVerySmall),
                    ),
                  ],
                ),
              ),
              height(0.01.sh),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  color: AppColors.greyColor,
                ),
              ),
              /*   height(0.02.sh),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.jobPostBy,
                    maxLines: 2,
                    fontSize: AppDimensions.textSizeSmall,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircularCacheImageWidget(
                            showLoading: false,
                            image: AssetsPath.userProfileJob,
                            boarderColor: AppColors.primaryColor,
                            imageHeight: .09.sh,
                            imageWidth: .09.sw,
                          ),
                          width(.02.sw),
                          Expanded(
                            child: textWidget(
                                text: AppStrings.userNameJob,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textBlackColor),
                          ),
                        ],
                      ),
                    ),
                    RoundedImageWithBackgroundColor(
                      assetPath: AssetsPath.message,
                      imageHeight: .03.sh,
                      imageWidth: .06.sw,
                      backgroundColor: AppColors.primaryColor,
                      socialButtonSize: .03.sh,
                      borderRadius: 12,
                    ),
                  ],
                ),
              ),*/
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.jobDesc,
                    maxLines: 2,
                    fontSize: AppDimensions.textSizeSmall,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.jobDescText,
                    maxLines: 30,
                    fontSize: AppDimensions.textSizeVerySmall),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.additionalInformation,
                    maxLines: 2,
                    fontSize: AppDimensions.textSizeSmall,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.additionalTextDesc,
                    maxLines: 30,
                    fontSize: AppDimensions.textSizeVerySmall),
              ),
              height(0.02.sh),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: customMaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.jobRequestScreenRoute);
                    },
                    name: AppStrings.viewRequest,
                    color: AppColors.greenColor,
                    borderRadius: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
