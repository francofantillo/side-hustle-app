import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class RoundedImageView extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final Color? backgroundColor;
  final double? imageHeight;
  final double? imageWidth;
  final double? socialButtonSize;

  RoundedImageView({
    this.imageUrl,
    this.assetPath,
    this.imageHeight,
    this.imageWidth,
    this.socialButtonSize,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppDimensions.defaultFocusedTextFieldElevation,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(AppDimensions.roundedImageViewBorderRadius),
      ),
      child: Container(
        padding: EdgeInsets.all(socialButtonSize ?? 0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppDimensions.roundedImageViewBorderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.roundedImageViewBorderRadius),
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  assetPath!,
                  width: imageWidth,
                  height: imageHeight,
                  // fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }
}
