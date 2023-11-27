import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';

Widget textWidget(
    {String? text, double? fontSize, Color? color, String? fontFamily, FontWeight? fontWeight, TextAlign? textAlign, int? maxLines }) {
  return Text(
    text ?? "",
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily ?? AppFont.gilroyRegular,
      fontSize: fontSize ?? AppDimensions.textSizeSmall,
      color: color ?? AppColors.textGreyColor,
      fontWeight: fontWeight
    ),
  );
}
