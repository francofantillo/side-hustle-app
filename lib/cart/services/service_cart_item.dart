import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ServiceCartItemWidget extends StatelessWidget {
  final String? title, subTitle, price, imagePath;
  final Function()? onTap;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const ServiceCartItemWidget(
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
    return Wrap(
      children: [
        Card(
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
              borderRadius: BorderRadius.circular(
                  AppDimensions.listItemImageRoundedBorder),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 8.0),
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
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textWidget(
                              text: title,
                              fontFamily: AppFont.gilroyBold,
                              fontSize: AppDimensions.textSizeSmall,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textBlackColor),
                          height(0.01.sh),
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
                                    color: const Color(0xFF565656),
                                    fontSize: AppDimensions.textSize10),
                              )),
                              // width(0.02.sw),
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     textWidget(
                              //         text: price,
                              //         fontFamily: AppFont.gilroyBold,
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: AppDimensions.textSizeNormal,
                              //         color: AppColors.textBlackColor),
                              //     textWidget(
                              //         text: AppStrings.hourlyRate,
                              //         maxLines: 1,
                              //         color: AppColors.textBlackColor,
                              //         fontSize: 8.sp)
                              //   ],
                              // ),
                            ],
                          ),
                          height(imageHeight! * .06),
                          Row(
                            children: [
                              Expanded(
                                child: textWidget(
                                    text: AppStrings.serviceDate,
                                    fontFamily: AppFont.gilroyBold,
                                    fontSize: AppDimensions.textSizeVerySmall,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textBlackColor),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  textWidget(
                                      text: price,
                                      fontFamily: AppFont.gilroyBold,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppDimensions.textSizeNormal,
                                      color: AppColors.textBlackColor),
                                  textWidget(
                                      text: AppStrings.hourlyRate,
                                      maxLines: 1,
                                      color: AppColors.textBlackColor,
                                      fontSize: 8.sp)
                                ],
                              ),
                            ],
                          ),
                          height(0.01.sw),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ImageIcon(
                                const AssetImage(AssetsPath.calender),
                                size: AppDimensions.applyForJobIconSize,
                                color: const Color(0xFF565656),
                              ),
                              width(0.02.sw),
                              Expanded(
                                child: textWidget(
                                    text: AppStrings.jobDateText,
                                    color: const Color(0xFF565656),
                                    fontSize: AppDimensions.textSize10),
                              ),
                            ],
                          ),
                          height(0.02.sw),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ImageIcon(
                                const AssetImage(AssetsPath.time),
                                size: AppDimensions.applyForJobIconSize,
                                color: const Color(0xFF565656),
                              ),
                              width(0.02.sw),
                              Expanded(
                                child: textWidget(
                                    text: AppStrings.eventTimeText,
                                    color: const Color(0xFF565656),
                                    fontSize: AppDimensions.textSize10),
                              ),
                            ],
                          ),
                          height(0.02.sw),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
