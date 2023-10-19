import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:side_hustle/utils/app_colors.dart';

class AppUtils {

  static double sh = 0;
  static double sw = 0;

  static Future<double> getSmallestWidth(
      {required double screenWidth, required double screenHeight, required double dpi}) async {
    sw = 0;
    final double smallestW = (screenWidth / dpi) * 160;
    print(
        "screenWidth: $screenWidth x screenHeight: $screenHeight dpi: $dpi\nsw: $smallestW");

    sw = smallestW;

    return smallestW;
  }

  static Future<double> getSmallestHeight(
      {required double screenWidth, required double screenHeight, required double dpi}) async {
    sh = 0;
    final double smallestH = (screenHeight / dpi) * 160;

    print(
        "screenWidth: $screenWidth x screenHeight: $screenHeight dpi: $dpi\nsh: $smallestH");

    sh = smallestH;

    return smallestH;
  }

  static configEasyLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.transparent
      ..indicatorColor = AppColors.primaryColor
      ..textColor = Colors.white
      ..indicatorSize = 35.0
      ..radius = 10.0
      ..boxShadow = <BoxShadow>[]
      ..maskColor = Colors.black.withOpacity(0.6)
      ..maskColor = Colors.transparent
      ..userInteractions = false
      ..dismissOnTap = false;
  }
}
