import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/router/app_router.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/my_behaviour.dart';
import 'package:side_hustle/utils/screen_design_size.dart';

import '../utils/app_font.dart';
import '../utils/app_size.dart';

class BaseWidget extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  const BaseWidget({super.key});

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  late final screenSize, screenWidth, screenHeight, devicePixelRatio;

  static double sh = 533.3333333333334; // Default Nexus S value
  static double sw = 320; // Default Nexus S value

  // static double sh = 0;
  // static double sw = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  setDesignSize(
      {required double screenWidth,
      required double screenHeight,
      required double dpi}) async {
    sh = await ScreenDesignSize.getSmallestHeight(
        screenHeight: screenHeight, screenWidth: screenWidth, dpi: dpi);
    sw = await ScreenDesignSize.getSmallestWidth(
        screenHeight: screenHeight, screenWidth: screenWidth, dpi: dpi);
    print("sh: $sh, sw: $sw");
    ScreenUtil.configure(designSize: Size(sw, sh));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final mediaQueryData = MediaQuery.of(context);
    final screenWidthInPixels =
        mediaQueryData.size.width * mediaQueryData.devicePixelRatio;
    final screenHeightInPixels =
        mediaQueryData.size.height * mediaQueryData.devicePixelRatio;
    final dpi = mediaQueryData.devicePixelRatio *
        160.0; // 160 is the default logical DPI

    print(
        "screenWidthInPixels: $screenWidthInPixels, screenHeightInPixels: $screenHeightInPixels, dpi: $dpi");

    setDesignSize(
        screenHeight: screenHeightInPixels,
        screenWidth: screenWidthInPixels,
        dpi: dpi);
  }

  @override
  Widget build(BuildContext context) {
    // Hide the status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return DevicePreview(
      enabled: false,
      builder: (context) {
        return ScreenUtilInit(
          // designSize: const Size(AppSize.fullScreenWidth, AppSize.fullScreenHeight),
          designSize: Size(sw, sh),
          builder: (context, child) {
            return MaterialApp(
              navigatorKey: BaseWidget.globalKey,
              theme: ThemeData(
                fontFamily: AppFont.jostRegular,
                colorScheme: ThemeData()
                    .colorScheme
                    .copyWith(primary: AppColors.primaryColor)
                    .copyWith(background: AppColors.backgroundColor),
              ),
              locale: DevicePreview.locale(context),
              builder: EasyLoading.init(builder: (context, child) {
                return (MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: child!,
                  ),
                ));
              }),
              title: AppStrings.APP_TITLE,
              debugShowCheckedModeBanner: false,
              // initialRoute: AppRoutes.splashScreenRoute,
              initialRoute: AppRoutes.postJobScreenRoute,
              onGenerateRoute: AppRouter().onGenerateRoute,
            );
          },
        );
      },
    );
  }
}
