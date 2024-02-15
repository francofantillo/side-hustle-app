import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class YourServiceItemWidget extends StatelessWidget {
  final String? title, subTitle, price, imagePath, serviceType;
  final Function()? onTap;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;
  final bool isDelete;

  const YourServiceItemWidget(
      {super.key,
      this.title,
      this.subTitle,
      this.isDelete = false,
      this.price,
      this.serviceType,
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
                imageWidth: AppDimensions.sideHustleItemWidth,
                image: imagePath,
                assetImage: AssetsPath.imageLoadError,
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
                          fontFamily: AppFont.gilroyBold,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimensions.textSizeSmall,
                          color: AppColors.textBlackColor),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: textWidget(
                                text: subTitle,
                                // text: "jfdfjd kfjdkjfkd jfkdjkfjdkfjkjf kfkj kffjf ks kdfkdjf dfdkf dfkjdkfjkjf kjfk fk fkj   s",
                                maxLines: 2,
                                fontSize: AppDimensions.textSize10),
                          ),
                          IconButtonWithBackground(
                            onTap: onTap,
                            iconPath:
                                isDelete ? AssetsPath.delete : AssetsPath.edit,
                            width: imageHeight! * .24,
                            height: imageHeight! * .24,
                            backgroundColor: isDelete
                                ? AppColors.appRedColor
                                : AppColors.primaryColor,
                            iconColor: AppColors.whiteColor,
                          )
                        ],
                      ),
                      height(imageHeight! * .042),
                      Expanded(
                        child: Row(
                          children: [
                            textWidget(
                                text: AppStrings.serviceType,
                                fontSize: AppDimensions.textSize10,
                                fontFamily: AppFont.gilroyBold,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlackColor),
                            textWidget(
                                text: serviceType,
                                maxLines: 2,
                                fontSize: AppDimensions.textSize10)
                          ],
                        ),
                      ),
                      height(imageHeight! * .042),
                      textWidget(
                          text: "\$$price",
                          fontFamily: AppFont.gilroyBold,
                          fontSize: AppDimensions.textSizeSmall,
                          fontWeight: FontWeight.bold,
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
