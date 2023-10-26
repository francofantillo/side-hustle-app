import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final Color backgroundColor;
  final Color? textColor;
  final String iconPath, name;
  final double? borderRadius, iconSize;
  final Function() onPressed;

  const CustomButtonWithIcon(
      {super.key,
      required this.onPressed,
      required this.backgroundColor,
      required this.iconPath,
      required this.name,
      this.borderRadius,
      this.iconSize,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, // Set the background color
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(borderRadius ?? 30.0), // Make it round
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ImageIcon(
            AssetImage(iconPath),
            color: Colors.white, // Set the icon color
            size: iconSize ?? 17,
          ),
          width(0.02.sw),
          textWidget(text: name, color: textColor ?? AppColors.textWhiteColor),
        ],
      ),
    );
  }
}
