import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/images/rounded_image_with_background_color.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class JobRequestItemWidget extends StatelessWidget {
  final String? title,
      subTitle,
      price,
      userProfile,
      userName,
      userRating,
      imagePath;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const JobRequestItemWidget(
      {super.key,
      this.title,
      this.subTitle,
      this.price,
      this.userProfile,
      this.userName,
      this.userRating,
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
          padding: const EdgeInsets.only(top: 8.0, bottom: 6.0, left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularCacheImageWidget(
                            showLoading: false,
                            image: userProfile,
                            borderWidth: 1,
                            boarderColor: AppColors.primaryColor,
                            imageHeight: imageHeight! * .26,
                            imageWidth: imageHeight! * .26,
                          ),
                          width(.01.sw),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // place RoundedImageWithBackgroundColor at end
                              textWidget(
                                  text: userName,
                                  fontSize: AppDimensions.textSizeNormal,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textBlackColor),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AssetsPath.star,
                                    height: imageHeight! * .08,
                                    width: imageHeight! * .08,
                                    color: AppColors.ratingColor,
                                  ),
                                  width(.012.sw),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: textWidget(
                                        text: userRating,
                                        fontSize:
                                            AppDimensions.textSizePerHead),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          textWidget(
                              text: price,
                              color: AppColors.textBlackColor,
                              fontWeight: FontWeight.bold),
                        ],
                      ),
                      height(0.02.sh),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                print("Clicked");
                              },
                              // highlightColor: AppColors.greenColor,
                              // splashColor: AppColors.greyColor,
                              child: Container(
                                height: 32.h,
                                padding: EdgeInsets.zero,
                                margin: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.bookedJobRoundedBorder),
                                    border: Border.all(
                                        color: AppColors
                                            .jobRequestTextBoarderColor)),
                                child: Center(
                                  child: textWidget(
                                    text: AppStrings.reject,
                                    color: AppColors.orangeColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          width(0.04.sw),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                print("Clicked");
                              },
                              highlightColor: AppColors.greenColor,
                              splashColor: AppColors.greyColor,
                              child: Container(
                                height: 32.h,
                                padding: EdgeInsets.zero,
                                margin: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  color: AppColors.greenColor,
                                  borderRadius: BorderRadius.circular(
                                      AppDimensions.bookedJobRoundedBorder),
                                ),
                                child: Center(
                                  child: textWidget(
                                    text: AppStrings.hire,
                                    color: AppColors.textWhiteColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
