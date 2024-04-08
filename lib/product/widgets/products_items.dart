import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ProductsItemsWidget extends StatelessWidget {
  final String? title, subTitle, price, imagePath, deliveryType;
  final Function()? onTap, onTapAdd;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const ProductsItemsWidget(
      {super.key,
      this.title,
      this.subTitle,
      this.price,
      this.deliveryType,
      this.onTap,
      this.onTapAdd,
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
              padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 6.0),
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
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textWidget(
                              text: title,
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.textSizeSmall,
                              color: AppColors.textBlackColor),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: textWidget(
                                        text: subTitle,
                                        maxLines: 2,
                                        fontSize: AppDimensions.textSize10)),
                                width(imageWidth! * .01),
                                IconButtonWithBackground(
                                  onTap: onTapAdd,
                                  iconPath: AssetsPath.add,
                                  width: imageHeight! * .28,
                                  height: imageHeight! * .28,
                                  backgroundColor: AppColors.primaryColor,
                                  iconColor: AppColors.whiteColor,
                                )
                              ],
                            ),
                          ),
                          // height(imageHeight! * .042),
                          // Row(
                          //   children: [
                          //     textWidget(
                          //         text: AppStrings.deliveryType,
                          //         fontFamily: AppFont.gilroyBold,
                          //         fontSize: AppDimensions.textSize10,
                          //         fontWeight: FontWeight.bold,
                          //         color: AppColors.textBlackColor),
                          //     textWidget(
                          //         text: deliveryType,
                          //         maxLines: 2,
                          //         fontSize: AppDimensions.textSize10)
                          //   ],
                          // ),
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
      ),
    );
  }
}
