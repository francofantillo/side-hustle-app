import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class OrderProductItemWidget extends StatelessWidget {
  final String? title, subTitle, price, imagePath, deliveryType;
  final Function()? onTap;
  final Color? boarderColor;
  final int productsQuantity;
  final double imageHeight, imageWidth;

  const OrderProductItemWidget(
      {super.key,
      this.title,
      this.subTitle,
      this.price,
      this.deliveryType,
      this.productsQuantity = 1,
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
        // shadowColor: Colors.transparent,
        elevation: AppDimensions.cardElevation,
        color: boarderColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.listItemImageRoundedBorder),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoundedCornersImage(
                      imageHeight: imageHeight,
                      imageWidth: AppDimensions.sideHustleItemWidth,
                      assetImage: AssetsPath.imageLoadError,
                      image: imagePath,
                      boarderColor: boarderColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 6.0, left: 8, right: 8),
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
                                // Align(
                                //   alignment: Alignment.topRight,
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(right: 4.0),
                                //     child: textWidget(
                                //         text: price,
                                //         color: AppColors.blackColor,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
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
                                        fontSize:
                                            AppDimensions.textSizeVerySmall)),
                              ],
                            ),
                            height(imageHeight! * .042),
                            Expanded(
                              child: Row(
                                children: [
                                  textWidget(
                                      text: AppStrings.deliveryType,
                                      fontSize: AppDimensions.textSize10,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textBlackColor),
                                  Expanded(
                                    child: textWidget(
                                        text: deliveryType,
                                        maxLines: 1,
                                        fontSize: AppDimensions.textSize10),
                                  )
                                ],
                              ),
                            ),
                            height(imageHeight! * .042),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: imageHeight - 40,
                  width: AppDimensions.sideHustleItemWidth - 20,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: AppColors.backIconBackgroundColor,
                  ),
                  child: Material(
                    color: AppColors.backIconBackgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: InkWell(
                      // onTap: productsQuantity > 1
                      //     ? () {
                      //         Navigator.pushNamed(
                      //             context, AppRoutes.orderDetailScreenRoute);
                      //       }
                      //     : null,
                      onTap: onTap,
                      child: Center(
                        child: textWidget(
                            text: productsQuantity == 1
                                ? "$productsQuantity"
                                : "$productsQuantity+ >",
                            color: AppColors.textBlackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.textSizeNormal),
                      ),
                    ),
                  ),
                ),
              ),
              width(0.02.sw)
            ],
          ),
        ),
      ),
    );
  }
}
