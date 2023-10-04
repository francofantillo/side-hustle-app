import 'dart:ui';

import 'package:flutter/material.dart';

class AppUtils {
  // static final window = WidgetsBinding.instance!.window;
  /// Without context
  /// views can be [single, first, last, firstOrNull]
  static final MediaQueryData window = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.single);

  // static Size size = WidgetsBinding.instance!.window.physicalSize;
  static Size size = PlatformDispatcher.instance.views.first.physicalSize;

  static double sh = 0;
  static double sw = 0;

  static Future<double> getSmallestWidth() async {
    sw = 0;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    final double dpi = window.devicePixelRatio * 160;
    final double smallestW = (screenWidth / dpi) * 160;
    print(
        "screenWidth: $screenWidth x screenHeight: $screenHeight dpi: $dpi\nsw: $smallestW");

    sw = smallestW;

    return smallestW;
  }

  static Future<double> getSmallestHeight() async {
    sh = 0;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    final double dpi = window.devicePixelRatio * 160;
    final double smallestH = (screenHeight / dpi) * 160;

    print(
        "screenWidth: $screenWidth x screenHeight: $screenHeight dpi: $dpi\nsh: $smallestH");

    sh = smallestH;

    return smallestH;
  }
}
