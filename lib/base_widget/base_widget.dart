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

import '../utils/app_font.dart';
import '../utils/app_size.dart';

class BaseWidget extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  const BaseWidget({super.key});

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
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
          designSize: Size(AppUtils.sw, AppUtils.sh),
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
              initialRoute: AppRoutes.splashScreenRoute,
              // initialRoute: AppRoutes.homeScreenRoute,
              onGenerateRoute: AppRouter().onGenerateRoute,
            );
          },
        );
      },
    );
  }
}
