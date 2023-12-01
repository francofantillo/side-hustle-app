import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class OrderDetailItemWidget extends StatelessWidget {
  final String? title, subTitle, price, imagePath;
  final int qty;
  final Function()? onTap;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const OrderDetailItemWidget(
      {super.key,
        this.title,
        this.subTitle,
        this.qty = 1,
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
        shadowColor: Colors.transparent,
        elevation: AppDimensions.cardElevation,
        color: boarderColor,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RoundedCornersImage(
                imageHeight: imageHeight,
                imageWidth: AppDimensions.cartItemProductImageWidth,
                assetImage: imagePath,
                boarderColor: boarderColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: textWidget(
                                text: title,
                                fontFamily: AppFont.gilroyBold,
                                fontWeight: FontWeight.bold,
                                fontSize: AppDimensions.textSizeSmall,
                                color: AppColors.textBlackColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: textWidget(
                                text: price,
                                fontFamily: AppFont.gilroyBold,
                                fontWeight: FontWeight.bold,
                                fontSize: AppDimensions.textSizeSmall,
                                color: AppColors.textBlackColor),
                          ),
                        ],
                      ),
                      height(0.02.sw),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: textWidget(
                                    text: subTitle,
                                    maxLines: 2,
                                    fontSize: AppDimensions.textSize10),
                              )),
                          // width(0.02.sw),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: textWidget(
                                text: "$qty Qty",
                                fontFamily: AppFont.gilroyBold,
                                fontWeight: FontWeight.bold,
                                fontSize: AppDimensions.textSizeSmall,
                                color: AppColors.textBlackColor),
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
