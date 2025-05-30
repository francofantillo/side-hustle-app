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
  final String? title, desc, price, imagePath, serviceType;
  final Function()? onTap;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;
  final bool isDelete;

  const YourServiceItemWidget({
    super.key,
    this.title,
    this.desc,
    this.isDelete = false,
    this.price,
    this.serviceType,
    this.onTap,
    this.imagePath,
    this.imageHeight,
    this.imageWidth,
    this.boarderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageWidth,
      constraints: BoxConstraints(
        minHeight: AppDimensions.sideHustleItemHeight,
        maxHeight: double.infinity,
      ),
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
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RoundedCornersImage(
                  imageHeight: AppDimensions.sideHustleItemHeight * 0.8,
                  imageWidth: AppDimensions.sideHustleItemWidth,
                  image: imagePath,
                  assetImage: AssetsPath.imageLoadError,
                  boarderColor: boarderColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textWidget(
                            text: title,
                            fontFamily: AppFont.gilroyBold,
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.textSizeSmall,
                            color: AppColors.textBlackColor,
                            maxLines: 2,
                            softWrap: true,
                            textOverflow: TextOverflow.ellipsis),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: textWidget(
                                      text: desc,
                                      maxLines: 2,
                                      fontSize: AppDimensions.textSize10,
                                      softWrap: true,
                                      textOverflow: TextOverflow.ellipsis)),
                              width(imageWidth! * .01),
                              IconButtonWithBackground(
                                onTap: onTap,
                                iconPath: isDelete
                                    ? AssetsPath.delete
                                    : AssetsPath.edit,
                                width: imageHeight! * .28,
                                height: imageHeight! * .28,
                                backgroundColor: isDelete
                                    ? AppColors.appRedColor
                                    : AppColors.primaryColor,
                                iconColor: AppColors.whiteColor,
                              )
                            ],
                          ),
                        ),
                        height(imageHeight! * .042),
                        Row(
                          children: [
                            textWidget(
                                text: AppStrings.serviceType,
                                fontFamily: AppFont.gilroyBold,
                                fontSize: AppDimensions.textSize10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlackColor),
                            textWidget(
                                text: serviceType,
                                maxLines: 2,
                                fontSize: AppDimensions.textSize10)
                          ],
                        ),
                        height(imageHeight! * .042),
                        textWidget(
                            text: price != null ? "\$$price" : null,
                            fontFamily: AppFont.gilroyBold,
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.textSizeSmall,
                            color: AppColors.textBlackColor),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
