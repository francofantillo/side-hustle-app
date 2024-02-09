import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class JobRequestItemWidget extends StatelessWidget {
  final String? price, userProfile, userName, userRating;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;
  final Function()? onTapHire, onTapReject;

  const JobRequestItemWidget(
      {super.key,
      this.onTapHire,
      this.onTapReject,
      this.price,
      this.userProfile,
      this.userName,
      this.userRating,
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
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularCacheImageWidget(
                          showLoading: false,
                          // image: userProfile,
                          assetImage: AssetsPath.placeHolder,
                          image: userProfile,
                          borderWidth: 1,
                          boarderColor: AppColors.primaryColor,
                          imageHeight: imageHeight! * .45,
                          imageWidth: imageHeight! * .45,
                        ),
                        width(.03.sw),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // place RoundedImageWithBackgroundColor at end
                            textWidget(
                                text: userName,
                                fontFamily: AppFont.gilroyBold,
                                fontSize: AppDimensions.textSizeNormal,
                                fontWeight: FontWeight.bold,
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
                                          AppDimensions.textSizeVerySmall),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        textWidget(
                            text: price != null ? "\$$price" : "",
                            color: AppColors.textBlackColor,
                            fontFamily: AppFont.gilroyBold,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: onTapReject,
                              child: Container(
                                // height: 32.h,
                                padding: const EdgeInsets.all(12),
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
                                    color: const Color(0xffE76161),
                                    fontSize: 12.sp,
                                    fontFamily: AppFont.gilroySemiBold,
                                    fontWeight: FontWeight.w700,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          width(0.04.sw),
                          Expanded(
                            child: Container(
                              // height: 32.h,
                              padding: const EdgeInsets.all(13),
                              margin: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.bookedJobRoundedBorder),
                              ),
                              child: InkWell(
                                onTap: onTapHire,
                                child: Center(
                                  child: textWidget(
                                    text: AppStrings.hire,
                                    color: AppColors.textWhiteColor,
                                    fontFamily: AppFont.gilroySemiBold,
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
