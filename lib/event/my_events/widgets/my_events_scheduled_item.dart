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

class MyEventsScheduledItemsWidget extends StatelessWidget {
  final String? title, location, price, imagePath;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;
  final Function()? onTap;

  const MyEventsScheduledItemsWidget(
      {super.key,
      this.title,
      this.location,
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
                imageWidth: AppDimensions.listItemWidth,
                // assetImage: imagePath,
                assetImage: AssetsPath.imageLoadError,
                image: imagePath,
                boarderColor: boarderColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(top: 0.02.sw),
                            child: textWidget(
                                text: title,
                                fontFamily: AppFont.gilroyBold,
                                fontWeight: FontWeight.bold,
                                fontSize: AppDimensions.textSizeSmall,
                                color: AppColors.textBlackColor),
                          )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              textWidget(
                                  // text: price,
                                  text: price !=
                                      null
                                      ? "\$$price"
                                      : "",
                                  fontFamily: AppFont.gilroyBold,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppDimensions.textSizeSmall,
                                  color: AppColors.textBlackColor),
                              textWidget(
                                  text: AppStrings.perHead,
                                  textAlign: TextAlign.end,
                                  fontSize: AppDimensions.textSizeTiny),
                            ],
                          ),
                        ],
                      ),
                      height(imageHeight! * .02),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: ImageIcon(
                              const AssetImage(AssetsPath.location),
                              size: AppDimensions.eventWidgetIconSize,
                              color: AppColors.greyColorNoOpacity,
                            ),
                          ),
                          width(0.02.sw),
                          Expanded(
                              child: textWidget(
                                  text: location,
                                  maxLines: 2,
                                  fontSize: AppDimensions.textSize10)),
                        ],
                      ),
                      height(imageHeight! * .04),
                      Divider(
                        height: 1,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                      // height(imageHeight! * .03),
                      // const Spacer(),
                      // width(0.05.sw),
                      const Spacer(),
                      height(0.01.sw),
                      Container(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.all(0.03.sw),
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Material(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.circular(
                              AppDimensions.bookedJobRoundedBorder),
                          child: InkWell(
                            onTap: onTap,
                            child: Center(
                              child: textWidget(
                                text: AppStrings.viewEvent,
                                color: AppColors.textWhiteColor,
                                fontFamily: AppFont.gilroyBold,
                                fontSize: AppDimensions.textSize10,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
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
