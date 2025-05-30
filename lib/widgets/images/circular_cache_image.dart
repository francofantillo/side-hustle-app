import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/assets_path.dart';

class CircularCacheImageWidget extends StatelessWidget {
  final String? image, assetImage, fileImage;
  final double? imageHeight, imageWidth, loadingWidgetSize, borderWidth;
  final Color? boarderColor;
  final bool showLoading;

  const CircularCacheImageWidget(
      {Key? key,
      required this.showLoading,
      this.image,
      this.assetImage,
      this.fileImage,
      this.imageHeight,
      this.borderWidth,
      this.imageWidth,
      this.loadingWidgetSize,
      this.boarderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fileImage != null
        ? Container(
            width: imageWidth ?? 60.w, // Set your desired width
            height: imageHeight ?? 60.w, // Set your desired height
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: boarderColor ?? AppColors.whiteColor,
                  // Change the border color as needed
                  width: borderWidth ?? 2.w, // Use the provided border width
                ),
                image: DecorationImage(
                    // image: Image.file(File(assetImage!)),
                    image: FileImage(File(fileImage!)),
                    scale: 1,
                    fit: BoxFit.cover)),
          )
        : CachedNetworkImage(
            imageUrl:
                // Testing Url
                // 'https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg',
                image == null
                    ? "https://www.example.com/non_existent_image.jpg"
                    : image!,
            imageBuilder: (context, imageProvider) => Container(
              width: imageWidth ?? 60.w, // Set your desired width
              height: imageHeight ?? 60.w, // Set your desired height
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: boarderColor ?? AppColors.whiteColor,
                  // Change the border color as needed
                  width: borderWidth ?? 2.w, // Use the provided border width
                ),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: imageWidth ?? 60.w, // Set your desired width
                height: imageHeight ?? 60.w, // Set your desired height
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: boarderColor ?? AppColors.whiteColor,
                    // Change the border color as needed
                    width: borderWidth ?? 2.w, // Use the provided border width
                  ),
                  image: const DecorationImage(
                      image: AssetImage(AssetsPath.placeHolderProfileImage),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: imageWidth ?? 60.w, // Set your desired width
              height: imageHeight ?? 60.w, // Set your desired height
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: boarderColor ?? AppColors.whiteColor,
                    // Change the border color as needed
                    width: borderWidth ?? 2.w, // Use the provided border width
                  ),
                  image: DecorationImage(
                      // image: Image.file(File(assetImage!)),
                      image: AssetImage(
                          assetImage ?? AssetsPath.placeHolderProfileImage),
                      scale: 1,
                      fit: BoxFit.cover)),
            ),
          );
  }
}
