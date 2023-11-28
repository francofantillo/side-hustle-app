import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class OrderServiceItemWidget extends StatelessWidget {
  final String? title, subTitle, price, imagePath, serviceDate, serviceTime;
  final Function()? onTap;
  final Color? boarderColor;
  final double imageHeight, imageWidth;

  const OrderServiceItemWidget(
      {super.key,
      this.title,
      this.subTitle,
      this.serviceDate,
      this.serviceTime,
      this.price,
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
                  padding: const EdgeInsets.only(top: 2.0, left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: textWidget(
                                text: title,
                                fontFamily: AppFont.gilroyBold,
                                fontSize: AppDimensions.textSizeSmall,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: textWidget(
                                  text: subTitle,
                                  maxLines: 3,
                                  fontSize: AppDimensions.textSizeTiny)),
                          width(0.02.sw),
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
                      height(imageHeight! * .042),
                      Row(
                        children: [
                          textWidget(
                              text: "${AppStrings.serviceDate}: ",
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.textSizeTiny),
                          textWidget(
                              text: serviceTime,
                              maxLines: 1,
                              fontSize: AppDimensions.textSizeTiny),
                        ],
                      ),
                      Row(
                        children: [
                          textWidget(
                              text: "${AppStrings.serviceTime}: ",
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.textSizeTiny),
                          textWidget(
                              text: serviceTime,
                              maxLines: 1,
                              fontSize: AppDimensions.textSizeTiny),
                        ],
                      )
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
