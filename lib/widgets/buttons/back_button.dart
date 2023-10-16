import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';

Widget backButton(Function() onPressed) {
  return CircularIconButton(
    onPressed: onPressed,
    icon: Icons.arrow_back_ios_new_sharp,
    backgroundColor: AppColors.backIconBackgroundColor,
    iconSize: 0.06.sw,
    iconColor: AppColors.primaryColor,
  );
}
