import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class RoundedImageWithBackgroundColor extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? imageHeight;
  final double? imageWidth;
  final double? borderRadius;
  final double? socialButtonSize;
  final Function()? onTap;

  const RoundedImageWithBackgroundColor({super.key,
    this.imageUrl,
    this.assetPath,
    this.imageHeight,
    this.imageWidth,
    this.borderRadius,
    this.socialButtonSize,
    this.backgroundColor,
    this.iconColor,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // shadowColor: Colors.transparent,
      elevation: AppDimensions.defaultFocusedTextFieldElevation,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(AppDimensions.roundedImageViewBorderRadius),
      ),
      child: Material(
        // shadowColor: Colors.transparent,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? AppDimensions.roundedImageViewBorderRadius),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(socialButtonSize ?? 0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(
                  borderRadius ?? AppDimensions.roundedImageViewBorderRadius),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius ?? AppDimensions.roundedImageViewBorderRadius),
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
                      color: iconColor,
                      // fit: BoxFit.contain,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
