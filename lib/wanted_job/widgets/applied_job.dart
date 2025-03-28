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

class AppliedJobsWidget extends StatelessWidget {
  final String? title, desc, price, imagePath;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;
  final Function()? onTap;

  const AppliedJobsWidget(
      {super.key,
      this.title,
      this.onTap,
      this.desc,
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
                  imageHeight: imageHeight,
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
                        // const Spacer(),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
                                      height: imageHeight! * .27,
                                      width: imageWidth!,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.greenColor,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(
                                            AppDimensions
                                                .appliedJobRoundedBorder),
                                      ),
                                      child: Center(
                                        child: textWidget(
                                          text: AppStrings.jobApplied,
                                          color: AppColors.greenColor,
                                          fontFamily: AppFont.gilroyBold,
                                          fontSize: 12.sp,
                                          // fontSize: AppDimensions.textSizeNormal,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
