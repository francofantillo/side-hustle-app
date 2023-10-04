
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class AppSize {
  static const double fullScreenHeight = 812;
  static const double fullScreenWidth = 375;
  static double logoHeight = 0.25.sh;
  static double simpleAppBarHeight = 80.h;
  static const double listTileRadius = 16.0;
  static const double dialogueRadius = 16.0;
  static const double defaultHorizontalPadding = 16;
  static spacing() {
    const SizedBox(height: AppDimensions.defaultHorizontalPadding);
  }
}