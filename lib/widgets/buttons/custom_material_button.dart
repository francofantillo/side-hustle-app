import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';

Widget customMaterialButton(
    {String? name,
    Color? color,
    textColor,
    double? width,
    double? height,
    double? borderRadius,
    double? fontSize,
    required Function() onPressed}) {
  return CustomMaterialButton(
    name: name,
    color: color,
    textColor: textColor,
    fontSize: fontSize,
    width: width,
    height: height,
    onPressed: onPressed,
    borderRadius: borderRadius,
  );
}

class CustomMaterialButton extends StatelessWidget {
  final String? name;
  final Color? color, textColor;
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
      elevation: AppDimensions.defaultButtonElevation,
      // what are the Google Material Design guidelines text field, buttons and appBar elevation
      padding: EdgeInsets.only(
        /// This was befor
        // right: width != null ? AppDimensions.buttonDefaultWidth : 0,
        // top: height != null ? AppDimensions.buttonDefaultHeight : 12,
        // bottom: height != null ? AppDimensions.buttonDefaultHeight : 12,
        // left: width != null ? AppDimensions.buttonDefaultWidth : 0,
        right: width != null ? width! : AppDimensions.buttonDefaultWidth,
        top: height != null ? height! : AppDimensions.buttonDefaultHeight,
        bottom: height != null ? height! : AppDimensions.buttonDefaultHeight,
        left: width != null ? width! : AppDimensions.buttonDefaultWidth,
      ),
      onPressed: onPressed,
      color: color ?? AppColors.primaryColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(
          borderRadius ?? 20.0,
        ),
        // Adjust the radius as needed
      ),
      child: Text(
        name ?? "",
        style: TextStyle(fontSize: fontSize ?? 20, color: textColor),
      ),
    );
  }
}
