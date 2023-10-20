

class ScreenDesignSize {

  // static double sh = 0;
  // static double sw = 0;

  static double sh = 533.3333333333334;
  static double sw = 320.0;

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

}