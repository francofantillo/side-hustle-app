import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class BookedJobsWidget extends StatelessWidget {
  final String? title, desc, price, imagePath;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;
  final Function()? onTapStartJob, onTap;

  const BookedJobsWidget(
      {super.key,
      this.title,
      this.desc,
      this.onTapStartJob,
      this.onTap,
      this.price,
      this.imagePath,
      this.imageHeight,
      this.imageWidth,
      this.boarderColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageHeight! + 2.h,
      width: imageWidth,
      child: InkWell(
        onTap: onTap,
        child: Card(
          shadowColor: Colors.transparent,
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
                  imageHeight: imageHeight! + 2.h,
                  imageWidth: AppDimensions.listItemWidth,
                  assetImage: AssetsPath.imageLoadError,
                  image: imagePath,
                  boarderColor: boarderColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                            textWidget(
                                text: price != null ? "\$$price" : "",
                                fontFamily: AppFont.gilroyBold,
                                fontWeight: FontWeight.bold,
                                fontSize: AppDimensions.textSizeSmall,
                                color: AppColors.textBlackColor),
                          ],
                        ),
                        height(0.01.sw),
                        SizedBox(
                          width: .5.sw,
                          child: textWidget(
                            text: desc,
                            // text: "kdfdj fsjks jdkjskdj ksjdksjdkjskd jskdjksjd ksjdksjdkjskdjskdj ksjdsjdk sjdksdk",
                            maxLines: 2,
                            fontSize: AppDimensions.textSize10,
                          ),
                        ),
                        height(imageHeight! * .04),
                        Expanded(
                          child: Divider(
                            height: 1,
                            color: Colors.grey.withOpacity(0.8),
                          ),
                        ),
                        height(0.01.sw),
                        // const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  height: imageHeight! * .25,
                                  width: .55.sw,
                                  decoration: BoxDecoration(
                                    color: AppColors.greenColor,
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.buttonBorderRadius),
                                  ),
                                  child: Material(
                                    color: AppColors.greenColor,
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.bookedJobRoundedBorder),
                                    child: InkWell(
                                      onTap: onTapStartJob,
                                      child: Center(
                                        child: textWidget(
                                          text: AppStrings.startJob,
                                          color: AppColors.textWhiteColor,
                                          fontFamily: AppFont.gilroyBold,
                                          fontWeight: FontWeight.bold,
                                          maxLines: 2,
                                          fontSize: 12.sp,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            width(0.02.sw),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: IconButtonWithBackground(
                                onTap: () {
                                  print("Clicked");
                                },
                                iconPath: AssetsPath.message,
                                height: imageHeight! * .22,
                                width: imageHeight! * .22,
                                backgroundColor: AppColors.primaryColor,
                                iconColor: AppColors.whiteColor,
                              ),
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
      ),
    );
  }
}
