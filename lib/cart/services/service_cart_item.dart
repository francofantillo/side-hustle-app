import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
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
                                    fontSize: AppDimensions.textSizeVerySmall),
                              )),
                          // width(0.02.sw),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              textWidget(
                                  text: price,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textBlackColor),
                              textWidget(
                                  text: AppStrings.hourlyRate,
                                  maxLines: 1,
                                  fontSize: 8.sp)
                            ],
                          ),
                        ],
                      ),
                      height(imageHeight! * .042),
                      textWidget(
                          text: AppStrings.serviceDate,
                          fontSize: AppDimensions.textSizeSmall,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlackColor),
                      height(0.015.sh),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ImageIcon(
                            const AssetImage(AssetsPath.calender),
                            size: AppDimensions.applyForJobIconSize,
                            color: AppColors.greyColorNoOpacity,
                          ),
                          width(0.02.sw),
                          Expanded(
                            child: textWidget(
                                text: AppStrings.jobDateText,
                                fontSize: AppDimensions.textSizeVerySmall),
                          ),
                        ],
                      ),
                      height(0.02.sh),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ImageIcon(
                            const AssetImage(AssetsPath.time),
                            size: AppDimensions.applyForJobIconSize,
                            color: AppColors.greyColorNoOpacity,
                          ),
                          width(0.02.sw),
                          Expanded(
                            child: textWidget(
                                text: AppStrings.eventTimeText,
                                fontSize: AppDimensions.textSizeVerySmall),
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
