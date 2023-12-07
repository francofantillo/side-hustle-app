import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenDesignSize {
  static double sh = 533.3333333333334;
  static double sw = 320.0;

  static double screenWidthInPixels = 0;
  static double screenHeightInPixels = 0;
  static double dpi = 0;

  /// Getting Device Height and Width in Pixels
  static Future getDeviceHeightAndWidthInPixels(
      {required BuildContext context}) async {
    screenWidthInPixels = 0;
    screenHeightInPixels = 0;
    dpi = 0;
    final mediaQueryData = MediaQuery.of(context);
    screenWidthInPixels =
        mediaQueryData.size.width * mediaQueryData.devicePixelRatio;
    screenHeightInPixels =
        mediaQueryData.size.height * mediaQueryData.devicePixelRatio;
    dpi = mediaQueryData.devicePixelRatio *
        160.0; // 160 is the default logical DPI

    sw = await getSmallestWidth(
        screenHeight: screenHeightInPixels,
        screenWidth: screenWidthInPixels,
        dpi: dpi);

    sh = await getSmallestHeight(
        screenHeight: screenHeightInPixels,
        screenWidth: screenWidthInPixels,
        dpi: dpi);
  }

  static Future<double> getSmallestWidth(
      {required double screenWidth,
      required double screenHeight,
      required double dpi}) async {
    sw = 0;
    final double smallestW = (screenWidth / dpi) * 160;
    print(
        "screenWidth: $screenWidth x screenHeight: $screenHeight dpi: $dpi, sw: $smallestW");

    // sw = smallestW;

    return smallestW;
  }

  static Future<double> getSmallestHeight(
      {required double screenWidth,
      required double screenHeight,
      required double dpi}) async {
    sh = 0;
    final double smallestH = (screenHeight / dpi) * 160;

    print(
        "screenWidth: $screenWidth x screenHeight: $screenHeight dpi: $dpi, sh: $smallestH");

    // sh = smallestH;

    return smallestH;
  }

  static Future setDesignSize({required BuildContext context}) async {
    await getDeviceHeightAndWidthInPixels(context: context);

    ScreenUtil.configure(designSize: Size(sw, sh));
    print("DPI: $dpi, ScreenDesignSize sh: ${ScreenDesignSize.sh}, calculated sh: $sh, ScreenDesignSize sw: ${ScreenDesignSize.sw}, calculated sw: $sw");
  }
}
