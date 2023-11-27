import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';

class IconButtonWithBackground extends StatelessWidget {
  final double? height, width, borderRadius, iconSize;
  final String iconPath;
  final Color? backgroundColor, iconColor;
  final Function()? onTap;

  const IconButtonWithBackground(
      {super.key,
      this.height,
      this.width,
      required this.iconPath,
      this.iconSize,
      this.borderRadius,
      this.onTap,
      this.backgroundColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.backIconBackgroundColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 10)),
        child: IconButton(
            onPressed: onTap,
            icon: ImageIcon(
              AssetImage(iconPath),
              color: iconColor ?? AppColors.greyColor,
              size: iconSize,
            )));
  }
}
