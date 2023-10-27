import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/images/rounded_image_with_background_color.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ScheduledJobItemWidget extends StatelessWidget {
  final String? title,
      subTitle,
      price,
      userProfile,
      userName,
      userRating,
      imagePath;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const ScheduledJobItemWidget(
      {super.key,
        this.title,
        this.subTitle,
        this.price,
        this.userProfile,
        this.userName,
        this.userRating,
        this.imagePath,
        this.imageHeight,
        this.imageWidth,
        this.boarderColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageHeight,
      width: imageWidth,
      child: Card(
        elevation: 6,
        color: boarderColor,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 6.0, left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RoundedCornersImage(
                imageHeight: imageHeight,
                imageWidth: AppDimensions.listItemWidth,
                assetImage: imagePath,
                boarderColor: boarderColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: textWidget(
                                  text: title,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppDimensions.textSizeSmall,
                                  color: AppColors.textBlackColor)),


                        ],
                      ),
                      height(imageHeight! * .01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: textWidget(text: subTitle, maxLines: 2,
                                  fontSize: AppDimensions.textSizeVerySmall)),
                          width(0.02.sw),
                          IconButtonWithBackground(
                            onTap: () {
                              print("Clicked");
                            },
                            iconPath: AssetsPath.edit,
                            height: imageHeight! * .22,
                            width: imageHeight! * .22,
                            backgroundColor: AppColors.primaryColor,
                            iconColor: AppColors.whiteColor,
                          ),
                        ],
                      ),
                      height(imageHeight! * .04),
                      textWidget(
                          text: price,
                          color: AppColors.textBlackColor,
                          fontWeight: FontWeight.bold),
                      height(imageHeight! * .03),
                      Expanded(
                        child: InkWell(
                          onTap:(){
                            print("Clicked");
                          },
                          highlightColor: AppColors.greenColor,
                          splashColor: AppColors.greyColor,
                          child: Container(
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.bookedJobRoundedBorder),
                            ),
                            child: Center(
                              child: textWidget(
                                text: AppStrings.viewRequest,
                                color: AppColors.textWhiteColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
