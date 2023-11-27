import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

import '../../utils/app_font.dart';

class FavItemShopsWidget extends StatelessWidget {
  final String? title,
      products,
      services,
      price,
      userProfile,
      userName,
      userRating,
      imagePath;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const FavItemShopsWidget(
      {super.key,
      this.title,
      this.products,
      this.services,
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
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
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
                          IconButtonWithBackground(
                            onTap: () {
                              print("Clicked");
                            },
                            iconPath: AssetsPath.favourite,
                            height: imageHeight! * .2,
                            width: imageHeight! * .2,
                            backgroundColor: AppColors.primaryColor,
                            iconColor: AppColors.whiteColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: .5.sw,
                        child: textWidget(
                            text: products,
                            maxLines: 1,
                            color: AppColors.textBlackColor,
                            fontSize: AppDimensions.textSize10),
                      ),
                      height(0.01.sh),
                      SizedBox(
                        width: .5.sw,
                        child: textWidget(
                            text: services,
                            maxLines: 1,
                            color: AppColors.textBlackColor,
                            fontSize: AppDimensions.textSize10),
                      ),
                      height(imageHeight! * .04),
                      Divider(
                        height: 1.h,
                      ),
                      height(imageHeight! * .04),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularCacheImageWidget(
                            showLoading: false,
                            image: userProfile,
                            boarderColor: AppColors.primaryColor,
                            imageHeight: imageHeight! * .2,
                            imageWidth: imageHeight! * .2,
                          ),
                          width(.01.sw),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // place RoundedImageWithBackgroundColor at end
                              textWidget(
                                  text: userName,
                                  fontFamily: AppFont.gilroyBold,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textBlackColor),
                              Row(
                                children: [
                                  Image.asset(
                                    AssetsPath.star,
                                    height: imageHeight! * .08,
                                    width: imageHeight! * .08,
                                    color: AppColors.ratingColor,
                                  ),
                                  width(.01.sw),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      textWidget(
                                          text: userRating, fontSize: 8.sp),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButtonWithBackground(
                            onTap: () {
                              print("Clicked");
                            },
                            iconPath: AssetsPath.message,
                            height: imageHeight! * .2,
                            width: imageHeight! * .2,
                            backgroundColor: AppColors.primaryColor,
                            iconColor: AppColors.whiteColor,
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
