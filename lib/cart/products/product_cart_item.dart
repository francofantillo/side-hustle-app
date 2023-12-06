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

class ProductCartItemWidget extends StatelessWidget {
  final String? title, subTitle, price, imagePath;
  final Function()? onTap;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const ProductCartItemWidget(
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
                        textWidget(
                            text: title,
                            fontFamily: AppFont.gilroyBold,
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.textSizeSmall,
                            color: AppColors.textBlackColor),
                        height(0.01.sw),
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
                            InkWell(
                              onTap: onTap,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: textWidget(
                                    text: price,
                                    fontFamily: AppFont.gilroyBold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppDimensions.textSizeSmall,
                                    color: AppColors.textBlackColor),
                              ),
                            ),
                          ],
                        ),
                        // height(imageHeight! * .042),
                        const Spacer(),
                        Row(
                          children: [
                            IconButtonWithBackground(
                              height: imageHeight! * .22,
                              width: .08.sw,
                              borderRadius: 10,
                              backgroundColor: AppColors.whiteColor,
                              onTap: () {
                                print("clicked minus");
                              },
                              iconPath: AssetsPath.minus,
                              iconSize: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: textWidget(
                                  text: "1",
                                  fontFamily: AppFont.gilroyBold,
                                  fontSize: AppDimensions.textSizeSmall,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textBlackColor),
                            ),
                            IconButtonWithBackground(
                              height: imageHeight! * .22,
                              width: .08.sw,
                              iconSize: 50,
                              borderRadius: 10,
                              backgroundColor: AppColors.whiteColor,
                              onTap: () {
                                print("clicked add");
                              },
                              iconPath: AssetsPath.add,
                            ),
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
      ),
    );
  }
}
