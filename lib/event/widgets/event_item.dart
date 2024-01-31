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

class EventItemsWidget extends StatelessWidget {
  final String? title,
      location,
      price,
      userProfile,
      userName,
      userRating,
      imagePath;
  final int isFavourite;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;
  final Function()? onTap, onTapFav, onTapChat;

  const EventItemsWidget(
      {super.key,
      this.title,
      this.location,
      this.price,
      this.isFavourite = 0,
      this.onTap,
      this.onTapFav,
      this.onTapChat,
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
        child: Material(
          shadowColor: Colors.transparent,
          elevation: AppDimensions.cardElevation,
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
                                      text: price != null ? "\$$price" : "",
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
                                  color: AppColors.greyColorNoOpacity,
                                ),
                              ),
                              width(0.01.sw),
                              Expanded(
                                  child: textWidget(
                                text: location,
                                maxLines: 2,
                                fontSize: AppDimensions.textSize10,
                              )),
                            ],
                          ),
                          const Spacer(),
                          Divider(
                            height: 1,
                            color: Colors.grey.withOpacity(0.8),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularCacheImageWidget(
                                showLoading: false,
                                image: userProfile,
                                assetImage: AssetsPath.placeHolder,
                                boarderColor: AppColors.primaryColor,
                                imageHeight: imageHeight! * .2,
                                imageWidth: imageHeight! * .2,
                              ),
                              width(.01.sw),
                              Expanded(
                                child: Column(
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
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          AssetsPath.star,
                                          height: imageHeight! * .08,
                                          width: imageHeight! * .08,
                                          color: AppColors.ratingColor,
                                        ),
                                        width(.01.sw),
                                        textWidget(
                                            text: userRating,
                                            fontSize: AppDimensions
                                                .textSizeUserRating),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButtonWithBackground(
                                    // onTap: () {
                                    //   print("Clicked");
                                    // },
                                    onTap: onTapFav,
                                    iconPath: isFavourite == 1
                                        ? AssetsPath.favourite
                                        : AssetsPath.favUnfilled,
                                    height: imageHeight! * .2,
                                    width: imageHeight! * .2,
                                    backgroundColor: AppColors.primaryColor,
                                    iconColor: AppColors.whiteColor,
                                  ),
                                  width(0.025.sw),
                                  IconButtonWithBackground(
                                    // onTap: () {
                                    //   print("Clicked");
                                    // },
                                    onTap: onTapChat,
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
        ),
      ),
    );
  }
}
