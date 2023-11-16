import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class OrderProductItemWidget extends StatelessWidget {
  final String? title, subTitle, price, imagePath, deliveryType;
  final Function()? onTap;
  final Color? boarderColor;
  final double imageHeight, imageWidth;

  const OrderProductItemWidget({super.key,
    this.title,
    this.subTitle,
    this.price,
    this.deliveryType,
    this.onTap,
    this.imagePath,
    required this.imageHeight,
    required this.imageWidth,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedCornersImage(
                imageHeight: imageHeight,
                imageWidth: AppDimensions.sideHustleItemWidth,
                assetImage: imagePath,
                boarderColor: boarderColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0, left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: textWidget(
                                text: title,
                                fontSize: AppDimensions.textSizeNormal,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: textWidget(
                                  text: price,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      height(imageHeight! * .01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: textWidget(
                                  text: subTitle,
                                  maxLines: 3,
                                  fontSize: AppDimensions.textSizeVerySmall)),
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
