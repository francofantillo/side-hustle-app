import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/assets_path.dart';

class CircularCacheImageWidget extends StatelessWidget {
  final String? image;
  final double? imageSize, loadingWidgetSize;
  final Color? boarderColor;

  const CircularCacheImageWidget(
      {Key? key,
      this.image,
      this.imageSize,
      this.loadingWidgetSize,
      this.boarderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          // 'https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg', // Testing Url
          image == null ? "" : image!,
      imageBuilder: (context, imageProvider) => Container(
        width: imageSize ?? 60.h, // Set your desired width
        height: imageSize ?? 60.h, // Set your desired height
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: boarderColor ?? AppColors.whiteColor,
            // Change the border color as needed
            width: 2.h, // Use the provided border width
          ),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Container(
          width: loadingWidgetSize ?? 40.h,
          // Set your desired width
          height: loadingWidgetSize ?? 40.h,
          // Set your desired height
          padding: const EdgeInsets.all(8),
          child: const CircularProgressIndicator(
            color: AppColors.whiteColor,
          )),
      errorWidget: (context, url, error) => Container(
        width: imageSize ?? 60.h, // Set your desired width
        height: imageSize ?? 60.h, // Set your desired height
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: boarderColor ?? AppColors.whiteColor,
              // Change the border color as needed
              width: 2.h, // Use the provided border width
            ),
            image: const DecorationImage(
                image: AssetImage(AssetsPath.placeHolderProfileImage),
                fit: BoxFit.cover)),
      ),
    );
  }
}
