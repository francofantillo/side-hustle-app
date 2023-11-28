import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
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
              const ImageSlider(
                hideCameraIcon: true,
              ),
              height(0.02.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                        text: AppStrings.carpenter,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFont.gilroyBold,
                        fontSize: AppDimensions.textHeadingSizeViewForms,
                        color: AppColors.textBlackColor),
                    textWidget(
                        text: AppStrings.productPricingNumeric,
                        fontFamily: AppFont.gilroyBold,
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions.textPriceSizeViewForms,
                        color: AppColors.textBlackColor),
                  ],
                ),
              ),
              height(0.02.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageIcon(
                      const AssetImage(AssetsPath.location),
                      size: AppDimensions.applyForJobIconSize,
                      color: const Color(0xFF565656),
                    ),
                    width(0.02.sw),
                    Expanded(
                      child: textWidget(
                          text: AppStrings.locationText,
                          maxLines: 2,
                          color: const Color(0xFF565656),
                          fontSize: AppDimensions.textLocationSizeViewForms),
                    ),
                  ],
                ),
              ),
              height(0.02.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageIcon(
                      const AssetImage(AssetsPath.calender),
                      size: AppDimensions.applyForJobIconSize,
                      color: const Color(0xFF565656),
                    ),
                    width(0.02.sw),
                    Expanded(
                      child: textWidget(
                          text: AppStrings.jobDateText,
                          color: const Color(0xFF565656),
                          fontSize: AppDimensions.textLocationSizeViewForms),
                    ),
                  ],
                ),
              ),
              height(0.02.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageIcon(
                      const AssetImage(AssetsPath.time),
                      size: AppDimensions.applyForJobIconSize,
                      color: const Color(0xFF565656),
                    ),
                    width(0.02.sw),
                    Expanded(
                      child: textWidget(
                          text: AppStrings.jobTimeText,
                          color: const Color(0xFF565656),
                          fontSize: AppDimensions.textLocationSizeViewForms),
                    ),
                  ],
                ),
              ),
              height(0.01.sw),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  color: AppColors.greyColor,
                ),
              ),
              height(0.02.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.jobDesc,
                    maxLines: 2,
                    fontFamily: AppFont.gilroyBold,
                    fontSize: AppDimensions.textSubHeadingSizeViewForms,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.jobDescText,
                    maxLines: 30,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSubHeadingTextSizeViewForms),
              ),
              height(0.03.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.additionalInformation,
                    maxLines: 2,
                    fontFamily: AppFont.gilroyBold,
                    fontSize: AppDimensions.textSubHeadingSizeViewForms,
                    color: AppColors.textBlackColor,
                    fontWeight: FontWeight.bold),
              ),
              height(0.01.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: textWidget(
                    text: AppStrings.additionalTextDesc,
                    maxLines: 30,
                    color: AppColors.textBlackColor,
                    fontSize: AppDimensions.textSubHeadingTextSizeViewForms),
              ),
              height(0.05.sw),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomMaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.jobRequestScreenRoute);
                    },
                    name: AppStrings.viewRequest,
                    color: AppColors.greenColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
