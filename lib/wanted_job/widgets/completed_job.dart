import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class CompletedJobsWidget extends StatelessWidget {
  final String? title,
      subTitle,
      price,
      userProfile,
      userName,
      userRating,
      imagePath;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const CompletedJobsWidget(
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
        shadowColor: Colors.transparent,
        elevation: AppDimensions.cardElevation,
        color: boarderColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
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
                                  fontFamily: AppFont.gilroyBold,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppDimensions.textSizeSmall,
                                  color: AppColors.textBlackColor)),
                          textWidget(
                              text: price,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.textSizeSmall,
                              color: AppColors.textBlackColor),
                        ],
                      ),
                      height(0.01.sw),
                      SizedBox(
                        width: .5.sw,
                        child: textWidget(
                          text: subTitle,
                          maxLines: 2,
                          fontSize: AppDimensions.textSize10,
                        ),
                      ),
                      height(imageHeight! * .04),
                      Divider(
                        height: 1.h,
                      ),
                      height(imageHeight! * .03),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CircularCacheImageWidget(
                                  showLoading: false,
                                  image: userProfile,
                                  boarderColor: AppColors.primaryColor,
                                  imageHeight: imageHeight! * .2,
                                  imageWidth: imageHeight! * .2,
                                ),
                                width(.02.sw),
                                Expanded(
                                  child: textWidget(
                                      text: userName!,
                                      fontSize: AppDimensions.textSize10,
                                      fontFamily: AppFont.gilroySemiBold,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textBlackColor),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const ImageIcon(
                                AssetImage(
                                  AssetsPath.star,
                                ),
                                size: 16,
                                color: AppColors.ratingColor,
                              ),
                              height(0.02.sw),
                              textWidget(
                                  text: userRating,
                                  fontSize: AppDimensions.textSizeUserRating),
                            ],
                          ),
                        ],
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
