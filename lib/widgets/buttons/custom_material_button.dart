import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';

Widget customMaterialButton(
    {String? name,
    Color? color,
    double? width,
    double? height,
    double? borderRadius,
    required Function() onPressed}) {
  return CustomMaterialButton(
    name: name,
    color: color,
    width: width,
    height: height,
    onPressed: onPressed,
    borderRadius: borderRadius,
  );
}

class CustomMaterialButton extends StatelessWidget {
  final String? name;
  final Color? color;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Function()? onPressed;

  const CustomMaterialButton(
      {super.key,
      this.name,
      this.color,
      this.borderRadius,
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
        right: width != null ? AppDimensions.buttonDefaultWidth : 0,
        top: height != null ? AppDimensions.buttonDefaultHeight : 12,
        bottom: height != null ? AppDimensions.buttonDefaultHeight : 12,
        left: width != null ? AppDimensions.buttonDefaultWidth : 0,
      ),
      onPressed: onPressed,
      color: color ?? AppColors.primaryColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(borderRadius ?? 20.0), // Adjust the radius as needed
      ),
      child: Text(
        name ?? "",
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
