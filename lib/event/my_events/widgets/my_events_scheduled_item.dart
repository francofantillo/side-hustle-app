import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/images/rounded_corners_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class MyEventsScheduledItemsWidget extends StatelessWidget {
  final String? title,
      subTitle,
      price,
      userProfile,
      userName,
      userRating,
      imagePath;
  final Color? boarderColor;
  final double? imageHeight, imageWidth;

  const MyEventsScheduledItemsWidget(
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
              RoundedCornersImage(
                imageHeight: imageHeight,
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
                          Expanded(
                              child: textWidget(
                                  text: title,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppDimensions.textSizeSmall,
                                  color: AppColors.textBlackColor)),
                          Column(
                            children: [
                              textWidget(
                                  text: price,
                                  color: AppColors.textBlackColor,
                                  fontWeight: FontWeight.bold),
                              textWidget(
                                  text: "per head",
                                  textAlign: TextAlign.end,
                                  fontSize: 8),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: .5.sw,
                        child: Row(
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
                                    text: subTitle,
                                    maxLines: 2,
                                    fontSize: AppDimensions.textSizeVerySmall)),
                          ],
                        ),
                      ),
                      height(imageHeight! * .04),
                      Divider(
                        height: 1.h,
                      ),
                      height(imageHeight! * .06),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            print("Clicked");
                            Navigator.pushNamed(context, AppRoutes.viewEventSelfScreenRoute);
                          },
                          highlightColor: AppColors.greenColor,
                          splashColor: AppColors.greyColor,
                          child: Container(
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.bookedJobRoundedBorder),
                            ),
                            child: Center(
                              child: textWidget(
                                text: AppStrings.viewEvent,
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
