import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/assets_path.dart';

class CircularCacheImageWidget extends StatefulWidget {
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
  State<CircularCacheImageWidget> createState() =>
      _CircularCacheImageWidgetState();
}

class _CircularCacheImageWidgetState extends State<CircularCacheImageWidget> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          // 'https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg', // Testing Url
          widget.image == null ? "" : widget.image!,
      imageBuilder: (context, imageProvider) => Container(
        width: widget.imageSize ?? 60.h, // Set your desired width
        height: widget.imageSize ?? 60.h, // Set your desired height
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.boarderColor ?? AppColors.whiteColor,
            // Change the border color as needed
            width: 1.5.h, // Use the provided border width
          ),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Container(
          width: widget.loadingWidgetSize ?? 40.h,
          // Set your desired width
          height: widget.loadingWidgetSize ?? 40.h,
          // Set your desired height
          padding: const EdgeInsets.all(8),
          child: const CircularProgressIndicator(
            color: AppColors.whiteColor,
          )),
      errorWidget: (context, url, error) => Container(
        width: 60.h, // Set your desired width
        height: 60.h, // Set your desired height
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.whiteColor,
              // Change the border color as needed
              width: 1.5.h, // Use the provided border width
            ),
            image: const DecorationImage(
                image: AssetImage(AssetsPath.profileImageJpeg),
                fit: BoxFit.cover)),
      ),
    );
  }
}
