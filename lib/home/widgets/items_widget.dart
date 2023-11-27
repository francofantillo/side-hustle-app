import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
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

class ItemsWidget extends StatelessWidget {
  final String? title,
      subTitle,
      price,
      userProfile,
      userName,
      userRating,
      imagePath,
      commentIconPath;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;
  final bool isEvent;
  final Function()? onTap;

  const ItemsWidget(
      {super.key,
      this.title,
      this.subTitle,
      this.onTap,
      this.price,
      this.userProfile,
      this.userName,
      this.isEvent = false,
      this.userRating,
      this.imagePath,
      this.commentIconPath,
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
        elevation: 0,
        color: boarderColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
        ),
        child: Material(
          elevation: 0,
          shadowColor: Colors.transparent,
          color: boarderColor,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
          ),
          child: InkWell(
            onTap: onTap,
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
                      // padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
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
                              Column(
                                children: [
                                  textWidget(
                                      text: price,
                                      fontFamily: AppFont.gilroyBold,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppDimensions.textSizeSmall,
                                      color: AppColors.textBlackColor),
                                  textWidget(
                                      text: isEvent
                                          ? AppStrings.perHead
                                          : AppStrings.perHour,
                                      textAlign: TextAlign.end,
                                      fontSize: AppDimensions.textSizeTiny),
                                ],
                              ),
                            ],
                          ),
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
                          height(0.015.sw),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Material(
                                color: boarderColor,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        AppRoutes.otherUserProfileScreenRoute);
                                  },
                                  child: CircularCacheImageWidget(
                                    showLoading: false,
                                    image: userProfile,
                                    // assetImage: userProfile,
                                    boarderColor: AppColors.primaryColor,
                                    imageHeight: imageHeight! * .2,
                                    imageWidth: imageHeight! * .2,
                                  ),
                                ),
                              ),
                              width(.01.sw),
                              Material(
                                color: boarderColor,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        AppRoutes.otherUserProfileScreenRoute);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // place RoundedImageWithBackgroundColor at end
                                      textWidget(
                                          text: userName,
                                          fontSize: AppDimensions.textSize10,
                                          fontFamily: AppFont.gilroySemiBold,
                                          fontWeight: FontWeight.w500,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
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
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButtonWithBackground(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          AppRoutes.favouritesScreenRoute);
                                      print("Clicked");
                                    },
                                    iconPath: AssetsPath.favUnfilled,
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
                                    iconPath:
                                        commentIconPath ?? AssetsPath.messages,
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
        ),
      ),
    );
  }
}
