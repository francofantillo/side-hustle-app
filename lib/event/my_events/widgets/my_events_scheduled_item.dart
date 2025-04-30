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
                assetImage: AssetsPath.imageLoadError,
                image: imagePath,
                boarderColor: boarderColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                  // Wrapping Column in a ConstrainedBox to ensure it fits available height
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: (imageHeight ?? 0) - 16, // Account for padding
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize:
                          MainAxisSize.min, // Use minimum space needed
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
                                  color: AppColors.textBlackColor,
                                  maxLines: 1,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                textWidget(
                                  text: price != null ? "\$$price" : "",
                                  fontFamily: AppFont.gilroyBold,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppDimensions.textSizeSmall,
                                  color: AppColors.textBlackColor,
                                ),
                                textWidget(
                                  text: AppStrings.perHead,
                                  textAlign: TextAlign.end,
                                  fontSize: AppDimensions.textSizeTiny,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: imageHeight! * .02),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: ImageIcon(
                                const AssetImage(AssetsPath.location),
                                size: AppDimensions.eventWidgetIconSize,
                                color: AppColors.greyColorNoOpacity,
                              ),
                            ),
                            SizedBox(width: 0.02.sw),
                            Expanded(
                              child: textWidget(
                                text: location,
                                maxLines: 1, // Limit to 1 line to save space
                                textOverflow: TextOverflow.ellipsis,
                                fontSize: AppDimensions.textSize10,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: imageHeight! * .02), // Reduced spacing
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                        const Spacer(), // This will take up remaining space
                        Container(
                          margin:
                              EdgeInsets.only(bottom: 4), // Added bottom margin
                          padding: EdgeInsets.symmetric(
                            vertical: 0.02.sw, // Reduced vertical padding
                            horizontal: 0.03.sw,
                          ),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
