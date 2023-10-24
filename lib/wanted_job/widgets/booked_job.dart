import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/images/rounded_image_with_background_color.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class BookedJobsWidget extends StatelessWidget {
  final String? title,
      subTitle,
      price,
      imagePath;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const BookedJobsWidget(
      {super.key,
      this.title,
      this.subTitle,
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
      child: Card(
        elevation: 6,
        // color: boarderColor,
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
                assetImage: imagePath,
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
                          Expanded(child: textWidget(text: title)),
                          textWidget(text: price),
                        ],
                      ),
                      height(0.01.sw),
                      SizedBox(
                        width: .5.sw,
                        child: textWidget(text: subTitle, maxLines: 2),
                      ),
                      height(imageHeight! * .04),
                      Divider(
                        height: 1.h,
                      ),
                      height(0.01.sw),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: imageHeight! * .21,
                              width: .55.sw,
                              decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.bookedJobRoundedBorder),
                              ),
                              child: Center(
                                child: textWidget(
                                  text: AppStrings.startJob,
                                  color: AppColors.textWhiteColor,
                                  fontSize: 12.sp,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          RoundedImageWithBackgroundColor(
                            assetPath: AssetsPath.message,
                            imageHeight: imageHeight! * .08,
                            imageWidth: imageHeight! * .1,
                            backgroundColor: AppColors.primaryColor,
                            socialButtonSize: imageHeight! * .05,
                            borderRadius: 8,
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
