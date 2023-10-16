import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';

class CircularImageWidget extends StatelessWidget {
  final String image;
  final double? imageSize;
  final Color? boarderColor;

  const CircularImageWidget(
      {Key? key, required this.image, this.imageSize, this.boarderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set your desired height
      width: imageSize ?? 60.h,
      // Set your desired width
      height: imageSize ?? 60.h,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.backIconBackgroundColor,
        shape: BoxShape.circle,
        // border: Border.all(
        //   color: widget.boarderColor ?? AppColors.whiteColor,
        //   // Change the border color as needed
        //   width: 1.5.h, // Use the provided border width
        // ),
        // image: DecorationImage(
        //     image: widget.image == null
        //         ? const AssetImage(AssetsPath.placeHolderProfileImage)
        //         : NetworkImage(widget.image!) as ImageProvider,
        //     fit: BoxFit.cover)
      ),
      child: Image.asset(image),
    );
  }
}
