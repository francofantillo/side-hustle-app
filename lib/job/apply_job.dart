import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/dialogue/apply_for_job_dialogue.dart';
import 'package:side_hustle/widgets/image_slider/image_slider.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ApplyForJob extends StatefulWidget {
  const ApplyForJob({super.key});

  @override
  State<ApplyForJob> createState() => _ApplyForJobState();
}

class _ApplyForJobState extends State<ApplyForJob> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.applyForJob,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: Builder(
        builder: (contextBuilder) {
          return SingleChildScrollView(
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
                  height(0.02.sh),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textWidget(
                            text: AppStrings.carpenter,
                            fontFamily: AppFont.gilroyBold,
                            fontWeight: FontWeight.bold,
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
                  height(0.02.sh),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ImageIcon(
                          const AssetImage(AssetsPath.location),
                          color: const Color(0xFF565656),
                          size: AppDimensions.applyForJobIconSize,
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
                  height(0.02.sh),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ImageIcon(
                          const AssetImage(AssetsPath.calender),
                          color: const Color(0xFF565656),
                          size: AppDimensions.applyForJobIconSize,
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
                  height(0.02.sh),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ImageIcon(
                          const AssetImage(AssetsPath.time),
                          color: const Color(0xFF565656),
                          size: AppDimensions.applyForJobIconSize,
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
                  height(0.01.sh),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(
                      color: AppColors.greyColor,
                    ),
                  ),
                  height(0.02.sh),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: textWidget(
                        text: AppStrings.jobPostBy,
                        maxLines: 1,
                        fontFamily: AppFont.gilroyBold,
                        fontSize: AppDimensions.textSubHeadingSizeViewForms,
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
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.otherUserProfileScreenRoute);
                              },
                              child: Row(
                                children: [
                                  CircularCacheImageWidget(
                                    showLoading: false,
                                    image: AssetsPath.userProfileJob,
                                    boarderColor: AppColors.primaryColor,
                                    imageHeight: .1.sw,
                                    imageWidth: .1.sw,
                                  ),
                                  width(.02.sw),
                                  Expanded(
                                    child: textWidget(
                                        text: AppStrings.userNameJob,
                                        fontFamily: AppFont.gilroySemiBold,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textBlackColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        IconButtonWithBackground(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.chatOneToOneScreenRoute);
                          },
                          iconPath: AssetsPath.message,
                          height: 0.12.sw,
                          width: 0.12.sw,
                          iconSize: 20,
                          backgroundColor: AppColors.primaryColor,
                          iconColor: AppColors.whiteColor,
                        )
                      ],
                    ),
                  ),
                  height(0.02.sh),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8.0,),
                    child: textWidget(
                        text: AppStrings.additionalTextDesc,
                        maxLines: 30,
                        color: AppColors.textBlackColor,
                        fontSize: AppDimensions.textSubHeadingTextSizeViewForms),
                  ),
                  height(0.05.sw),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: customMaterialButton(
                          height: AppDimensions.defaultMaterialButtonHeightHome,
                          borderRadius:
                              AppDimensions.defaultMaterialButtonRadiusHome,
                          onPressed: () {
                            AppDialogues.noHeaderDialogue(
                                    context: contextBuilder,
                                    body: const ApplyForJobDialogue())
                                .show();
                          },
                          name: AppStrings.applyForJob)),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
