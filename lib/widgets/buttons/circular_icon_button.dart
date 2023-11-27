import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final double? height, width;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;

  const CircularIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    this.height,
    this.width,
    this.iconColor = AppColors.primaryColor,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 0.11.sw, // Adjust as needed
      height: height ?? 0.11.sw, // Adjust as needed
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
