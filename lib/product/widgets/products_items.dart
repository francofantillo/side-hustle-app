import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/images/rounded_image_with_background_color.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ProductsItemsWidget extends StatelessWidget {
  final String? title, subTitle, price, imagePath;
  final Function()? onTap;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const ProductsItemsWidget(
      {super.key,
      this.title,
      this.subTitle,
      this.price,
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
                          // width(0.02.sw),
                          InkWell(
                            onTap: onTap,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: RoundedImageWithBackgroundColor(
                                assetPath: AssetsPath.add,
                                imageHeight: imageHeight! * .15,
                                imageWidth: imageHeight! * .14,
                                backgroundColor: AppColors.primaryColor,
                                socialButtonSize: imageHeight! * .04,
                                borderRadius: 8,
                              ),
                            ),
                          ),
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
