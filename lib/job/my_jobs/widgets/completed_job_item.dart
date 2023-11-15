import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class CompletedJobItemWidget extends StatelessWidget {
  final String? title,
      subTitle,
      price,
      userProfile,
      userName,
      userRating,
      imagePath;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const CompletedJobItemWidget(
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
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.bookedJobRoundedBorder),
                            ),
                            child: textWidget(
                                text: AppStrings.completed,
                                fontSize: AppDimensions.textSizeVerySmall,
                                color: AppColors.textWhiteColor),
                          )
                        ],
                      ),
                      height(imageHeight! * .01),
                      SizedBox(
                        width: .5.sw,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: textWidget(
                                    text: subTitle,
                                    maxLines: 2,
                                    fontSize: AppDimensions.textSizeVerySmall)),
                          ],
                        ),
                      ),
                      height(imageHeight! * .015),
                      textWidget(
                          text: price,
                          color: AppColors.textBlackColor,
                          fontWeight: FontWeight.bold),
                      height(imageHeight! * .02),
                      Divider(
                        height: 1.h,
                      ),
                      height(imageHeight! * .04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularCacheImageWidget(
                            showLoading: false,
                            image: userProfile,
                            boarderColor: AppColors.primaryColor,
                            imageHeight: imageHeight! * .16,
                            imageWidth: imageHeight! * .16,
                          ),
                          width(.01.sw),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // place RoundedImageWithBackgroundColor at end
                              textWidget(
                                  text: userName,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textBlackColor),
                            ],
                          ),
                          const Spacer(),
                          IconButtonWithBackground(
                            onTap: () {
                              print("Clicked");
                            },
                            iconPath: AssetsPath.message,
                            height: imageHeight! * .16,
                            width: imageHeight! * .16,
                            backgroundColor: AppColors.primaryColor,
                            iconColor: AppColors.whiteColor,
                          ),
                        ],
                      ),
                      height(0.01.sh),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: AppColors.greenColor,
                            borderRadius: BorderRadius.circular(
                                AppDimensions.bookedJobRoundedBorder),
                          ),
                          child: Material(
                            color: AppColors.greenColor,
                            borderRadius: BorderRadius.circular(
                                AppDimensions.bookedJobRoundedBorder),
                            child: InkWell(
                              onTap: () {

                              },
                              child: Center(
                                child: textWidget(
                                  text: AppStrings.rateAndReview,
                                  color: AppColors.textWhiteColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  textAlign: TextAlign.center,
                                ),
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
