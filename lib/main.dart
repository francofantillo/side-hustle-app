import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:side_hustle/base_widget/base_widget.dart';
import 'package:side_hustle/utils/app_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppUtils.configEasyLoading();
  HttpOverrides.global = MyHttpOverrides();

  await AppUtils.getSmallestHeight();
  await AppUtils.getSmallestWidth();

  FlutterView? flutterView = PlatformDispatcher.instance.views.firstOrNull;
  if (flutterView == null || flutterView.physicalSize.isEmpty) {
    PlatformDispatcher.instance.onMetricsChanged = () {
      flutterView = PlatformDispatcher.instance.views.firstOrNull;
      if (flutterView != null && !flutterView!.physicalSize.isEmpty) {
        print("called flutterView not null");
        PlatformDispatcher.instance.onMetricsChanged = null;
        runApp(
          const BaseWidget(),
        );
      }
    };
  } else {
    print("called flutterView null");
    runApp(
      const BaseWidget(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
