import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/assets_path.dart';

class ImageSliderItem extends StatelessWidget {
  final String? image;
  final File? fileImage;
  final double? imageHeight, imageWidth, loadingWidgetSize;
  final Color? boarderColor;

  const ImageSliderItem(
      {super.key,
      this.image,
      this.fileImage,
      this.imageHeight,
      this.imageWidth,
      this.loadingWidgetSize,
      this.boarderColor});

  @override
  Widget build(BuildContext context) {
    print("ImageSliderItem Image: $image");
    print("ImageSliderItem fileImage: $fileImage");
    return fileImage != null
        ? AspectRatio(
            aspectRatio: 21 / 9,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppDimensions.homeFirstItemWidgetCurve)),
                  border: Border.all(
                    color: boarderColor ?? AppColors.whiteColor,
                    // Change the border color as needed
                    width: 0.h, // Use the provided border width
                  ),
                  image: DecorationImage(
                      image: FileImage(fileImage!), fit: BoxFit.cover)),
            ),
          )
        : image == null
            ? AspectRatio(
                aspectRatio: 21 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          AppDimensions.homeFirstItemWidgetCurve)),
                      border: Border.all(
                        color: boarderColor ?? AppColors.whiteColor,
                        // Change the border color as needed
                        width: 0.h, // Use the provided border width
                      ),
                      image: const DecorationImage(
                          image: AssetImage(AssetsPath.imageLoadError),
                          fit: BoxFit.cover)),
                ),
              )
            : CachedNetworkImage(
                imageUrl:
                    // 'https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg', // Testing Urls
                    image == null
                        ? "https://www.example.com/non_existent_image.jpg"
                        : image!,
                imageBuilder: (context, imageProvider) => AspectRatio(
                  aspectRatio: 21 / 9,
                  child: Container(
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
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: AspectRatio(
                    aspectRatio: 21 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            AppDimensions.homeFirstItemWidgetCurve)),
                        border: Border.all(
                          color: boarderColor ?? AppColors.whiteColor,
                          // Change the border color as needed
                          width: 1.8.h, // Use the provided border width
                        ),
                        image: const DecorationImage(
                            image: AssetImage(AssetsPath.plumber),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => AspectRatio(
                  aspectRatio: 21 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            AppDimensions.homeFirstItemWidgetCurve)),
                        border: Border.all(
                          color: boarderColor ?? AppColors.whiteColor,
                          // Change the border color as needed
                          width: 0.h, // Use the provided border width
                        ),
                        image: const DecorationImage(
                            image: AssetImage(AssetsPath.imageLoadError),
                            fit: BoxFit.cover)),
                  ),
                ),
              );
  }
}
