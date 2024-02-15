import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/assets_path.dart';

class RoundedCornersImageBeta extends StatelessWidget {
  final String? image, assetImage;
  final double? imageHeight, imageWidth, loadingWidgetSize;
  final Color? boarderColor;

  const RoundedCornersImageBeta(
      {super.key,
      this.image,
      this.assetImage,
      this.imageHeight,
      this.imageWidth,
      this.loadingWidgetSize,
      this.boarderColor});

  @override
  Widget build(BuildContext context) {
    return image == null
        ? Container(
            width: imageWidth ?? 0.18.sw, // Set your desired width
            height: imageHeight ?? 0.18.sw, // Set your desired height
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(AppDimensions.homeFirstItemWidgetCurve)),
                border: Border.all(
                  color: boarderColor ?? AppColors.whiteColor,
                  // Change the border color as needed
                  width: 0.h, // Use the provided border width
                ),
                image: DecorationImage(
                    image: AssetImage(assetImage ?? AssetsPath.imageLoadError),
                    fit: BoxFit.cover)),
          )
        : image!.contains("http")
            ? CachedNetworkImage(
                imageUrl:
                    // 'https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg', // Testing Url
                    image == null
                        ? "https://www.example.com/non_existent_image.jpg"
                        : image!,
                imageBuilder: (context, imageProvider) => Container(
                  width: imageWidth ?? 0.18.sw, // Set your desired width
                  height: imageHeight ?? 0.18.sw, // Set your desired height
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.all(Radius.circular(
                        AppDimensions.homeFirstItemWidgetCurve)),
                    border: Border.all(
                      color: boarderColor ?? AppColors.whiteColor,
                      // Change the border color as needed
                      width: 1.8.h, // Use the provided border width
                    ),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                // progressIndicatorBuilder: (context, url, downloadProgress) =>
                //     CircularProgressIndicator(value: downloadProgress.progress),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: imageWidth ?? 0.18.sw, // Set your desired width
                    height: imageHeight ?? 0.18.sw, // Set your desired height
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.all(Radius.circular(
                          AppDimensions.homeFirstItemWidgetCurve)),
                      border: Border.all(
                        color: boarderColor ?? AppColors.whiteColor,
                        // Change the border color as needed
                        width: 1.8.h, // Use the provided border width
                      ),
                      image: const DecorationImage(
                          image: AssetImage(AssetsPath.placeHolderProfileImage),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: imageWidth ?? 0.18.sw, // Set your desired width
                  height: imageHeight ?? 0.18.sw, // Set your desired height
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          AppDimensions.homeFirstItemWidgetCurve)),
                      border: Border.all(
                        color: boarderColor ?? AppColors.whiteColor,
                        // Change the border color as needed
                        width: 0.h, // Use the provided border width
                      ),
                      image: DecorationImage(
                          image: AssetImage(assetImage ?? AssetsPath.homeR1),
                          fit: BoxFit.cover)),
                ),
              )
            : Container(
                width: imageWidth ?? 0.18.sw, // Set your desired width
                height: imageHeight ?? 0.18.sw, // Set your desired height
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                        AppDimensions.homeFirstItemWidgetCurve)),
                    border: Border.all(
                      color: boarderColor ?? AppColors.whiteColor,
                      // Change the border color as needed
                      width: 0.h, // Use the provided border width
                    ),
                    image: DecorationImage(
                        image: FileImage(File(image!)), fit: BoxFit.cover)),
              );
  }
}
