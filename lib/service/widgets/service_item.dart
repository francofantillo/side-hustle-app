import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ServiceItemsWidget extends StatelessWidget {
  final String? title, subTitle, price, imagePath, deliveryType;
  final Function()? onTap;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const ServiceItemsWidget({super.key,
    this.title,
    this.subTitle,
    this.price,
    this.deliveryType,
    this.onTap,
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
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RoundedCornersImage(
                imageHeight: imageHeight,
                imageWidth: AppDimensions.sideHustleItemWidth,
                assetImage: imagePath,
                boarderColor: boarderColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget(
                          text: title,
                          fontSize: AppDimensions.textSizeNormal,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBlackColor),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: textWidget(
                                  text: subTitle,
                                  maxLines: 2,
                                  fontSize: AppDimensions.textSizeVerySmall)),
                          IconButtonWithBackground(
                            onTap: onTap,
                            iconPath: AssetsPath.add,
                            width: imageHeight! * .24,
                            height: imageHeight! * .24,
                            backgroundColor: AppColors.primaryColor,
                            iconColor: AppColors.whiteColor,
                          )
                        ],
                      ),
                      height(imageHeight! * .042),
                      Row(
                        children: [
                          textWidget(
                              text: AppStrings.deliveryType,
                              fontSize: AppDimensions.productTextSize,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textBlackColor),
                          textWidget(
                              text: deliveryType,
                              maxLines: 2,
                              fontSize: AppDimensions.productTextSize)
                        ],
                      ),
                      height(imageHeight! * .042),
                      textWidget(
                          text: price,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBlackColor),
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
