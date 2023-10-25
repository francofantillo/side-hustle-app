import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

/// InkWell Effect not working if used this
class CustomOutlineButton extends StatelessWidget {
  final String? name;
  final double? height, width;
  final Color? outlineColor, textColor, backgroundColor;
  final Function() onTap;

  const CustomOutlineButton(
      {super.key,
      this.name,
      this.height,
      this.width,
      this.outlineColor,
      this.textColor,
      this.backgroundColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.whiteColor,
          border: Border.all(
              color: outlineColor ?? AppColors.primaryColor, width: 1.7),
          borderRadius:
              BorderRadius.circular(AppDimensions.boarderRadiusViewProduct),
        ),
        child: Center(
          child: textWidget(
            text: name ?? "",
            color: textColor ?? AppColors.primaryColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}


