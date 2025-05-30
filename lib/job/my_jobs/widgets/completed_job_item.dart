import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class CompletedJobItemWidget extends StatelessWidget {
  final String? title, desc, price, userProfile, userName, imagePath;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;
  final int isReviewed;
  final Function()? onTapRate;

  const CompletedJobItemWidget(
      {super.key,
      this.title,
      this.isReviewed = 0,
      this.desc,
      this.price,
      this.userProfile,
      this.onTapRate,
      this.userName,
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
        shadowColor: Colors.transparent,
        elevation: AppDimensions.cardElevation,
        color: boarderColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RoundedCornersImage(
                imageHeight: imageHeight,
                imageWidth: AppDimensions.listItemWidth + .02.sw,
                image: imagePath,
                assetImage: AssetsPath.imageLoadError,
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
                                  fontFamily: AppFont.gilroyBold,
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
                                fontSize: AppDimensions.textSize10,
                                color: AppColors.textWhiteColor),
                          )
                        ],
                      ),
                      height(imageHeight! * .02),
                      SizedBox(
                        width: .5.sw,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: textWidget(
                                    text: desc,
                                    maxLines: 2,
                                    fontSize: AppDimensions.textSize10)),
                          ],
                        ),
                      ),
                      height(imageHeight! * .015),
                      textWidget(
                          text: price != null ? "\$$price" : "",
                          color: AppColors.textBlackColor,
                          fontFamily: AppFont.gilroyBold,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimensions.textSizeSmall),
                      height(imageHeight! * .02),
                      Expanded(
                        child: Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                      height(imageHeight! * .04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularCacheImageWidget(
                            showLoading: false,
                            image: userProfile,
                            assetImage: AssetsPath.placeHolder,
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
                                  fontSize: AppDimensions.textSize10,
                                  fontFamily: AppFont.gilroySemiBold,
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
                      const Spacer(),
                      height(0.01.sw),
                      InkWell(
                        onTap: isReviewed == 0 ? onTapRate : null,
                        child: Container(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.all(0.03.sw),
                          decoration: BoxDecoration(
                            color: AppColors.greenColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: textWidget(
                              text: isReviewed == 0
                                  ? AppStrings.rateAndReview
                                  : AppStrings.reviewed,
                              color: AppColors.textWhiteColor,
                              fontFamily: AppFont.gilroyBold,
                              fontSize: AppDimensions.textSize10,
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.center,
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
