import 'package:flutter/material.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? errorMessage;

  const CustomErrorWidget({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: textWidget(
          text: errorMessage,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w400,
          fontFamily: AppFont.gilroyBold,
          textAlign: TextAlign.center,
          fontSize: AppDimensions.textSizeNormal),
    );
  }
}
