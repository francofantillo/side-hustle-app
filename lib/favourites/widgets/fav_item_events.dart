import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

import '../../utils/app_strings.dart';

class FavItemEventsWidget extends StatelessWidget {
  final String? title,
      location,
      price,
      userProfile,
      userName,
      userRating,
      imagePath;
  final Function()? onTapFav;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const FavItemEventsWidget(
      {super.key,
      this.title,
      this.location,
      this.onTapFav,
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
          padding: const EdgeInsets.only(top: 8.0, bottom: 6.0, left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RoundedCornersImage(
                imageHeight: imageHeight,
                imageWidth: AppDimensions.listItemWidth,
                image: imagePath,
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
                              child: Padding(
                            padding: EdgeInsets.only(top: 0.03.sw),
                            child: textWidget(
                                text: title,
                                fontFamily: AppFont.gilroyBold,
                                fontWeight: FontWeight.bold,
                                fontSize: AppDimensions.textSizeSmall,
                                color: AppColors.textBlackColor),
                          )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              textWidget(
                                  text: price,
                                  fontFamily: AppFont.gilroyBold,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppDimensions.textSizeSmall,
                                  color: AppColors.textBlackColor),
                              textWidget(
                                  text: AppStrings.perHead,
                                  textAlign: TextAlign.end,
                                  fontSize: AppDimensions.textSizeTiny),
                            ],
                          ),
                        ],
                      ),
                      height(imageHeight! * .02),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: ImageIcon(
                              const AssetImage(AssetsPath.location),
                              size: AppDimensions.eventWidgetIconSize,
                              // color: AppColors.greyColor,
                            ),
                          ),
                          width(0.02.sw),
                          Expanded(
                              child: textWidget(
                                  text: location,
                                  maxLines: 2,
                                  color: AppColors.textBlackColor,
                                  fontSize: AppDimensions.textSize10)),
                        ],
                      ),
                      height(imageHeight! * .04),
                      Divider(
                        height: 1,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                      const Spacer(),
                      height(imageHeight! * .04),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButtonWithBackground(
                                onTap: onTapFav,
                                iconPath: AssetsPath.favourite,
                                height: imageHeight! * .2,
                                width: imageHeight! * .2,
                                backgroundColor: AppColors.primaryColor,
                                iconColor: AppColors.whiteColor,
                              ),
                              width(0.025.sw),
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
