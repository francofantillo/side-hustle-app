import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/job/post_job.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class ScheduledJobItemWidget extends StatelessWidget {
  final String? title, desc, price, imagePath;
  final Function()? onTap, onTapViewRequest, onTapEditJob;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const ScheduledJobItemWidget({super.key,
    this.title,
    this.desc,
    this.onTap,
    this.onTapViewRequest,
    this.onTapEditJob,
    this.price,
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
            borderRadius: BorderRadius.circular(
                AppDimensions.listItemImageRoundedBorder)),
        child: Material(
          shadowColor: Colors.transparent,
          elevation: AppDimensions.cardElevation,
          color: boarderColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  AppDimensions.listItemImageRoundedBorder)),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 6.0, bottom: 6.0, left: 6.0, right: 6),
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
                      // padding: const EdgeInsets.all(8.0),
                      padding:
                      const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: textWidget(
                                      text: title,
                                      fontFamily: AppFont.gilroyBold,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppDimensions.textSizeSmall,
                                      color: AppColors.textBlackColor)),
                            ],
                          ),
                          height(imageHeight! * .01),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: textWidget(
                                      text: desc,
                                      maxLines: 2,
                                      fontSize: AppDimensions.textSize10)),
                              width(0.02.sw),
                              IconButtonWithBackground(
                                onTap: onTapEditJob,
                                iconPath: AssetsPath.edit,
                                height: imageHeight! * .20,
                                width: imageHeight! * .20,
                                backgroundColor: AppColors.primaryColor,
                                iconColor: AppColors.whiteColor,
                              ),
                            ],
                          ),
                          height(imageHeight! * .04),
                          textWidget(
                              text: price != null ? "\$$price" : "",
                              fontFamily: AppFont.gilroyBold,
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimensions.textSizeSmall,
                              color: AppColors.textBlackColor),
                          const Spacer(),
                          height(0.01.sw),
                          InkWell(
                            onTap: onTapViewRequest,
                            child: Container(
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
                                child: Center(
                                  child: textWidget(
                                    text: AppStrings.viewRequest,
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
        ),
      ),
    );
  }
}
