import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';

class CustomMaterialButton extends StatelessWidget {
  final String? name;
  final Color? color;
  final Color? textColor;
  final double? width, height, borderRadius, fontSize;
  final Function()? onPressed;

  const CustomMaterialButton(
      {super.key,
      this.name,
      this.color,
      this.textColor,
      this.borderRadius,
      this.fontSize,
      this.height,
      this.width,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: width != null ? null : 1.sw,
        // elevation: AppDimensions.defaultButtonElevation,
        elevation: 0,
        // what are the Google Material Design guidelines text field, buttons and appBar elevation
        padding: EdgeInsets.only(
          right: width != null ? width! : AppDimensions.buttonDefaultWidth,
          top: height != null ? height! : AppDimensions.buttonDefaultHeight,
          bottom: height != null ? height! : AppDimensions.buttonDefaultHeight,
          left: width != null ? width! : AppDimensions.buttonDefaultWidth,
        ),
        onPressed: onPressed,
        color: color ?? AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: color ?? AppColors.primaryColor),
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppDimensions.borderRadiusButton,
          ),
          // Adjust the radius as needed
        ),
        child: Text(
          name ?? "",
          // textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: AppFont.gilroyBold,
              color: textColor ?? Colors.white,
              // fontSize: fontSize ?? AppDimensions.textSizeNormal,
              fontWeight: FontWeight.bold),
        ));
  }
}
